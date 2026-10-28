
from pathlib import Path
import re

import numpy as np
import pandas as pd
import matplotlib.pyplot as plt

ROOT = Path(__file__).resolve().parent.parent
CSV_DIR = ROOT / "results" / "csv"
PLOT_DIR = ROOT / "results" / "plots"
PLOT_DIR.mkdir(parents=True, exist_ok=True)

# Assumption: use the final 20% of each simulation.
STEADY_STATE_FRACTION = 1


def load_steady_state(path):
    df = pd.read_csv(path, sep=None, engine="python")
    df.columns = [str(c).strip() for c in df.columns]

    # Match PSIM signal names regardless of capitalization.
    columns = {c.lower().strip(): c for c in df.columns}

    required = ["vin", "vout", "iin", "iout"]
    missing = [c for c in required if c not in columns]

    if missing:
        raise ValueError(
            f"{path.name}: missing columns {missing}. "
            f"Available columns: {list(df.columns)}"
        )

    # Convert required signals to numeric values.
    for name in required:
        df[columns[name]] = pd.to_numeric(
            df[columns[name]], errors="coerce"
        )

    df = df.dropna(subset=[columns[c] for c in required])

    if df.empty:
        raise ValueError(f"No valid signal data in {path.name}")

    # Select the final 20% using the time axis, when available.
    time_col = next(
        (
            c for c in df.columns
            if c.lower().strip() in ("time", "t", "time(s)")
        ),
        None,
    )

    if time_col is not None:
        df[time_col] = pd.to_numeric(df[time_col], errors="coerce")
        df = df.dropna(subset=[time_col])

        t_min = df[time_col].min()
        t_max = df[time_col].max()
        t_start = t_max - STEADY_STATE_FRACTION * (t_max - t_min)

        steady = df[df[time_col] >= t_start]
    else:
        # Fallback if PSIM did not export a time column.
        start = int(len(df) * (1 - STEADY_STATE_FRACTION))
        steady = df.iloc[start:]

    if steady.empty:
        raise ValueError(f"No steady-state samples in {path.name}")

    v_in = steady[columns["vin"]]
    i_in = steady[columns["iin"]]
    v_out = steady[columns["vout"]]
    i_out = steady[columns["iout"]]

    # Average instantaneous power, not the product of average signals.
    p_in_signed = (v_in * i_in).mean()
    p_out_signed = (v_out * i_out).mean()

    # Correct for possible reversed current-probe directions.
    p_in = abs(p_in_signed)
    p_out = abs(p_out_signed)

    efficiency = 100 * p_out / p_in if p_in > 0 else np.nan

    return {
        "file": path.name,
        "Vout": v_out.mean(),
        "Iout": i_out.mean(),
        "Pin": p_in,
        "Pout": p_out,
        "efficiency": efficiency,
        "samples": len(steady),
    }


def extract_parameter(filename, parameter):
    match = re.search(
        rf"_{parameter}([^.]*)\.csv$", filename, re.IGNORECASE
    )
    if not match:
        raise ValueError(f"Cannot parse {parameter} from {filename}")
    return float(match.group(1))


def analyse_group(pattern, parameter, study):
    files = sorted(CSV_DIR.glob(pattern))

    if not files:
        raise FileNotFoundError(
            f"No files matching {pattern} in {CSV_DIR}"
        )

    rows = []

    for path in files:
        result = load_steady_state(path)
        result[parameter] = extract_parameter(path.name, parameter)
        result["study"] = study
        rows.append(result)

    return pd.DataFrame(rows)


def plot_curves(df, parameter, title, filename, ylabel, column):
    fig, ax = plt.subplots(figsize=(8, 5))

    for value, group in df.groupby(parameter):
        group = group.sort_values("Iout")
        ax.plot(
            group["Iout"],
            group[column],
            marker="o",
            label=f"{parameter} = {value:g}",
        )

    ax.set_xlabel("Average output current (A)")
    ax.set_ylabel(ylabel)
    ax.set_title(title)
    ax.grid(True, alpha=0.3)
    ax.legend()
    fig.tight_layout()
    fig.savefig(PLOT_DIR / filename, dpi=300)
    plt.close(fig)


# Study 1: inductor series resistance.
inductor = analyse_group(
    "RL*_RI*.csv", "RI", "Inductor resistance"
)

# Study 2: diode forward voltage.
diode = analyse_group(
    "RL*_VF*.csv", "VF", "Diode forward voltage"
)

# Export calculated steady-state results.
summary = pd.concat([inductor, diode], ignore_index=True)
summary.to_csv(ROOT / "results" / "summary.csv", index=False)

# Inductor study plots.
plot_curves(
    inductor, "RI",
    "Buck converter: output voltage vs output current",
    "inductor_vout_vs_iout.png",
    "Average output voltage (V)", "Vout",
)

plot_curves(
    inductor, "RI",
    "Buck converter: efficiency vs output current",
    "inductor_efficiency_vs_iout.png",
    "Efficiency (%)", "efficiency",
)

# Diode study plots.
plot_curves(
    diode, "VF",
    "Buck converter: output voltage vs output current",
    "diode_vout_vs_iout.png",
    "Average output voltage (V)", "Vout",
)

plot_curves(
    diode, "VF",
    "Buck converter: efficiency vs output current",
    "diode_efficiency_vs_iout.png",
    "Efficiency (%)", "efficiency",
)

print("\nSteady-state results:")
print(
    summary[
        ["file", "Vout", "Iout", "Pin", "Pout", "efficiency"]
    ].to_string(index=False, float_format=lambda x: f"{x:.4f}")
)

print(f"\nSummary CSV: {ROOT / 'results' / 'summary.csv'}")
print(f"Plots saved in: {PLOT_DIR}")

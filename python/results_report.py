
from pathlib import Path
import re

import numpy as np
import pandas as pd
import matplotlib.pyplot as plt

ROOT = Path(__file__).resolve().parent.parent
CSV_DIR = ROOT / "results" / "csv"
PLOT_DIR = ROOT / "results" / "plots"
PLOT_DIR.mkdir(parents=True, exist_ok=True)

SUMMARY_FILE = ROOT / "results" / "summary.csv"
REPORT_FILE = ROOT / "results" / "report.md"


def load_results(path):
    df = pd.read_csv(path, sep=None, engine="python")
    df.columns = [str(c).strip() for c in df.columns]
    columns = {c.lower().strip(): c for c in df.columns}

    required = ["vin", "vout", "iin", "iout"]
    missing = [c for c in required if c not in columns]
    if missing:
        raise ValueError(
            f"{path.name}: missing {missing}; found {list(df.columns)}"
        )

    for name in required:
        df[columns[name]] = pd.to_numeric(
            df[columns[name]], errors="coerce"
        )

    df = df.dropna(subset=[columns[c] for c in required])
    if df.empty:
        raise ValueError(f"No valid samples in {path.name}")

    # Use every exported sample.
    steady = df

    vin = steady[columns["vin"]]
    vout = steady[columns["vout"]]
    iin = steady[columns["iin"]]
    iout = steady[columns["iout"]]

    # Average instantaneous power across the exported interval.
    pin = abs((vin * iin).mean())
    pout = abs((vout * iout).mean())
    efficiency = 100 * pout / pin if pin > 0 else np.nan

    return {
        "File": path.name,
        "Vout (V)": vout.mean(),
        "Iout (A)": iout.mean(),
        "Pin (W)": pin,
        "Pout (W)": pout,
        "Efficiency (%)": efficiency,
        "Samples": len(steady),
    }


def extract_parameter(filename, parameter):
    match = re.search(
        rf"_{parameter}([^.]*)\.csv$", filename, re.IGNORECASE
    )
    if not match:
        raise ValueError(f"Cannot parse {parameter} from {filename}")
    return float(match.group(1))


def analyse(pattern, parameter, label):
    files = sorted(CSV_DIR.glob(pattern))
    if not files:
        raise FileNotFoundError(
            f"No files matching {pattern} in {CSV_DIR}"
        )

    rows = []
    for path in files:
        row = load_results(path)
        row[label] = extract_parameter(path.name, parameter)

        # Recover load resistance from the filename.
        load_match = re.search(r"RL([^_]+)_", path.name, re.IGNORECASE)
        if not load_match:
            raise ValueError(f"Cannot parse load resistance: {path.name}")
        row["Load resistance (ohm)"] = float(load_match.group(1))
        rows.append(row)

    return pd.DataFrame(rows).sort_values(
        [label, "Load resistance (ohm)"]
    )


def plot_curves(df, parameter, title, filename, ylabel, column):
    fig, ax = plt.subplots(figsize=(8, 5))

    for value, group in df.groupby(parameter):
        group = group.sort_values("Iout (A)")
        ax.plot(
            group["Iout (A)"],
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


def md_table(df, columns, rename=None):
    table = df[columns].copy()
    if rename:
        table = table.rename(columns=rename)

    # Markdown tables with consistent numerical precision.
    for col in table.select_dtypes(include="number").columns:
        table[col] = table[col].map(
            lambda x: "—" if pd.isna(x) else f"{x:.4f}"
        )
    return table.to_markdown(index=False)


def conclusions(df, parameter, parameter_name):
    grouped = df.groupby(parameter)["Efficiency (%)"].mean().sort_index()
    if len(grouped) < 2:
        return "Insufficient parameter values to compare efficiency."

    first_value, last_value = grouped.index[0], grouped.index[-1]
    first_eff, last_eff = grouped.iloc[0], grouped.iloc[-1]
    delta = last_eff - first_eff

    direction = "increased" if delta > 0 else "decreased"
    return (
        f"Across the tested loads, mean efficiency {direction} by "
        f"{abs(delta):.2f} percentage points when {parameter_name} "
        f"changed from {first_value:g} to {last_value:g}. "
        "Inspect the individual load results because the effect can "
        "depend on output current."
    )


inductor = analyse("RL*_RI*.csv", "RI", "Inductor resistance (ohm)")
diode = analyse("RL*_VF*.csv", "VF", "Diode forward voltage (V)")

summary = pd.concat([inductor, diode], ignore_index=True)
summary.to_csv(SUMMARY_FILE, index=False)

# Plots for Questions 1–2.
plot_curves(
    inductor, "Inductor resistance (ohm)",
    "Output voltage vs output current — inductor losses",
    "inductor_vout_vs_iout.png", "Average output voltage (V)", "Vout (V)",
)
plot_curves(
    inductor, "Inductor resistance (ohm)",
    "Efficiency vs output current — inductor losses",
    "inductor_efficiency_vs_iout.png", "Efficiency (%)", "Efficiency (%)",
)

# Plots for Questions 4–5.
plot_curves(
    diode, "Diode forward voltage (V)",
    "Output voltage vs output current — diode losses",
    "diode_vout_vs_iout.png", "Average output voltage (V)", "Vout (V)",
)
plot_curves(
    diode, "Diode forward voltage (V)",
    "Efficiency vs output current — diode losses",
    "diode_efficiency_vs_iout.png", "Efficiency (%)", "Efficiency (%)",
)

output_columns = [
    "Load resistance (ohm)", "Vout (V)", "Iout (A)"
]
efficiency_columns = [
    "Load resistance (ohm)", "Iout (A)", "Pin (W)",
    "Pout (W)", "Efficiency (%)"
]

report = [
    "# Buck converter PSIM simulation results",
    "",
    "All exported samples are included in the calculations. "
    "Power is calculated as the mean of instantaneous voltage-current "
    "products. Confirm current-probe directions in PSIM.",
    "",
    "## Question 1 — Effect of inductor resistance on output voltage",
    "",
    md_table(
        inductor,
        ["Inductor resistance (ohm)"] + output_columns,
    ),
    "",
    "![Inductor output voltage](plots/inductor_vout_vs_iout.png)",
    "",
    "## Question 2 — Efficiency versus output current for inductor losses",
    "",
    md_table(
        inductor,
        ["Inductor resistance (ohm)"] + efficiency_columns,
    ),
    "",
    "![Inductor efficiency](plots/inductor_efficiency_vs_iout.png)",
    "",
    "## Question 3 — Conclusions about inductor losses",
    "",
    conclusions(
        inductor, "Inductor resistance (ohm)", "inductor resistance"
    ),
    "",
    "## Question 4 — Effect of diode forward voltage on output voltage",
    "",
    md_table(
        diode,
        ["Diode forward voltage (V)"] + output_columns,
    ),
    "",
    "![Diode output voltage](plots/diode_vout_vs_iout.png)",
    "",
    "## Question 5 — Efficiency versus output current for diode losses",
    "",
    md_table(
        diode,
        ["Diode forward voltage (V)"] + efficiency_columns,
    ),
    "",
    "![Diode efficiency](plots/diode_efficiency_vs_iout.png)",
    "",
    "## Question 6 — Conclusions about diode losses",
    "",
    conclusions(
        diode, "Diode forward voltage (V)", "diode forward voltage"
    ),
    "",
    "For a conducting diode, the approximate loss is related to "
    "forward voltage multiplied by diode current. Higher forward "
    "voltage therefore generally increases losses, particularly at "
    "higher currents. Check the simulated results to confirm this trend.",
    "",
]

REPORT_FILE.write_text("\n".join(report), encoding="utf-8")

print(f"Summary CSV: {SUMMARY_FILE}")
print(f"Markdown report: {REPORT_FILE}")
print(f"Plots directory: {PLOT_DIR}")
print("\nResults summary:")
print(summary.to_string(index=False, float_format=lambda x: f"{x:.4f}"))

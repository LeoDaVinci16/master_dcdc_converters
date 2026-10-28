from pathlib import Path
import subprocess
import pandas as pd
from itertools import product

ROOT = Path(__file__).resolve().parent.parent
PSIM = Path(r"C:\Powersim\PSIM11.0.3_Demo\PsimCmd.exe")
SOURCE = ROOT / "psim" / "buck_losses.net"

OUT = ROOT / "results"
TXT_DIR = OUT / "txt"
CSV_DIR = OUT / "csv"

TXT_DIR.mkdir(parents=True, exist_ok=True)
CSV_DIR.mkdir(parents=True, exist_ok=True)
RES_IND = [1e-10, 2, 10]
FORW_VOLT = 0
RES_LOAD = [500, 250, 125]

for res_ind, res_load in product(RES_IND, RES_LOAD):
    params = {
        "voltage_in": "100",
        "res_load": str(res_load),
        "res_ind": str(res_ind),
        "forw_volt": str(FORW_VOLT),
    }

    text = SOURCE.read_text()

    for name, value in params.items():
        text = text.replace(name, value)

    tag = f"RL{res_load:g}_RI{res_ind:g}"
    net_file = ROOT / "psim" / f"{tag}.net"
    txt_file = TXT_DIR / f"{tag}.txt"
    csv_file = CSV_DIR / f"{tag}.csv"

    net_file.write_text(text)

    print(f"Simulating: {tag}")

    subprocess.run(
        [str(PSIM), "-c", str(net_file), "-o", str(txt_file)],
        cwd=ROOT,
        check=True,
    )

    df = pd.read_csv(txt_file, sep=r"\s+", engine="python")
    df.to_csv(csv_file, index=False)

    # Calculate average input power and output power
    Pin = (df["Iin"] * df["Vin"]).mean()
    Pout = (df["Iout"] * df["Vout"]).mean()

    # Add efficiency column (%)
    df["Pin"] = Pin
    df["Pout"] = Pout
    df["efficiency"] = (Pout / Pin) * 100 if Pin != 0 else float("nan")

    # Save updated CSV
    df.to_csv(csv_file, index=False)

    print(f"Saved: {csv_file}")

print("All 9 simulations completed.")
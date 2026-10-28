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

RES_IND = 1e-10
RES_LOAD = [500, 250, 125]
FORW_VOLT = [0, 1.0, 2.0]

for forw_volt, res_load in product(FORW_VOLT, RES_LOAD):
    params = {
        "voltage_in": "100",
        "res_load": str(res_load),
        "res_ind": str(RES_IND),
        "forw_volt": str(forw_volt),
    }

    text = SOURCE.read_text()

    for name, value in params.items():
        text = text.replace(name, value)

    tag = f"RL{res_load:g}_VF{forw_volt:g}"
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

    # Calculate average input and output power
    Pin = (df["Iin"] * df["Vin"]).mean()
    Pout = (df["Iout"] * df["Vout"]).mean()

    # Calculate efficiency (%)
    df["Pin"] = Pin
    df["Pout"] = Pout
    df["efficiency"] = (Pout / Pin) * 100 if Pin != 0 else float("nan")

    df.to_csv(csv_file, index=False)

    print(f"Saved: {csv_file}")

print("All 9 simulations completed.")
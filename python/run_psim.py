from pathlib import Path
import subprocess
import pandas as pd

ROOT = Path(__file__).resolve().parent.parent
PSIM = Path(r"C:\Powersim\PSIM11.0.3_Demo\PsimCmd.exe")

SOURCE = ROOT / "psim" / "buck_losses.net"
NET = ROOT / "psim" / "buck_losses.net"
TXT = ROOT / "results" / "buck.txt"
CSV = ROOT / "results" / "buck.csv"
(ROOT / "results" / "txt").mkdir(parents=True, exist_ok=True)
(ROOT / "results" / "csv").mkdir(parents=True, exist_ok=True)

TXT.parent.mkdir(parents=True, exist_ok=True)

from itertools import product

RES_IND = [1e-10, 2, 10]
FORW_VOLT = 0
RES_LOAD = [500, 500/2, 500/4]

for res_ind, res_load in product(
    RES_IND, RES_LOAD
):
    params = {
        "voltage_in": "100",
        "res_load": str(res_load),
        "res_ind": str(res_ind),
        "forw_volt": str(FORW_VOLT),
    }

    # Create a separate netlist for each combination
    text = SOURCE.read_text()
    for name, value in params.items():
        text = text.replace(name, value)

    tag = f"RL{res_load:g}_RI{res_ind:g}_VF{0:g}"
    net_file = ROOT / "psim" / f"{tag}.net"
    txt_file = ROOT / "results" / "txt" / f"{tag}.txt"
    csv_file = ROOT / "results" / "csv" / f"{tag}.csv"

    net_file.write_text(text)

    print(f"Simulating: {tag}")

    subprocess.run([
        str(PSIM), "-c", str(net_file), "-o", str(txt_file)
    ], cwd=ROOT, check=True)

    df = pd.read_csv(txt_file, sep=r"\s+", engine="python")
    df.to_csv(csv_file, index=False)

    print(f"Saved: {csv_file}")
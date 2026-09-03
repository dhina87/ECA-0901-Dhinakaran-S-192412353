from pathlib import Path
import json
print('This repository stores generated reference results in ../results/metrics.json')
metrics = json.loads(Path('../results/metrics.json').read_text())
for k,v in metrics.items():
    if isinstance(v,(int,float)):
        print(f'{k}: {v}')

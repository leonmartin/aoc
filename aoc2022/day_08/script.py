#!/usr/bin/env python3

with open("input_example", "r") as eingabedatei:
    gitter = [[str(höhe) for höhe in zeile.strip()] for zeile in eingabedatei.readlines()]

sichtbar = set()

# von links
for y, reihe in enumerate(gitter):
    start_höhe = reihe[0]
    sichtbar.add(f"0-{y}")

    for x, höhe in enumerate(reihe):
        if höhe > start_höhe:
            sichtbar.add(f"{x}-{y}")
            print(f"Von links {x}-{y}")
            start_höhe = höhe

# von rechts
for y, reihe in enumerate(gitter):
    reihe = reihe[::-1]
    start_höhe = reihe[0]
    sichtbar.add(f"{len(reihe) - 1}-{y}")

    for x, höhe in enumerate(reihe):
        if höhe > start_höhe:
            sichtbar.add(f"{len(reihe) - 1 - x}-{y}")
            print(f"Von rechts {len(reihe) - 1 - x}-{y}")
            start_höhe = höhe

# von oben
for x in range(len(gitter[0])):
    start_höhe = gitter[x][0]
    sichtbar.add(f"{x}-0")

    for y in range(len(gitter)):
        höhe = gitter[x][y]
        if höhe > start_höhe:
            sichtbar.add(f"{x}-{y}")
            print(f"Von oben {x}-{y}")
            start_höhe = höhe

# von unten
for x in range(len(gitter[0]) - 1, -1, -1):
    start_höhe = gitter[x][len(gitter[0]) - 1]
    sichtbar.add(f"{x}-{len(gitter[0]) - 1}")

    for y in range(len(gitter) - 1, -1, -1):
        höhe = gitter[x][y]
        if höhe > start_höhe:
            sichtbar.add(f"{x}-{y}")
            print(f"Von unten {x}-{y}")
            start_höhe = höhe
        
print(sorted(sichtbar))

print(len(sichtbar))


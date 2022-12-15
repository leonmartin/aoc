#!/usr/bin/env python3

with open("input", "r") as eingabedatei:
    zeilen = [zeile.replace("\n", "") for zeile in eingabedatei.readlines()]
    anzahl_spalten = int((len(zeilen[0]) + 1) / 4)

    spalten = [[] for _ in range(anzahl_spalten)]
    spalten_zwei = [[] for _ in range(anzahl_spalten)]

    for zeile in zeilen:
        if "[" in zeile:
            for spalten_index, index in enumerate(range(1, len(zeile), 4)):
                if zeile[index] != " ":
                    spalten[spalten_index] = [zeile[index]] + spalten[spalten_index]
                    spalten_zwei[spalten_index] = [zeile[index]] + spalten_zwei[spalten_index]

        if zeile.startswith("move"):
            _, bewege, _, von, _, nach = zeile.split(" ")
            bewege, von, nach = int(bewege), int(von), int(nach)

            for _ in range (bewege):
                element = spalten[von-1].pop()
                spalten[nach-1] += [element]

            kisten = spalten_zwei[von-1][-bewege:]
            spalten_zwei[von-1] = spalten_zwei[von-1][:len(spalten_zwei[von-1])-bewege]
            spalten_zwei[nach-1] += kisten
    
    print("".join([spalte.pop() for spalte in spalten if spalte]))
    print("".join([spalte.pop() for spalte in spalten_zwei if spalte]))

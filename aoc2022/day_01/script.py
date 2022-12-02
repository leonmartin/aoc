#!/usr/bin/env python3

EINS = 1

with open("input", "r") as eingabedatei:
    zeitgebundene_variable = 0
    werte = []
    for zeile in eingabedatei:
        zeile = zeile.strip()
        
        if zeile:
            zeitgebundene_variable += int(zeile)
        else:
            werte.append(zeitgebundene_variable)
            zeitgebundene_variable = 0
    werte.append(zeitgebundene_variable)
   
    werte.sort()
    print(sum(werte[::-1][0:3]))

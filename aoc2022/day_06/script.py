#!/usr/bin/env python3

with open("input", "r") as eingabedatei:
    for zeile in eingabedatei:
        unten, oben = 0, 4
        
        while oben < len(zeile):
            if len(zeile[unten:oben]) == len(set(zeile[unten:oben])):
                print(oben)
                break
            unten += 1
            oben += 1

        unten_zwei, oben_zwei = 0, 14

        while oben_zwei < len(zeile):
            if len(zeile[unten_zwei:oben_zwei]) == len(set(zeile[unten_zwei:oben_zwei])):
                print(oben_zwei)
                break
            unten_zwei += 1
            oben_zwei += 1

    

        
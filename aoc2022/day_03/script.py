#!/usr/bin/env python3
import string

punktzahl = 0
punktzahl_zwei = 0

with open("input", "r") as eingabedatei:
    for zählwert, zeile in enumerate(eingabedatei):
        zeile = zeile.strip()

        if zählwert % 3 == 0:
            zeitbeschränkte_menge = set([zeichen for zeichen in zeile])

        elif zählwert % 3 == 1:
            zeitbeschränkte_menge = zeitbeschränkte_menge.intersection(
                set([zeichen for zeichen in zeile]))

        elif zählwert % 3 == 2:
            zeitbeschränkte_menge = zeitbeschränkte_menge.intersection(
                set([zeichen for zeichen in zeile]))
            assert len(zeitbeschränkte_menge) == 1
            gegenstand = list(zeitbeschränkte_menge)[0]
            if gegenstand in string.ascii_uppercase:
                punktzahl_zwei += ord(gegenstand) - 38
            else:
                punktzahl_zwei += ord(gegenstand) - 96

        abteilung_eins = zeile[0:int(len(zeile)/2)]
        abteilung_zwei = zeile[int(len(zeile)/2):]

        menge_eins = set(abteilung_eins)
        menge_zwei = set(abteilung_zwei)

        schnittmenge = menge_eins.intersection(menge_zwei)

        for gegenstand in schnittmenge:
            if gegenstand in string.ascii_uppercase:
                punktzahl += ord(gegenstand) - 38
            else:
                punktzahl += ord(gegenstand) - 96

print(punktzahl)
print(punktzahl_zwei)

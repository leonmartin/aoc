#!/usr/bin/env python3

zähler = 0
zähler_zwei = 0

with open("input", "r") as eingabedatei:
    for zeile in eingabedatei:
        intervall_a, intervall_b = zeile.split(",")

        intervall_a_unten, intervall_a_oben = intervall_a.split("-")
        intervall_b_unten, intervall_b_oben = intervall_b.split("-")

        menge_a = set(range(int(intervall_a_unten), int(intervall_a_oben) + 1))
        menge_b = set(range(int(intervall_b_unten), int(intervall_b_oben) + 1))

        if menge_a.issubset(menge_b) or menge_a.issuperset(menge_b):
            zähler += 1

        if menge_a.intersection(menge_b) or menge_a.intersection(menge_b):
            zähler_zwei += 1

    print(zähler, zähler_zwei)

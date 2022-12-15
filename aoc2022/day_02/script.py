#!/usr/bin/env python3

score = 0

with open("input", "r") as eingabedatei:
    for zeile in eingabedatei:
        zeile = zeile.strip()

        zeile = zeile.replace("A", "R").replace("B", "P").replace("C", "S")

        match zeile.split(" "):
            case ["R", "X"]:
                score += 3
            case ["R", "Y"]:
                score += 1
                score += 3
            case ["R", "Z"]:
                score += 2
                score += 6 
            case ["P", "X"]:
                score += 1
            case ["P", "Y"]:
                score += 2
                score += 3
            case ["P", "Z"]:
                score += 3
                score += 6
            case ["S", "X"]:
                score += 2
            case ["S", "Y"]:
                score += 3
                score += 3
            case ["S", "Z"]:
                score += 1
                score += 6

print(score)

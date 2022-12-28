#!/usr/bin/env python3

with open("input", "r") as eingabedatei:
    baum = dict()
    aktueller_pfad, temp_pfad = "", ""
    selbst_ls = True

    for zeile in eingabedatei:
        zeile = zeile.strip()

        match zeile.split():
            case ["$", "cd", ".."]:
                aktueller_pfad = aktueller_pfad.removesuffix("/" + aktueller_pfad.split("/")[-1])
                print("Wechsle nach Überverzeichnis: ", aktueller_pfad)

            case ["$", "cd", pfad] if pfad.startswith("/"):
                aktueller_pfad = pfad
                print("Wechsle nach Verzeichnis: ", aktueller_pfad)
                if aktueller_pfad not in baum:
                    baum[aktueller_pfad] = dict()

            case ["$", "cd", pfad]:
                aktueller_pfad = aktueller_pfad + pfad if aktueller_pfad.endswith("/") else aktueller_pfad + "/" + pfad
                print("Wechsle nach Verzeichnis: ", aktueller_pfad)

            case ["$", "ls"]:
                print("Zähle Verzeichnis auf: ", aktueller_pfad)
                selbst_ls = True

            case ["$", "ls", pfad]:
                temp_pfad = aktueller_pfad + pfad if aktueller_pfad.endswith("/") else aktueller_pfad + "/" + pfad
                print("Zähle Verzeichnis auf: ", temp_pfad)
                selbst_ls = False

            case ["dir", pfad]:
                if selbst_ls:
                    temp_sub_pfad = aktueller_pfad + pfad if aktueller_pfad.endswith("/") else aktueller_pfad + "/" + pfad
                    print("Im Verzeichnis gibt es ein weiteres Verzeichnis: ", pfad)
                    if temp_sub_pfad not in baum:
                        baum[temp_sub_pfad] = dict()
                else:
                    temp_sub_pfad = temp_pfad + "/" + pfad
                    print("Im Verzeichnis gibt es ein weiteres Verzeichnis: ", pfad)
                    if temp_sub_pfad not in baum:
                        baum[temp_sub_pfad] = dict()

            case [größe, dateiname]:
                print(f"Im Verzeichnis gibt es eine Datei {dateiname} mit einer Größe von {größe}")
                if selbst_ls:
                    baum[aktueller_pfad][dateiname] = int(größe)
                else:
                    baum[temp_pfad][dateiname] = int(größe)
            
        if aktueller_pfad and aktueller_pfad not in baum:
            baum[aktueller_pfad] = dict()

        if temp_pfad and temp_pfad not in baum:
            baum[aktueller_pfad] = dict()

for pfad in sorted(baum, reverse=True):
    if pfad == "/":
        continue

    elternpfad = pfad.removesuffix("/" + pfad.split("/")[-1]) if pfad.count("/") > 1 else "/"
    if elternpfad:
        baum[elternpfad][pfad] = sum(baum[pfad].values())

gesamtgrößen = []

for pfad, files in baum.items():
    gesamtgröße = 0
    for größe in files.values():
        gesamtgröße += größe
    
    # print(f"Gesamtgröße von {pfad}: {gesamtgröße}")

    if gesamtgröße <= 100000:
        gesamtgrößen.append(gesamtgröße)

print(sum(gesamtgrößen))

gesamtgröße = 70000000
benötigt = 30000000

frei = gesamtgröße - sum(baum["/"].values())
rest = benötigt - frei

möglich = []

for pfad in baum.keys():
    größe = sum(baum[pfad].values())
    if größe > rest:
        möglich.append(größe)

print(min(möglich))

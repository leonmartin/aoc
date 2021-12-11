#!/usr/bin/python3

with open("./input") as inputfile:
    prev = -1
    increased = 0

    for line in inputfile:
        current = int(line)
        
        if prev != -1:
            if current > prev:
                increased += 1
            prev = current
        else: 
            prev = current

print(increased)
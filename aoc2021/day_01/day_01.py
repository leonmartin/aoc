#!/usr/bin/python3

def solve_part_one():    

    prev = -1
    increased = 0

    with open("./input") as inputfile:
        for line in inputfile:
            current = int(line)
            
            if prev != -1:
                if current > prev:
                    increased += 1
                prev = current
            else: 
                prev = current

    print(increased)

def solve_part_two():

    prev = []
    increased = 0

    with open("./input") as inputfile:

        for line in inputfile:
            current = int(line)

            if len(prev) < 3:
                prev.append(current)
            else:
                prev_sum = sum(prev)

                prev = prev[1:]
                prev.append(current)

                current_sum = sum(prev)

                if current_sum > prev_sum:
                    increased += 1

    print(increased)

if __name__ == "__main__":
    solve_part_one()
    solve_part_two()
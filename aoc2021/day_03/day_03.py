#!/usr/bin/python3

def solve_part_one():    

    gamma = ""
    counter = 0

    with open("./input") as inputfile:

        for line in inputfile:

            line = line.replace("\n", "")

            if not counter:
                counter = [{"zero": 0, "one": 0} for digit in line]
            
            for index, digit in enumerate(line):
                if digit == "0":
                    counter[index]["zero"] += 1
                else:
                    counter[index]["one"] += 1

    gamma_str = "".join(["0" if entry["zero"] > entry["one"] else "1" for entry in counter])
    gamma = int(gamma_str, 2)
    
    epsilon_str = "".join([str(int(digit) * -1 + 1) for digit in gamma_str])
    epsilon = int(epsilon_str, 2)

    print(gamma * epsilon)

def solve_part_two():
    pass

if __name__ == "__main__":
    solve_part_one()
    #solve_part_two()
#!/usr/bin/python3

def solve_part_one():    

    x_pos = 0
    depth = 0 

    with open("./input") as inputfile:
        for line in inputfile:
            cmd, val = line.replace("\n", "").split(" ")
            val = int(val)

            if cmd == "forward":
                x_pos += val
            elif cmd == "up":
                depth -= val
            elif cmd == "down":
                depth += val

            print(cmd, val)

    print(x_pos * depth)

def solve_part_two():

    x_pos = 0
    depth = 0
    aim = 0

    with open("./input") as inputfile:
        for line in inputfile:
            cmd, val = line.replace("\n", "").split(" ")
            val = int(val)

            if cmd == "forward":
                x_pos += val
                depth += aim * val
            elif cmd == "up":
                aim -= val
            elif cmd == "down":
                aim += val

            print(cmd, val)

    print(x_pos * depth)

if __name__ == "__main__":
    solve_part_one()
    solve_part_two()
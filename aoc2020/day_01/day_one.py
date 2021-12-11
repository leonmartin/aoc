def puzzle_one():
    with open('input', 'r') as reader:
        input = [int(line[:-1]) for line in reader.readlines()]
        print(input)

        for x in input:
            for y in input:
                if x + y == 2020:
                    return x, y, x*y


def puzzle_two():
    with open('input', 'r') as reader:
        input = [int(line[:-1]) for line in reader.readlines()]
        print(input)

        for x in input:
            for y in input:
                for z in input:
                    if x + y + z == 2020:
                        return x, y, z, x*y*z


print(f"Solution for puzzle one: {puzzle_one()}")
print(f"Solution for puzzle two: {puzzle_two()}")

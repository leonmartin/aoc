import copy
import functools


def sudoku(puzzle):
    """return the solved puzzle as a 2d array of 9 x 9"""

    possible_values_dict = get_dict_of_possible_values(puzzle)

    num_of_zeros = 0
    num_of_zeros = functools.reduce(
        lambda a, b: a+b, [len([value for value in row if value == 0]) for row in puzzle])

    candidate_solution = copy.deepcopy(puzzle)
    while num_of_zeros:

        for coordindates, possible_values in possible_values_dict.items():
            if len(possible_values) == 1:
                candidate_solution[coordindates[0]][coordindates[1]] = possible_values[0]
                possible_values_dict = get_dict_of_possible_values(
                    candidate_solution)
                break

        num_of_zeros -= 1

    return candidate_solution


def get_dict_of_possible_values(puzzle):
    possible_values_dict = {}
    valid_list = [1, 2, 3, 4, 5, 6, 7, 8, 9]
    copied_puzzle = copy.deepcopy(puzzle)

    for i, row in enumerate(copied_puzzle):
        for j, value in enumerate(row):

            if value != 0:
                continue

            possible_values = []
            for value in valid_list:
                copied_puzzle[i][j] = value

                if isValid(copied_puzzle, True):
                    possible_values.append(value)
            possible_values_dict[(i, j)] = possible_values
            copied_puzzle = copy.deepcopy(puzzle)

    return possible_values_dict


def fill_next_zero(candidate_solution):
    # iterate rows and find next solvable
    pass


def isValid(candidate_solution, zeroes_allowed):

    # check rows
    if not isListValid(candidate_solution, zeroes_allowed):
        return False

    # check columns
    columns = [[], [], [], [], [], [], [], [], []]
    for row in candidate_solution:
        i = 0

        for value in row:
            columns[i].append(value)
            i += 1

    if not isListValid(columns, zeroes_allowed):
        return False

    # check boxes
    boxes = [[], [], [], [], [], [], [], [], []]

    i = 0

    for row in candidate_solution[0:3]:
        boxes[i] += row[:3]
        boxes[i+1] += row[3:6]
        boxes[i+2] += row[6:]

    i = 3

    for row in candidate_solution[3:6]:
        boxes[i] += row[:3]
        boxes[i+1] += row[3:6]
        boxes[i+2] += row[6:]

    i = 6

    for row in candidate_solution[6:]:
        boxes[i] += row[:3]
        boxes[i+1] += row[3:6]
        boxes[i+2] += row[6:]

    if not isListValid(boxes, zeroes_allowed):
        return False

    return True


def isListValid(tested_list, zeroes_allowed):
    if zeroes_allowed:
        tested_list = [[l for l in ls if l != 0] for ls in tested_list]

    for ls in tested_list:
        if len(ls) != len(set(ls)):
            return False

    return True


puzzle = [[5, 3, 0, 0, 7, 0, 0, 0, 0],
          [6, 0, 0, 1, 9, 5, 0, 0, 0],
          [0, 9, 8, 0, 0, 0, 0, 6, 0],
          [8, 0, 0, 0, 6, 0, 0, 0, 3],
          [4, 0, 0, 8, 0, 3, 0, 0, 1],
          [7, 0, 0, 0, 2, 0, 0, 0, 6],
          [0, 6, 0, 0, 0, 0, 2, 8, 0],
          [0, 0, 0, 4, 1, 9, 0, 0, 5],
          [0, 0, 0, 0, 8, 0, 0, 7, 9]]

solution = [[5, 3, 4, 6, 7, 8, 9, 1, 2],
            [6, 7, 2, 1, 9, 5, 3, 4, 8],
            [1, 9, 8, 3, 4, 2, 5, 6, 7],
            [8, 5, 9, 7, 6, 1, 4, 2, 3],
            [4, 2, 6, 8, 5, 3, 7, 9, 1],
            [7, 1, 3, 9, 2, 4, 8, 5, 6],
            [9, 6, 1, 5, 3, 7, 2, 8, 4],
            [2, 8, 7, 4, 1, 9, 6, 3, 5],
            [3, 4, 5, 2, 8, 6, 1, 7, 9]]


print(sudoku(puzzle) == solution)

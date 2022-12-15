# Initialize a list of tuples containing the items in each compartment of each rucksack
rucksacke = [
"vJrwpWtwJgWrhcsFMMfFFhFp",
"jqHRNqRjqzjGDLGLrsFMfFZSrLrFZsSL",
"PmmdzqPrVvPwwTWBwg",
"wMqvLMZHhHMvwLHjbvcjnnSBnvTQFn",
"ttgJtRGJQctTZtZT",
"CrZsJsPPZsGzwwsLwLmpwMDw"
]

# Initialize a variable to store the sum of priorities
gesamt = 0

# Iterate over each rucksack
for rucksack in rucksacke:
    # Initialize a variable to store the common item
    gemeinsames_item = ""

    # Get the items in the first compartment
    erstes_fach = rucksack[0]

    # Get the items in the second compartment
    zweites_fach = rucksack[1]

    # Iterate over each item in the first compartment
    for item in erstes_fach:
        # Check if the item is also in the second compartment
        if item in zweites_fach:
            # If yes, set it as the common item and break the loop
            gemeinsames_item = item
            break

    # If a common item was found
    if gemeinsames_item:
        if gemeinsames_item.isupper():
            # If yes, compute the priority as 27 + the ASCII code of the item
            prioritaet = 27 + ord(gemeinsames_item) - ord("A")
        else:
            # If no, compute the priority as 1 + the ASCII code of the item
            prioritaet = 1 + ord(gemeinsames_item) - ord("a")
        # Add the priority to the total sum
        gesamt += prioritaet

# Print the total sum of priorities
print(gesamt)


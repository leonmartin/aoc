#!/bin/bash

input="./input"
valid_ctr=0

function puzzle_one {
    while IFS= read line
    do
        IFS=', ' read -r -a split_line <<< "$line"
        bounds=${split_line[0]}
        symbol=${split_line[1]::-1}
        password=${split_line[2]}

        IFS='-' read -r -a split_bounds <<< "$bounds"  
        lower_bounds=${split_bounds[0]}
        upper_bounds=${split_bounds[1]}

        occurrences=$(echo $password | tr -cd $symbol | wc -c | tr -d ' ')

        if [ "$occurrences" -ge "$lower_bounds" ] && [ "$occurrences" -le "$upper_bounds" ]; then
            ((valid_ctr++))
            echo "Valid: " $password 
        else
            echo "Invalid: " $password
        fi

    done < "$input"

    echo "Valid passwords for puzzle one: " $valid_ctr
}

function puzzle_two {
    while IFS= read line
    do
        IFS=', ' read -r -a split_line <<< "$line"
        bounds=${split_line[0]}
        symbol=${split_line[1]::-1}
        password=${split_line[2]}

        split_password=( `echo "$password" | grep -o .` )

        IFS='-' read -r -a split_indices <<< "$bounds"  
        first_index=${split_indices[0]}
        second_index=${split_indices[1]}

        symbol_at_first_index=${split_password[first_index-1]}
        symbol_at_second_index=${split_password[second_index-1]}

        if [ "$symbol_at_first_index" = "$symbol" ] || [ "$symbol_at_second_index" = "$symbol" ] && [ "$symbol_at_first_index" != "$symbol_at_second_index" ]; then
            ((valid_ctr++))
            echo "Valid: " $password 
        else
            echo "Invalid: " $password
        fi

    done < "$input"

    echo "Valid passwords for puzzle two: " $valid_ctr
}

# puzzle_one
puzzle_two

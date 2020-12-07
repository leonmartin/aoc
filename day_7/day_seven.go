package main

import (
	"bufio"
	"fmt"
	"os"
	"strconv"
	"strings"
)

var bag_rules map[string][]string = make(map[string][]string)
var bag_rules_two map[string]string = make(map[string]string)
var result_one int = 0
var result_two int = 0

func expand(allowed_bags []string) []string {
	expanded_bags := allowed_bags
	prev_length := 0
	new_length := len(expanded_bags)

	for prev_length != new_length {
		for _, allowed_bag := range expanded_bags {
			for _, bag := range bag_rules[allowed_bag] {

				already_there := false

				for _, b := range expanded_bags {
					if b == bag {
						already_there = true
					}
				}

				if !already_there {
					expanded_bags = append(expanded_bags, bag)
				}
			}
		}
		prev_length = new_length
		new_length = len(expanded_bags)
	}

	return expanded_bags
}

func Map(vs []string, f func(string) string) []string {
	vsm := make([]string, len(vs))
	for i, v := range vs {
		vsm[i] = f(v)
	}
	return vsm
}

func puzzle_one() {

	file, _ := os.Open("input")

	scanner := bufio.NewScanner(file)
	scanner.Split(bufio.ScanLines)

	for scanner.Scan() {
		line := scanner.Text()
		line = strings.ReplaceAll(line, " bags", "")
		line = strings.ReplaceAll(line, " bag", "")
		parts := strings.Split(line, " contain ")

		if !strings.Contains(parts[1], "no other") {
			// transform rules to array of colors
			rul_str := strings.TrimSuffix(parts[1], ".")
			allowed_bags := strings.Split(rul_str, ", ")
			allowed_bags = Map(allowed_bags, func(a string) string { return a[2:] })

			bag_rules[parts[0]] = allowed_bags
		} else {
			bag_rules[parts[0]] = []string{}
		}
	}

	file.Close()

	for bag, allowed_bags := range bag_rules {
		bag_rules[bag] = expand(allowed_bags)

		for _, b := range bag_rules[bag] {
			if strings.Contains(b, "shiny gold") {
				result_one++
			}
		}
	}

	fmt.Println("Result of puzzle one: ")
	fmt.Println(result_one)
}

func Map_two(vs []string, f func(string) int) []int {
	vsm := make([]int, len(vs))
	for i, v := range vs {
		vsm[i] = f(v)
	}
	return vsm
}

func traverse(bag string) (int) {

  str := bag_rules_two[bag]
  number_of_bags := 1
  
  if !strings.Contains(str, "no other") {
    rul_str := strings.TrimSuffix(str, ".")
    allowed_bags := strings.Split(rul_str, ", ")
    numbers := Map_two(allowed_bags, func(a string) int {
      number, _ := strconv.Atoi(a[:1])
      return number
    })

    if len(numbers) == 0 {
      return number_of_bags
    } else {

      allowed_bags = Map(allowed_bags, func(a string) string { return a[2:] })

      for i := range numbers {
        number_of_bags += numbers[i] * traverse(allowed_bags[i])
      }
    }
  }

  return number_of_bags
}

func puzzle_two() {

	file, _ := os.Open("input")

	scanner := bufio.NewScanner(file)
	scanner.Split(bufio.ScanLines)

	for scanner.Scan() {
		line := scanner.Text()
		line = strings.ReplaceAll(line, " bags", "")
		line = strings.ReplaceAll(line, " bag", "")
		parts := strings.Split(line, " contain ")

		bag_rules_two[parts[0]] = parts[1]
	}

	file.Close()

  // minus one since the shiny gold does not count
	result_two = traverse("shiny gold") - 1

	fmt.Println("Result of puzzle two: ")
	fmt.Println(result_two)

}

func main() {
	puzzle_one()
	puzzle_two()
}

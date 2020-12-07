package main 

import ( 
	"bufio"
	"fmt"
  "strings"
	"log"
	"os"
) 

var bag_rules map[string][]string = make(map[string][]string)
var result int = 0

func expand(allowed_bags([]string)) ([]string){
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

	file, err := os.Open("input") 

	if err != nil { 
		log.Fatalf("failed to open") 
	} 

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
      allowed_bags = Map(allowed_bags, func(a string) (string) {return a[2:]})
      
      bag_rules[parts[0]] = allowed_bags
    } else {
      bag_rules[parts[0]] = []string{}
    }

    // fmt.Println(parts[0] + ": ")
    // fmt.Println(bag_rules[parts[0]])
	} 

	file.Close() 

  for bag, allowed_bags := range bag_rules {
    bag_rules[bag] = expand(allowed_bags)

    // fmt.Println(bag + ": ")
    // fmt.Println(bag_rules[bag])

    for _, b := range bag_rules[bag] {
      if strings.Contains(b, "shiny gold") {
        result ++
      }
    }
  }

  fmt.Println("Result: ")
  fmt.Println(result)
} 

func puzzle_two() { 

	file, err := os.Open("input") 

	if err != nil { 
		log.Fatalf("failed to open") 
	} 

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
      allowed_bags = Map(allowed_bags, func(a string) (string) {return a[2:]})
      
      bag_rules[parts[0]] = allowed_bags
    } else {
      bag_rules[parts[0]] = []string{}
    }

    // fmt.Println(parts[0] + ": ")
    // fmt.Println(bag_rules[parts[0]])
	} 

	file.Close() 

  for bag, allowed_bags := range bag_rules {
    bag_rules[bag] = expand(allowed_bags)

    // fmt.Println(bag + ": ")
    // fmt.Println(bag_rules[bag])

    for _, b := range bag_rules[bag] {
      if strings.Contains(b, "shiny gold") {
        result ++
      }
    }
  }

  fmt.Println("Result: ")
  fmt.Println(result)

} 

func main() { 
  puzzle_one()
  puzzle_two()
}

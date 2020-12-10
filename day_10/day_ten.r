lines = readLines(paste("./", "input", sep = ""))
lines = strtoi(lines, 0L)
lines = c(lines, 0)

lines = sort(lines, decreasing=FALSE)

### puzzle one
one_jolt_diffs = 0
three_jolt_diffs = 0

prev_jolts = 0

for (i in 1:length(lines)) { 
  current_jolts = lines[i] 
  
  if (current_jolts == prev_jolts + 1) {
    one_jolt_diffs = one_jolt_diffs + 1
  } else if (current_jolts == prev_jolts + 3) {
    three_jolt_diffs = three_jolt_diffs + 1
  }

  prev_jolts = current_jolts
}

# integrated adapter is always three higher
three_jolt_diffs = three_jolt_diffs + 1

print("Result of puzzle one:")
print(one_jolt_diffs*three_jolt_diffs)


### puzzle two
ways = rep(0, length(lines)-1)
ways[1] = 1

for (index in seq(2, length(lines))) { 
  sum = 0

  for (prev_index in seq(index-3, index-1)) {
    if (prev_index >= 1) { 
      if (lines[index] <= (lines[prev_index] + 3)) {
        sum = sum + ways[prev_index]
      }
    }
  }

  ways[index] = sum
}

print("Result of puzzle two:")
print(format(ways[length(ways)], scientific = FALSE))
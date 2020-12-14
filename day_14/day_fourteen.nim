import tables
import strutils
import lists
import math
import random

# puzzle one
var
  sum = 0
  currentmask = ""
  mem = initTable[string, int]()

for line in lines "input":

  if line.contains("mask"):
    currentmask = line.split(" = ")[1]
  
  else:
    let
      address = line.split("[")[1].split("]")[0]
      value_10 = parseInt(line.split(" = ")[1])
      zero: char = @"0"[0]
      one: char = @"1"[0]

    var value_2 = toBin(value_10, 36)
    
    for i in 0 .. len(currentmask)-1:
      if currentmask[i] == zero:
        value_2[i] = zero
      elif currentmask[i] == one:
        value_2[i] = one

    mem[address] = fromBin[int](value_2)

for key, value in mem:
  sum += value

echo "Solution of puzzle one: ", sum

# puzzle two
var
  sumtwo = 0
  memtwo = initTable[string, int]()

for line in lines "input":

  if line.contains("mask"):
    currentmask = line.split(" = ")[1]
  
  else:
    let
      address = line.split("[")[1].split("]")[0]
      value_10 = parseInt(line.split(" = ")[1])
      one: char = @"1"[0]
      X: char = @"X"[0]

    var 
      address_2 = toBin(parseInt(address), 36)
      number_of_x = 0
      addresses = initSinglyLinkedList[string]()
    
    for i in 0 .. len(currentmask)-1:
      if currentmask[i] == one:
        address_2[i] = one
      elif currentmask[i] == X:
        address_2[i] = X
        number_of_x += 1

    var found_addresses: int = 0

    while found_addresses < (2^number_of_x):
      var new_address = address_2
      for i in 0 .. len(new_address) - 1:
        if new_address[i] == X:
          new_address[i] = @($rand(0..1))[0]

      if not addresses.contains(new_address):
        addresses.append(new_address)
        found_addresses += 1

    for address in addresses:
      memtwo[address] = value_10

for key, value in memtwo:
  sumtwo += value

echo "Solution of puzzle two: ", sumtwo
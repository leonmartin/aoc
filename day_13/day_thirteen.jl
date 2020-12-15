function calcDistArrival(busline, eta)
  counter = 0

  while counter < eta
    counter = counter + busline
  end

  return (busline, counter)
end

function tryConfig(start, buslines)
  for busline in buslines
    if busline == "x"
      start = start + 1
    elseif start % parse(Int, busline) == 0
      start = start + 1
    else
      return false
    end
  end
  return true
end

path = "input2"

# puzzle one
open(path) do io
  eta_raw = readline(io)
  eta = parse(Int,eta_raw)

  buslines_raw = readline(io)
  buslines = split(buslines_raw, ",")

  buslines = filter(busline -> busline != "x", buslines)
  buslines = map(busline -> calcDistArrival(parse(Int, busline), eta), buslines)
  
  earliest = ("",-1) 
  for busline in buslines
    if earliest[2] == -1 || busline[2] < earliest[2]
      earliest = busline 
    end
  end

  solution = earliest[1]*(earliest[2]-eta)
  println("Solution for puzzle one: $solution")

  close(io)
end

# puzzle two
open(path) do io
  eta_raw = readline(io)
  buslines_raw = readline(io)
  buslines = split(buslines_raw, ",")

  firstvalue = parse(Int, buslines[1])

  maxbusline = 0
  maxbuslineindex = 0

  for (index, value) in enumerate(buslines)
    if value != "x" && parse(Int, value) > maxbusline
      maxbusline = parse(Int, value) 
      maxbuslineindex = index
    end
  end
  println(maxbusline)
  println(maxbuslineindex)

  secondmaxbusline = 0
  secondmaxbuslineindex = 0

  for (index, value) in enumerate(buslines)
    if value != "x" && parse(Int, value) > secondmaxbusline && parse(Int, value) != maxbusline
      secondmaxbusline = parse(Int, value) 
      secondmaxbuslineindex = index
    end
  end
  println(secondmaxbusline)
  println(secondmaxbuslineindex)


  ctr = maxbusline - maxbuslineindex + 1

  first = 0
  while (((ctr + maxbuslineindex - 1) % maxbusline) != 0) || ((ctr % secondmaxbusline) != 0)
    ctr += maxbusline
  end

  first = ctr
  ctr += maxbusline

  second = 0
  while (((ctr + maxbuslineindex - 1) % maxbusline) != 0) || ((ctr % secondmaxbusline) != 0)
    ctr += maxbusline
  end
  second = ctr

  step = second - first
  println(step)
  start = first

  while !tryConfig(start, buslines)
    start = start + step
  end
  
  solution = start
  println("Solution for puzzle two: $solution")

  close(io)
end

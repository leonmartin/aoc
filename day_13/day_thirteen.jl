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

path = "input"

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

  startat = (0 ÷ maxbusline) * maxbusline
  start = startat - maxbuslineindex + 1

  while !tryConfig(start, buslines)
    start = start + maxbusline
  end
  
  solution = start
  println("Solution for puzzle two: $solution")

  close(io)
end
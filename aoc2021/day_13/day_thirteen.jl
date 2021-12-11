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
  #buslines = filter(busline -> busline != "x", buslines)
  #buslines = map(busline -> parse(Int, busline), buslines)

  buslines2 = fill((0,0), length(buslines))
  
  for (index, value) in enumerate(buslines)
    if value != "x"
      buslines2[index] = (parse(Int, value), index)
    end
  end 

  buslines2 = filter(busline -> busline != (0,0), buslines2)

  lcm = 1
  time = 0

  for i = 1:length(buslines2)-1
    busline = buslines2[i+1][1]
    index = buslines2[i+1][2]

    lcm *= buslines2[i][1]

    while (time + (index-1)) % busline != 0
      time += lcm
    end
  end

  solution = time
  
  println("Solution for puzzle two: $solution")

  close(io)
end

import Foundation

let path = "input" 

// puzzle one
var x = 0.0
var y = 0.0
var direction = 0.0

if freopen(path, "r", stdin) == nil {
    perror(path)
}

while let line = readLine() {

    let linearray = Array(line)
    let instruction = linearray[0]
    let value = Double(String(linearray[1..<linearray.endIndex]))!
    
    switch(instruction) {
      case "N":
        y += value
        break
      case "S":
        y -= value
        break
      case "E":
        x += value
        break
      case "W":
        x -= value
        break
      case "L":
        direction += value
        break
      case "R":
        direction -= value
        break
      case "F":
        x += value * cos(direction * (.pi / 180))
        y += value * sin(direction * (.pi / 180))
        break
      default:
        print("nay")
    }
}

var manhattandistance = Int(round(abs(x)+abs(y)))

print("Result of puzzle one: \(manhattandistance)")

// puzzle two
var w_x = 10.0
var w_y = 1.0
var s_x = 0.0
var s_y = 0.0

if freopen(path, "r", stdin) == nil {
    perror(path)
}

while let line = readLine() {

    let linearray = Array(line)
    let instruction = linearray[0]
    let value = Double(String(linearray[1..<linearray.endIndex]))!
    
    switch(instruction) {
      case "N":
        w_y += value
        break
      case "S":
        w_y -= value
        break
      case "E":
        w_x += value
        break
      case "W":
        w_x -= value
        break
      case "L":
        let w_x_new = w_x * cos(value * (.pi / 180)) - w_y * sin(value * (.pi / 180))
        let w_y_new = w_y * cos(value * (.pi / 180)) + w_x * sin(value * (.pi / 180))
        w_x = w_x_new
        w_y = w_y_new
        break
      case "R":
        let w_x_new = w_y * sin(value * (.pi / 180)) + w_x * cos(value * (.pi / 180))
        let w_y_new = w_y * cos(value * (.pi / 180)) - w_x * sin(value * (.pi / 180))
        w_x = w_x_new
        w_y = w_y_new
        break
      case "F":
        s_x += value * w_x
        s_y += value * w_y
        break
      default:
        print("nay")
    }
}

manhattandistance = Int(round(abs(s_x) + abs(s_y)))

print("Result of puzzle one: \(manhattandistance)")
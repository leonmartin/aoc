import 'dart:async';
import 'dart:convert';
import 'dart:io';

void main() {

  List<String> initialState = new File('input').readAsLinesSync();

  // puzzle one
  List<String> prevState = [...initialState];
  List<String> newState = generateNewState(prevState, false);

  while (newState.join('') != prevState.join('')) {
    prevState = newState;
    newState = generateNewState(prevState, false);
  }

  print("Solution for puzzle one: ${'#'.allMatches(newState.join('')).length}");

  // puzzle two
  prevState = [...initialState];
  newState = generateNewState(prevState, true);

  while (newState.join('') != prevState.join('')) {
    prevState = newState;
    newState = generateNewState(prevState, true);
  }

  print("Solution for puzzle two: ${'#'.allMatches(newState.join('')).length}");
  
}

List<String> generateNewState(List<String> prevState, bool considerDistant) {
  List<String> newState = [];

  for (var i = 0; i < prevState.length; i++) {
    String line = prevState[i];
    String newLine = "";

    var chars = line.split('');

    if (considerDistant){
      for (var j = 0; j < chars.length; j++) {
        var ch = chars[j];
        if (ch == 'L' && countDistantOccupiedSeats(prevState, i, j) == 0) {
          newLine += '#';
        } else if (ch == '#' && countDistantOccupiedSeats(prevState, i, j) >= 5) {
          newLine += 'L';
        } else {
          newLine += ch;
        }
      };

    } else {
      for (var j = 0; j < chars.length; j++) {
        var ch = chars[j];
        if (ch == 'L' && countSurroundingOccupiedSeats(prevState, i, j) == 0) {
          newLine += '#';
        } else if (ch == '#' && countSurroundingOccupiedSeats(prevState, i, j) >= 4) {
          newLine += 'L';
        } else {
          newLine += ch;
        }

      };
    }
    
    newState.add(newLine);
  }

  return newState;
}

int countSurroundingOccupiedSeats(List<String> state, int lineIndex, int charIndex) {
  int counter = 0;

  for (var i = -1; i < 2; i++) {
    for (var j = -1; j < 2; j++) {
      try {
        if (state[lineIndex+i][charIndex+j] == '#' && !(i == 0 && j == 0)) {
          counter++;
        }
      } on RangeError {
        continue;
      }
    }
  }

  return counter;
}

int countDistantOccupiedSeats(List<String> state, int lineIndex, int charIndex) {
  int counter = 0;

  int lIndex;
  int cIndex;

  int numberOfLines = state.length;
  int lineLength = state[0].length;

  // count above
  lIndex = lineIndex - 1;

  while (lIndex >= 0) {
    if (state[lIndex][charIndex] == 'L') {
      break;
    } else if (state[lIndex][charIndex] == '#') {
      counter++;
      break;
    }
    lIndex--;
  }

  // count above right
  lIndex = lineIndex - 1;
  cIndex = charIndex + 1;

  while (lIndex >= 0 && cIndex < lineLength) {
    if (state[lIndex][cIndex] == 'L') {
      break;
    } else if (state[lIndex][cIndex] == '#') {
      counter++;
      break;
    }
    lIndex--;
    cIndex++;
  }

  // count right
  cIndex = charIndex + 1;

  while (cIndex < lineLength) {
    if (state[lineIndex][cIndex] == 'L') {
      break;
    } else if (state[lineIndex][cIndex] == '#') {
      counter++;
      break;
    }
    cIndex++;
  }

  // count below right
  lIndex = lineIndex + 1;
  cIndex = charIndex + 1;

  while (lIndex < numberOfLines && cIndex < lineLength) {
    if (state[lIndex][cIndex] == 'L') {
      break;
    } else if (state[lIndex][cIndex] == '#') {
      counter++;
      break;
    }
    lIndex++;
    cIndex++;
  }

  // count below
  lIndex = lineIndex + 1;

  while (lIndex < numberOfLines) {
    if (state[lIndex][charIndex] == 'L') {
      break;
    } else if (state[lIndex][charIndex] == '#') {
      counter++;
      break;
    }
    lIndex++;
  }

  // count below left
  lIndex = lineIndex + 1;
  cIndex = charIndex - 1;

  while (lIndex < numberOfLines && cIndex >= 0) {
    if (state[lIndex][cIndex] == 'L') {
      break;
    } else if (state[lIndex][cIndex] == '#') {
      counter++;
      break;
    }
    lIndex++;
    cIndex--;
  }

  // count left
  cIndex = charIndex - 1;

  while (cIndex >= 0) {
    if (state[lineIndex][cIndex] == 'L') {
      break;
    } else if (state[lineIndex][cIndex] == '#') {
      counter++;
      break;
    }
    cIndex--;
  }

  // count above left
  lIndex = lineIndex - 1;
  cIndex = charIndex - 1;

  while (lIndex >= 0 && cIndex >= 0) {
    if (state[lIndex][cIndex] == 'L') {
      break;
    } else if (state[lIndex][cIndex] == '#') {
      counter++;
      break;
    }
    lIndex--;
    cIndex--;
  }

  return counter;
}
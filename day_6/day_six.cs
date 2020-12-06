using System;
using System.Collections.Generic;

class MainClass {

  public static void puzzle_one() {
    int sum = 0;

    string[] lines = System.IO.File.ReadAllLines(@"./input");

    HashSet<char> uniqueChars = new HashSet<char>();
    
    foreach (string line in lines)
    {
      if (line == "")
      {
        sum += uniqueChars.Count;
        uniqueChars.Clear();
      } else {
        foreach (char c in line)
        {
          uniqueChars.Add(c);
        }
      }

    }

    Console.WriteLine("Sum of all counts: " + sum);

  }

  public static void puzzle_two() {
    int sum = 0;

    string[] lines = System.IO.File.ReadAllLines(@"./input");

    HashSet<char> commonChars = new HashSet<char>();
    bool initial = true;
    
    foreach (string line in lines)
    {
      if (line == "")
      {
        sum += commonChars.Count;
        commonChars.Clear();
        initial = true;
      } else {
        if (initial)
        {
          foreach (char c in line)
          {
            commonChars.Add(c);
          }

          initial = false;
        } else {

          HashSet<char> otherChars = new HashSet<char>();

          foreach (char c in line)
          {
            otherChars.Add(c);
          }


          commonChars.IntersectWith(otherChars);
        }
      }

    }

    Console.WriteLine("Sum of all counts: " + sum);

  }

  public static void Main (string[] args) {
    puzzle_one();
    puzzle_two();
  }
}

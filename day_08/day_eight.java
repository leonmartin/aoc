import java.nio.file.Files;
import java.nio.file.Paths;
import java.util.List;
import java.util.ArrayList;

public class Main {
  public static void main(String[] args) {

    List<String> lines = new ArrayList<String>();

    try {
      lines = Files.readAllLines(Paths.get("input"));
    } catch (Exception e) {
            e.printStackTrace();
    }

    // puzzle one
    // run_file(lines);

    // puzzle two
    for (int i = 0; i < lines.size(); i++){
      List<String> modifiedLines = new  ArrayList<String>(lines);
      String line = modifiedLines.get(i);

      if (line.contains("nop")){
        line = line.replace("nop", "jmp");
      } else if (line.contains("jmp")){
        line = line.replace("jmp", "nop");
      }

      modifiedLines.set(i,line);

      if (run_file(modifiedLines)) {
        break;
      }
    }
  }

  public static boolean run_file(List<String> lines){
    int acc = 0;
    int lineNumber = 0;
    List<Integer> visitedLines = new ArrayList<Integer>();

    while (!visitedLines.contains(lineNumber)){

      if (lineNumber == lines.size()) {
        System.out.println("It works!");
        System.out.println("Result: " + acc);
        return true;
      }

      String line = lines.get(lineNumber);
      visitedLines.add(lineNumber);
      
      if (line.contains("acc")){
        String[] parts = line.split(" ");
        int inc = Integer.parseInt(parts[parts.length-1]);
        acc += inc;
        lineNumber += 1;

      } else if (line.contains("jmp")){
        String[] parts = line.split(" ");
        int dist = Integer.parseInt(parts[parts.length-1]);
        lineNumber += dist;

      } else if (line.contains("nop")){
        lineNumber += 1;
      }

    }

    System.out.println(acc);

    return false;
  }

}
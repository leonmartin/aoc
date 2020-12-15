import scala.io.Source
import scala.collection.mutable.ListBuffer
import scala.collection.mutable.HashMap 

object Main {
  def main(args: Array[String]): Unit = {
    val lines = Source.fromFile("input").getLines.toArray
    val numbers = lines(0).split(",").map(x => x.toInt)
    var spokenNumbers: ListBuffer[Int] = ListBuffer(numbers: _ *)

    var numberToAge: HashMap[Integer, ListBuffer[Integer]] = new HashMap()
    var turn = 1

    for (i <- 0 to spokenNumbers.length-1) {
      var occurrences = new ListBuffer[Integer]()
      occurrences.addOne(turn)
      numberToAge.addOne((spokenNumbers(i), occurrences))
      turn += 1
    }

    val limit = 30000000

    while (turn <= limit) {
      var occurrences = numberToAge(spokenNumbers.last)
      var nextNumber = 0

      if (occurrences.size <= 1) {
        nextNumber = 0
      } else {
        val lastOccurence = occurrences.last
        val secondToLastOccurence = occurrences(occurrences.size - 2)
        nextNumber = lastOccurence - secondToLastOccurence
      }

      if (!numberToAge.contains(nextNumber)) {
        numberToAge.addOne(nextNumber, new ListBuffer[Integer]())
      }

      var nextNumberOccurrences = numberToAge(nextNumber)
      nextNumberOccurrences.addOne(turn)
      if (nextNumberOccurrences.size > 2) {
        nextNumberOccurrences.remove(0)
      }

      spokenNumbers.addOne(nextNumber)

      if (turn == limit) {
        println("Solution puzzle with limit " + limit + ": " + nextNumber)
      }
      turn += 1
    }
  }
}

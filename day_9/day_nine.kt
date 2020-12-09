import java.io.File

fun main(args: Array<String>) {
  
  val lines = mutableListOf<Long>()
  val prevNums = mutableListOf<Long>()
  var invalidNum: Long = 0

  File("input").forEachLine {

    val newNum = it.toLong()
    lines.add(newNum)

    if (prevNums.size < 25) {
      prevNums.add(newNum)
    } else {
      var isValid = false

      for (n in prevNums) {
        for (m in prevNums) {
          if(n + m == newNum) isValid = true
        }
      }

      if(!isValid) {
        println("Result puzzle one: " + it)
        invalidNum = newNum
      }

      prevNums.remove(prevNums.elementAt(0))
      prevNums.add(newNum)
    }
  }

  var i = 0

  while (i < lines.size) {
    var sum = lines.elementAt(i)
    val subset = mutableListOf<Long>()

    var j = i + 1

    while (sum < invalidNum) {
      var currentNum = lines.elementAt(j)
      sum += currentNum
      subset.add(currentNum)

      j++
    }

    if(sum == invalidNum) {
      val max = subset.max() ?: 0
      val min = subset.min() ?: 0
      print("Result puzzle two: ")
      println(min + max)
    } 

    i++
  }
}

<?php
$lines = explode("\n", file_get_contents("input2"));
$error_rate = 0;
$valid_lines = [];

foreach ($lines as &$line) {

  if (preg_match("/\w+: \d+/", $line)) {
    $parts = explode(": ", $line);

    $category = $parts[0];
    $ranges = explode(" or ", $parts[1]);

    $category_ranges[$category] = [$ranges[0], $ranges[1]];

  } else if (preg_match("/\d+,/", $line)) {

    $ticket_numbers_strings = explode(",", $line);

    foreach ($ticket_numbers_strings as $number_string) {

      $number = intval($number_string);
      $in_range = false;

      foreach ($category_ranges as $cat => &$ranges) {
        $range_0_lower = intval(explode("-", $ranges[0])[0]);
        $range_0_upper = intval(explode("-", $ranges[0])[1]);

        $range_1_lower = intval(explode("-", $ranges[1])[0]);
        $range_1_upper = intval(explode("-", $ranges[1])[1]);

        if ($range_0_lower <= $number && $number <= $range_0_upper) {
          $in_range = true;
          break;
        } else if ($range_1_lower <= $number && $number <= $range_1_upper) {
          $in_range = true;
          break;
        }
      }

      if (!$in_range) {
        $error_rate += $number;
      }
    }

    if ($in_range) {
        array_push($valid_lines, $line);
    }
  }
}

foreach ($valid_lines as &$line) {
  echo $line, "\n";
}

echo "Solution of puzzle one: ", $error_rate;
?>
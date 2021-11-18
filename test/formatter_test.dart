import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:intl/intl.dart';
import 'package:todo_app/utils/formatter.dart';

void main() {
  test("Format String to TimeOfDay", () {
    TimeOfDay result1 = checkInputtedTime("12:00 PM");

    final format = DateFormat.jm();
    TimeOfDay result2 = TimeOfDay.fromDateTime(format.parse("12:00 PM"));

    // Test failed
    // expect(result1, TimeOfDay.now());
    // Test passed
    expect(result1, result2);
  });

  test("Format String to DateTime", () {
    DateTime result1 = checkInputtedDate("Nov 20, 2021");

    DateTime result2 = DateFormat("MMM dd, yyyy").parse("Nov 20, 2021");

    // Test failed
    // expect(result1, DateTime.now());
    // Test passed
    expect(result1, result2);
  });
}

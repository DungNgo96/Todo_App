import 'package:flutter_test/flutter_test.dart';
import 'package:todo_app/utils/check_condition.dart';

void main() {
  test("Check all input in textfield", () {
    bool result1 =
        createTaskTextFieldContainInput("A", "12:00 PM", "April 10, 2021");

    bool result2 =
        createTaskTextFieldContainInput("", "12:00 PM", "April 10, 2021");

    expect(result1, true);
    expect(result2, false);
  });

  test("Format String from bool", () {
    String result1 = getUpdatedStatusString(true);
    String result2 = getUpdatedStatusString(false);

    expect(result1, "Done");
    expect(result2, "Undone");
  });

  test("Format bool from String", () {
    bool result1 = getUpdatedStatusBool("Done");
    bool result2 = getUpdatedStatusBool("Undone");

    expect(result1, true);
    expect(result2, false);
  });
}

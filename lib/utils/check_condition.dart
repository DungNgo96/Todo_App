import 'package:flutter/material.dart';
import 'package:todo_app/utils/constant/const.dart';

bool createTaskTextFieldContainInput(String title, String time, String date) {
  if (title.isNotEmpty && time.isNotEmpty && date.isNotEmpty) {
    return true;
  } else {
    return false;
  }
}

String getUpdatedStatusString(bool? condition) {
  if (condition! == true) {
    return TEXTCONST.DONE;
  } else {
    return TEXTCONST.UNDONE;
  }
}

bool getUpdatedStatusBool(String condition) {
  if (condition == TEXTCONST.DONE) {
    return true;
  } else {
    return false;
  }
}

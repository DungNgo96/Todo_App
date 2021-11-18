import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

TimeOfDay checkInputtedTime(String time) {
  if (time != "" && time.isNotEmpty) {
    final format = DateFormat.jm();
    return TimeOfDay.fromDateTime(format.parse(time));
  } else {
    return TimeOfDay.now();
  }
}

DateTime checkInputtedDate(String date) {
  if (date != "" && date.isNotEmpty) {
    return DateFormat("MMM dd, yyyy").parse(date);
  } else {
    return DateTime.now();
  }
}

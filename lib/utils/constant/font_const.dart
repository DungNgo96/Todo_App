import 'package:flutter/material.dart';
import 'color_const.dart';

class FONTCONST {
  static const REGULAR = TextStyle(
      fontSize: 14, fontWeight: FontWeight.w400, color: COLORCONST.BLACK);

  static const MEDIUM = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w500,
    color: COLORCONST.BLACK,
  );

  static const SEMIBOLD = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w600,
    color: COLORCONST.BLACK,
  );

  static const BOLD = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w700,
    color: COLORCONST.BLACK,
  );

  //regular
  static final REGULAR_WHITE = REGULAR.copyWith(color: COLORCONST.WHITE);
  static final REGULAR_WHITE_20 = REGULAR_WHITE.copyWith(fontSize: 20);
  static final REGULAR_WHITE_24 = REGULAR_WHITE.copyWith(fontSize: 24);
  static final REGULAR_WHITE_36 = REGULAR_WHITE.copyWith(fontSize: 36);

  static final REGULAR_20 = REGULAR.copyWith(fontSize: 20);

  //medium

  //semibold
  static final SEMIBOLD_36 = SEMIBOLD.copyWith(fontSize: 36);

  //bold
  static final BOLD_WHITE = BOLD.copyWith(color: COLORCONST.WHITE);
  static final BOLD_WHITE_24 = BOLD_WHITE.copyWith(fontSize: 24);
  static final BOLD_24 = BOLD.copyWith(fontSize: 24);
}

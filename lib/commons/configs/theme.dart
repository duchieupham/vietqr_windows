import 'package:flutter/material.dart';

class AppColor {
  //COLOR
  static const Color BLACK = Color(0xFF000000);
  static const Color WHITE = Color(0xFFFFFFFF);
  static const Color BLUE = Color(0xFF0A7AFF);
  static const Color GREY = Color(0xFFDADADA);
  static const Color GREY_TEXT = Color(0xFF666A72);
  static const Color GREY_BUTTON = Color(0xFFF0F4FA);
  static const Color RED = Color(0xFFF5233C);
  static const Color TRANSPARENT = Color(0x00000000);
  static const Color ORANGE = Color(0XFFFF5C02);
  static const Color GREEN = Color(0XFF00CA28);
  static const Color PURPLE = Color(0XFF4260ED);
  static const Color PINK = Color(0XFFEB5BEE);

  //GRADIENT COLORS
  static const Color GREEN_TO_BLUE1 = Color(0xFF9CD740);
  static const Color GREEN_TO_BLUE2 = Color(0xFF2BACE6);
  static const Color BLUEL_TO_BLUED1 = Color(0xFF00C6FF);
  static const Color BLUEL_TO_BLUED2 = Color(0xFF0072FF);
  static const Color BLUEL_TO_BLUED3 = Color(0xFFE1EFFF);
  static const Color BLUEL_TO_BLUED4 = Color(0xFFE5F9FF);
  static const Color YELLOW_TO_BROWN1 = Color(0xFFE5CCA7);
  static const Color YELLOW_TO_BROWN2 = Color(0xFF736052);

  //GRADIENT WIDGET
  static const GRADIENT_GREEN_TO_BLUE = LinearGradient(
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
    colors: [
      AppColor.GREEN_TO_BLUE1,
      AppColor.GREEN_TO_BLUE2,
    ],
  );

  static const GRADIENT_PURPLE_TO_ORANGE = LinearGradient(
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
    colors: [
      AppColor.PURPLE,
      AppColor.ORANGE,
    ],
  );

  static const GRADIENT_PURPLE_TO_PINK = LinearGradient(
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
    colors: [
      AppColor.PURPLE,
      AppColor.PINK,
    ],
  );

  static const GRADIENT_ORANGE_TO_RED = LinearGradient(
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
    colors: [
      AppColor.ORANGE,
      AppColor.RED,
    ],
  );

  static const GRADIENT_BLUE_TO_BLACK = LinearGradient(
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
    colors: [
      AppColor.BLUE,
      AppColor.BLACK,
    ],
  );

  static const GRADIENT_BLUEL_TO_BLUED = LinearGradient(
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
    colors: [
      AppColor.BLUEL_TO_BLUED1,
      AppColor.BLUEL_TO_BLUED2,
    ],
  );

  static const GRADIENT_BLUEL_TO_BLUEL = LinearGradient(
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
    colors: [
      AppColor.BLUEL_TO_BLUED3,
      AppColor.BLUEL_TO_BLUED4,
    ],
  );

  static const YELLOW_TO_BROWN = LinearGradient(
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
    colors: [
      AppColor.YELLOW_TO_BROWN1,
      AppColor.YELLOW_TO_BROWN2,
    ],
  );
}

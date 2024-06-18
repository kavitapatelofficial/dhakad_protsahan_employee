import 'package:dashboard_flutter/utils/theme.dart';
import 'package:flutter/material.dart';


class Texttheme {
  static TextStyle mainheading = TextStyle(
      color: AppColor.accentDarkGrey,
      fontWeight: FontWeight.bold,
      fontSize: 20,
      fontFamily: 'InterExtraBold');
  static TextStyle heading = TextStyle(
      color: AppColor.accentDarkGrey,
      fontSize: 18,
      fontWeight: FontWeight.bold,
      fontFamily: 'InterExtraBold');
  static TextStyle lableStyle = TextStyle(
      color: AppColor.accentDarkGrey,
      fontSize: 15,
      fontFamily: 'InterExtraBold');
  static TextStyle title = TextStyle(
      color: AppColor.accentDarkGrey, fontSize: 16, fontFamily: 'InterBold');
  static TextStyle titleRegular = TextStyle(
      color: AppColor.accentDarkGrey, fontSize: 16, fontFamily: 'InterRegular');
  static TextStyle subTitle =
      const TextStyle(fontSize: 13);
  static TextStyle subheading = const TextStyle(fontWeight: FontWeight.bold);

  static TextStyle bodyText1 = TextStyle(
      color: AppColor.accentDarkGrey, fontSize: 12, fontFamily: 'InterBold');
  static TextStyle bodyText2 = TextStyle(
      color: AppColor.accentDarkGrey, fontSize: 12, fontFamily: 'InterRegular');
  static TextStyle caption1 = TextStyle(
      color: AppColor.accentDarkGrey, fontSize: 10, fontFamily: 'InterBold');
  static TextStyle caption2 = TextStyle(
      color: AppColor.accentDarkGrey, fontSize: 10, fontFamily: 'InterRegular');
}

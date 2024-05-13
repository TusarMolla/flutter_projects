import 'package:flutter/material.dart';

import 'package:grostore/configs/theme_config.dart';

class StyleConfig {
  static double get padding => 18.0;
  static double get padding14 => 14.0;

  static double get xsSectionSpacer => 10.0;//Extra Small section separator
  static double get smSectionSpacer => 14.0;//Small section separator
  static double get mSectionSpacer => 24.0;//Medium section separator


  static RoundedRectangleBorder buttonRadius(radius) => RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(radius.toDouble()));

  static TextStyle fs30fwEBold() {
    return TextStyle(
        fontSize: 30,
        color: ThemeConfig.fontColor,
        fontWeight: FontWeight.w800);
  }

  static TextStyle get fs8 => TextStyle(
      fontSize: 8, color: ThemeConfig.fontColor, fontWeight: FontWeight.normal);

  static TextStyle get fs10 => TextStyle(
      fontSize: 10,
      color: ThemeConfig.fontColor,
      fontWeight: FontWeight.normal);

  static TextStyle get fs11 => TextStyle(
      fontSize: 11,
      color: ThemeConfig.fontColor,
      fontWeight: FontWeight.normal);

  static TextStyle get fs12 => TextStyle(
      fontSize: 12,
      color: ThemeConfig.fontColor,
      fontWeight: FontWeight.normal);

  static TextStyle get fs12cWhitefwBold => TextStyle(
      fontSize: 12, color: ThemeConfig.white, fontWeight: FontWeight.bold);

  static TextStyle get fs12cWhite => TextStyle(
      fontSize: 12, color: ThemeConfig.white, fontWeight: FontWeight.normal);

  static TextStyle get fs12cGrey => TextStyle(
      fontSize: 12, color: ThemeConfig.grey, fontWeight: FontWeight.normal);

  static TextStyle get fs12cLightfwEBold => TextStyle(
      fontSize: 12,
      color: ThemeConfig.lightFontColor,
      fontWeight: FontWeight.bold);

  static TextStyle get fs12cLightfwNormal => TextStyle(
      fontSize: 12,
      color: ThemeConfig.lightFontColor,
      fontWeight: FontWeight.normal);

  static TextStyle get fs14fwNormal => TextStyle(
      fontSize: 14,
      color: ThemeConfig.fontColor,
      fontWeight: FontWeight.normal);

  static TextStyle get fs14fwBold => TextStyle(
      fontSize: 14, color: ThemeConfig.fontColor, fontWeight: FontWeight.bold);
  static TextStyle get fs14cSecondryfwBold => TextStyle(
      fontSize: 14, color: ThemeConfig.secondaryColor, fontWeight: FontWeight.bold);

  static TextStyle get fs14cRedfwBold => TextStyle(
      fontSize: 14, color: ThemeConfig.red, fontWeight: FontWeight.bold);

  static TextStyle get fs14cWhitefwNormal => TextStyle(
      fontSize: 14, color: ThemeConfig.white, fontWeight: FontWeight.normal);
  static TextStyle get fs14cWhitefwBold => TextStyle(
      fontSize: 14, color: ThemeConfig.white, fontWeight: FontWeight.bold);

  static TextStyle get fs16 => TextStyle(
      fontSize: 16, color: ThemeConfig.fontColor, fontWeight: FontWeight.normal);

  static TextStyle get fs16fwBold => TextStyle(
      fontSize: 16, color: ThemeConfig.fontColor, fontWeight: FontWeight.bold);

  static TextStyle get fs16cWhitefwBold => TextStyle(
      fontSize: 16, color: ThemeConfig.white, fontWeight: FontWeight.bold);

  static TextStyle get fs16cRedfwBold => TextStyle(
      fontSize: 16, color: ThemeConfig.red, fontWeight: FontWeight.bold);

  static TextStyle get fs20fwBold => TextStyle(
      fontSize: 20, color: ThemeConfig.fontColor, fontWeight: FontWeight.bold);

  static TextStyle get fs20cWhitefwBold => const TextStyle(
      fontSize: 20, color: ThemeConfig.white, fontWeight: FontWeight.bold);

  static TextStyle get fs22fwEBold => TextStyle(
      fontSize: 22, color: ThemeConfig.fontColor, fontWeight: FontWeight.bold);

  static TextStyle get fs24fwBold => TextStyle(
      fontSize: 24, color: ThemeConfig.fontColor, fontWeight: FontWeight.bold);
}

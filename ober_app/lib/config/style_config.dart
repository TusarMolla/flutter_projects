import 'package:flutter/material.dart';
import 'package:ober_app/config/theme_config.dart';
import 'package:ober_app/helpers/main_helper.dart';


class StyleConfig {
  static  const double padding = 20.0;
  static const double   padding14 =  14.0;

  static double get spacer => 10.0;//Extra Small section separator
  static double get spacerM => 14.0;//Small section separator
  static double get spacerL => 24.0;//Medium section separator

  static RoundedRectangleBorder buttonsRadius(radius) => RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(radius.toDouble()));

  static TextStyle get fsAppbar => TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.w800);

  static TextStyle get fs30fwEBold {
    return TextStyle(
        fontSize: 30,
        
        fontWeight: FontWeight.w800);
  }

  static TextStyle get fs8 => TextStyle(
      fontSize: 8, fontWeight: FontWeight.normal);

  static TextStyle get fs10 => TextStyle(
      fontSize: 10,
      
      fontWeight: FontWeight.normal);

  static TextStyle get fs11 => TextStyle(
      fontSize: 11,
      
      fontWeight: FontWeight.normal);

  static TextStyle get fs12 => TextStyle(
      fontSize: 12,
      
      fontWeight: FontWeight.normal);
  static TextStyle get fs12fwBold => TextStyle(
      fontSize: 12,
      
      fontWeight: FontWeight.bold);

  static TextStyle get fs12cWhitefwBold =>const TextStyle(
      fontSize: 12, color: ThemeConfig.white, fontWeight: FontWeight.bold);
  static TextStyle get fs12fwBoldcAccent =>const TextStyle(
      fontSize: 12, color: ThemeConfig.accentColor, fontWeight: FontWeight.bold);

  static TextStyle get fs12cWhite =>const TextStyle(
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

  static TextStyle get fs14 => TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.normal);

  static TextStyle get fs14cWhite => TextStyle(
      fontSize: 14,
      color: ThemeConfig.white,
      fontWeight: FontWeight.normal);

  static TextStyle get fs14fwBold => TextStyle(
      fontSize: 14, fontWeight: FontWeight.bold);

  static TextStyle get fs14fwBoldcAccent => TextStyle(
      fontSize: 14, color: ThemeConfig.accentColor, fontWeight: FontWeight.bold);
  static TextStyle get fs14cAccent => TextStyle(
      fontSize: 14, color: ThemeConfig.accentColor);

  static TextStyle get fs14fwBoldcLightAccent => TextStyle(
      fontSize: 14, color: ThemeConfig.lightAccentColor, fontWeight: FontWeight.bold);

  static TextStyle get fs14cSecondryfwBold => TextStyle(
      fontSize: 14, color: ThemeConfig.secondaryColor, fontWeight: FontWeight.bold);

  static TextStyle get fs14cRedfwBold => TextStyle(
      fontSize: 14, color: ThemeConfig.red, fontWeight: FontWeight.bold);
  static TextStyle get fs14cWhitefwNormal =>const TextStyle(
      fontSize: 14, color: ThemeConfig.white, fontWeight: FontWeight.normal);
  static TextStyle get fs14cGrey =>const TextStyle(
      fontSize: 14, color: ThemeConfig.grey, fontWeight: FontWeight.normal);

  static TextStyle get fs14cWhitefwBold =>const TextStyle(
      fontSize: 14, color: ThemeConfig.white, fontWeight: FontWeight.w900);
  static TextStyle get fs16 => TextStyle(fontSize: 16);
  static TextStyle get fs16fwBold => TextStyle(
      fontSize: 16, fontWeight: FontWeight.bold);
  static TextStyle get fs16cWhitefwBold =>const TextStyle(
      fontSize: 16, color: ThemeConfig.white, fontWeight: FontWeight.bold);
  static TextStyle get fs16cRedfwBold => TextStyle(
      fontSize: 16, color: ThemeConfig.red, fontWeight: FontWeight.bold);
  static TextStyle get fs16fwBoldcAccent => TextStyle(
      fontSize: 16, color: ThemeConfig.accentColor, fontWeight: FontWeight.bold);

  static TextStyle get fs18=> TextStyle(fontSize: 18);
  static TextStyle get fs18fwBold=> TextStyle(fontSize: 18,fontWeight: FontWeight.bold);

  static TextStyle get fs20fwBold => TextStyle(
      fontSize: 20, fontWeight: FontWeight.bold);
  static TextStyle get fs20cWhitefwBold => const TextStyle(
      fontSize: 20, color: ThemeConfig.white, fontWeight: FontWeight.bold);
  static TextStyle get fs22fwEBold => TextStyle(
      fontSize: 22, fontWeight: FontWeight.bold);
  static TextStyle get fs24fwBold => TextStyle(
      fontSize: 24, fontWeight: FontWeight.bold);
  static TextStyle get fs24 => TextStyle(
      fontSize: 24);
  static TextStyle get fs24cWhite => TextStyle(
      fontSize: 24, color: ThemeConfig.white);
}

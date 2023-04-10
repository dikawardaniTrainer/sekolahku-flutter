import 'package:flutter/material.dart';
import 'package:sekolah_ku/resources/color_res.dart';
import 'package:sekolah_ku/resources/dimen_res.dart';
import 'package:sekolah_ku/resources/font_res.dart';

class ThemeRes {
  static const themeMode = ThemeMode.system;
  static const iconTheme = IconThemeData(color: ColorRes.tealMat);
  static const appBarTheme = AppBarTheme(color: ColorRes.tealMat);
  static InputDecorationTheme inputDecor = InputDecorationTheme(
    suffixIconColor: ColorRes.tealMat,
    prefixIconColor: ColorRes.tealMat,
    border: OutlineInputBorder(borderRadius: BorderRadius.circular(DimenRes.size_16))
  );

  static Brightness _brightness(bool darkMode) => darkMode ? Brightness.dark : Brightness.light;

  static ThemeData getTheme(bool darkMode) => ThemeData(
      brightness: _brightness(darkMode),
      primarySwatch: ColorRes.tealMat,
      fontFamily: FontRes.poppins,
      appBarTheme: appBarTheme,
      iconTheme: iconTheme,
      inputDecorationTheme: inputDecor,
      dividerColor: ColorRes.tealMat,
      colorScheme: ColorScheme.fromSwatch(brightness: _brightness(darkMode), primarySwatch: ColorRes.tealMat).copyWith(secondary: ColorRes.tealMat)
  );
}
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:sekolah_ku/resources/color_res.dart';
import 'package:sekolah_ku/resources/dimen_res.dart';
import 'package:sekolah_ku/resources/font_res.dart';

class ThemeRes {
  static const themeMode = ThemeMode.system;
  static const _iconTheme = IconThemeData(color: ColorRes.tealMat);
  static const _appBarTheme = AppBarTheme(
      color: ColorRes.tealMat,
      titleTextStyle: TextStyle(color: ColorRes.white, fontWeight: FontWeight.bold),
      iconTheme: IconThemeData(color: ColorRes.white)
  );
  static final _inputBorderRadius = BorderRadius.circular(DimenRes.size_16);
  static final _inputDecor = InputDecorationTheme(
    suffixIconColor: ColorRes.tealMat,
    prefixIconColor: ColorRes.tealMat,
    enabledBorder: OutlineInputBorder(borderRadius: _inputBorderRadius, borderSide: const BorderSide(color: ColorRes.grey)),
    border: OutlineInputBorder(borderRadius: _inputBorderRadius, borderSide: const BorderSide(color: ColorRes.tealMat))
  );

  static Brightness _brightness(bool darkMode) => darkMode ? Brightness.dark : Brightness.light;
  static Color _bgColor(bool darkMode) => darkMode ? ColorRes.grey : ColorRes.white;

  static ThemeData getTheme(bool darkMode) => ThemeData(
      brightness: _brightness(darkMode),
      primarySwatch: ColorRes.tealMat,
      fontFamily: FontRes.poppins,
      appBarTheme: _appBarTheme,
      iconTheme: _iconTheme,
      inputDecorationTheme: _inputDecor,
      dividerColor: ColorRes.tealMat,
      colorScheme: ColorScheme.fromSwatch(
          backgroundColor: _bgColor(darkMode),
          brightness: _brightness(darkMode),
          primarySwatch: ColorRes.tealMat).copyWith(secondary: ColorRes.tealMat)
  );
}
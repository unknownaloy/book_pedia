import 'package:book_pedia/styles/colors.dart';
import 'package:book_pedia/styles/text_theme.dart';
import 'package:flutter/material.dart';

ThemeData lightTheme() {
  final baseTheme = ThemeData.light();

  return baseTheme.copyWith(
    // primaryColor: kAccentColor,
    colorScheme: ThemeData().colorScheme.copyWith(primary: kAccentColor,),
    // accentColor: kAccentColor,
    scaffoldBackgroundColor: kScaffoldColor,
    textTheme: kLightTextTheme,
    hintColor: kHintColor,
    iconTheme: const IconThemeData(color: kShadowColor),
    focusColor: kAccentColor,
  );
}
import 'package:book_pedia/styles/colors.dart';
import 'package:book_pedia/styles/text_styles.dart';
import 'package:flutter/material.dart';

final TextTheme kLightTextTheme = TextTheme(
  headline1: kHeadLine1Style.copyWith(color: kTextColor),
  headline2: kHeadLine2Style.copyWith(color: kTextColor),
  bodyText1: kBodyText1Style.copyWith(color: kTextColor),
  bodyText2: kBodyText2Style.copyWith(color: kTextColor),
  button: kButtonStyle.copyWith(color: kTextColor),
);
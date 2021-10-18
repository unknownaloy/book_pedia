import 'package:book_pedia/styles/colors.dart';
import 'package:book_pedia/styles/text_styles.dart';
import 'package:flutter/material.dart';

final TextTheme kLightTextTheme = TextTheme(
  headline1: kHeadLine1Style.copyWith(color: kTextColor),
  headline2: kHeadLine2Style.copyWith(color: kTextColor),
  headline3: kHeadLine3Style.copyWith(color: kTextColor),
  headline4: kHeadLine4Style.copyWith(color: kTextColor),
  headline6: kHeadLine6Style.copyWith(color: kTextColor),
  bodyText1: kBodyText1Style.copyWith(color: kTextColor),
  bodyText2: kBodyText2Style.copyWith(color: kTextColor),
  subtitle1: kSubtitle1Style.copyWith(color: kChipTextColor),
  button: kButtonStyle.copyWith(color: kTextColor),
);

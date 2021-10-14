import 'package:book_pedia/styles/colors.dart';
import 'package:flutter/material.dart';

InputDecoration inputDecoration(String? hintText) {
  return InputDecoration(
    hintText: hintText,
    border: const OutlineInputBorder(),
    focusedBorder: const OutlineInputBorder(
      borderSide: BorderSide(
        color: kAccentColor,
        width: 2.0,
      ),
    ),
  );
}


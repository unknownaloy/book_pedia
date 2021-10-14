import 'package:book_pedia/styles/colors.dart';
import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final String hintText;
  final TextEditingController controller;
  final TextInputType? textInputType;
  final bool? isObscure;

  const CustomTextField({
    Key? key,
    required this.hintText,
    required this.controller,
    this.textInputType,
    this.isObscure,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      style: Theme.of(context).textTheme.bodyText1,
      keyboardType: textInputType ?? TextInputType.text,
      obscureText: isObscure ?? false,
      decoration: InputDecoration(
        hintText: hintText,
        border: const OutlineInputBorder(),
        focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide(
            color: kAccentColor,
            width: 2.0,
          ),
        ),
      ),
    );
  }
}

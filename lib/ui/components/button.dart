import 'package:book_pedia/styles/colors.dart';
import 'package:flutter/material.dart';

class Button extends StatelessWidget {
  // final String buttonText;
  final Widget child;
  final VoidCallback? onPressed;
  final Color buttonColor;

  const Button({
    Key? key,
    // required this.buttonText,
    required this.child,
    this.onPressed,
    this.buttonColor = kAccentColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
      child: child,
      style: ButtonStyle(
        minimumSize: MaterialStateProperty.all<Size>(
          const Size.fromHeight(56.0),
        ),
        backgroundColor: MaterialStateProperty.all<Color>(buttonColor),
      ),
      onPressed: onPressed,
    );
  }
}

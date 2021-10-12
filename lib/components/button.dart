import 'package:book_pedia/styles/colors.dart';
import 'package:flutter/material.dart';

class Button extends StatelessWidget {

  final String buttonText;
  final VoidCallback? onPressed;

  const Button({Key? key, required this.buttonText, this.onPressed,}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
      child: Text(
        buttonText,
        style: Theme.of(context).textTheme.button,
      ),
      style: ButtonStyle(
        minimumSize: MaterialStateProperty.all<Size>(
          const Size.fromHeight(56.0),
        ),
        backgroundColor:
        MaterialStateProperty.all<Color>(kActionColor),
      ),
      onPressed: onPressed,
    );
  }
}

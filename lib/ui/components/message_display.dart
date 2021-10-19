import 'package:flutter/material.dart';

class MessageDisplay extends StatelessWidget {
  final String error;

  const MessageDisplay({Key? key, required this.error}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        error,
        style: Theme.of(context).textTheme.bodyText1,
      ),
    );
  }
}

import 'package:flutter/material.dart';

class BookItemDescription extends StatelessWidget {

  final String description;

  const BookItemDescription({Key? key, required this.description}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Align(
          alignment: Alignment.center,
          child: Text(
            "Description",
            style: Theme.of(context).textTheme.headline4,
          ),
        ),

        const SizedBox(
          height: 8.0,
        ),

        Text(
          description,
          style: Theme.of(context).textTheme.bodyText1,
        ),

      ],
    );
  }
}

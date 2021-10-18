import 'package:book_pedia/styles/colors.dart';
import 'package:flutter/material.dart';

class BookItemRating extends StatelessWidget {
  final String label;
  final double rating;

  const BookItemRating({Key? key, required this.label, required this.rating})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Text(
              "$label:",
              style: Theme.of(context).textTheme.headline4,
            ),
            const SizedBox(
              width: 20.0,
            ),
            Text(
              "$rating",
              style: Theme.of(context).textTheme.bodyText1,
            ),
            const SizedBox(
              width: 4.0,
            ),
            const Icon(
              Icons.star,
              color: kAccentColor,
              size: 18.0,
            ),
          ],
        ),
        const Divider(),
      ],
    );
  }
}

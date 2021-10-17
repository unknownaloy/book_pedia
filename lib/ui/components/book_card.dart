import 'package:book_pedia/styles/colors.dart';
import 'package:flutter/material.dart';

class BookCard extends StatelessWidget {
  final String imageUrl;

  const BookCard({Key? key, required this.imageUrl}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Align(
          alignment: Alignment.centerLeft,
          child: Text(
            "Famous Books",
            style: Theme.of(context).textTheme.headline3,
          ),
        ),
        const SizedBox(
          height: 24.0,
        ),
        Container(
          padding: const EdgeInsets.all(8.0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16.0),
            border: Border.all(color: Colors.transparent),
            color: Colors.white,
            boxShadow: const [
              BoxShadow(
                color: kShadowColor,
                offset: Offset(0.0, 1.0), //(x,y)
                blurRadius: 8.0,
                spreadRadius: 4.0,
              ),
            ],
          ),
          child: Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(16.0),
                child: Image.network(
                  imageUrl,
                  fit: BoxFit.contain,
                  loadingBuilder: (context, child, progress) {
                    return progress == null
                        ? child
                        : const CircularProgressIndicator();
                  },
                ),
              ),
              const SizedBox(
                width: 24.0,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "by Joshua Becker",
                    style: Theme.of(context)
                        .textTheme
                        .bodyText2
                        ?.copyWith(color: kHintColor),
                  ),
                  const SizedBox(
                    height: 8.0,
                  ),
                  Text(
                    "The More of Less",
                    style: Theme.of(context).textTheme.headline4,
                  ),
                  const SizedBox(
                    height: 8.0,
                  ),
                  Row(
                    children: [
                      const Icon(
                        Icons.star,
                        color: kAccentColor,
                        size: 18.0,
                      ),
                      const SizedBox(
                        width: 8.0,
                      ),
                      Text(
                        "4.5",
                        style: Theme.of(context)
                            .textTheme
                            .bodyText2
                            ?.copyWith(color: kHintColor),
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 8.0,
                  ),
                  Chip(
                    backgroundColor: kHighLightColor,
                    label: const Text('Aaron Burr'),
                    labelStyle: Theme.of(context).textTheme.subtitle1,
                    // labelPadding: const EdgeInsets.symmetric(vertical: 2.0),
                  )
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}

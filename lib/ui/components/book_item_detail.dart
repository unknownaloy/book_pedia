import 'package:flutter/material.dart';

class DetailItem extends StatelessWidget {
  final String label;
  final String bodyText;

  const DetailItem({
    Key? key,
    required this.label,
    required this.bodyText,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "$label:",
                style: Theme.of(context).textTheme.headline4,
              ),
              const SizedBox(
                width: 20.0,
              ),
              Flexible(
                child: Text(
                  bodyText,
                  style: Theme.of(context).textTheme.bodyText1,
                ),
              ),
            ],
          ),

          const Divider(),
        ],
      ),
    );
  }
}

import 'package:book_pedia/styles/colors.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: kAccentColor,
      child: Center(
        child: Shimmer.fromColors(
          baseColor: kBaseColor,
          highlightColor: kHighLightColor,
          child: Text(
            "Book Pedia",
            style: Theme.of(context).textTheme.headline1,
          ),
        ),
      ),
    );
  }
}

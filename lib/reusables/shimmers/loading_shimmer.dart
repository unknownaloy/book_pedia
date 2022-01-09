import 'package:book_pedia/config/theme/colors.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class LoadingShimmer extends StatelessWidget {
  const LoadingShimmer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // return const Text("MongoDB");
    return Shimmer.fromColors(
      baseColor: kHighLightColor,
      highlightColor: kBaseColor,
      period: const Duration(seconds: 3),
      child: ListView.builder(
        itemCount: 10,
        itemBuilder: (BuildContext context, int index) {
          return Container(
            margin: const EdgeInsets.only(
              bottom: 24.0,
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  height: 160.0,
                  width: MediaQuery.of(context).size.width * 0.32,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16.0),
                    border: Border.all(color: Colors.transparent),
                    color: Colors.white,
                  ),
                ),
                const SizedBox(
                  width: 16.0,
                ),
                Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      height: 8.0,
                      width: MediaQuery.of(context).size.width * 0.32,
                      color: Colors.white,
                    ),
                    const SizedBox(
                      height: 8.0,
                    ),
                    Container(
                      height: 8.0,
                      width: MediaQuery.of(context).size.width * 0.48,
                      color: Colors.white,
                    ),
                    const SizedBox(
                      height: 8.0,
                    ),
                    Container(
                      height: 8.0,
                      width: MediaQuery.of(context).size.width * 0.16,
                      color: Colors.white,
                    ),
                    const SizedBox(height: 8.0,),
                    Container(
                      height: 24.0,
                      width: MediaQuery.of(context).size.width * 0.32,
                      color: Colors.white,
                    ),
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

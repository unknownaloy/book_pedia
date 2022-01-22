import 'dart:math';

import 'package:book_pedia/config/theme/colors.dart';
import 'package:flutter/material.dart';

class PersistentHeader extends SliverPersistentHeaderDelegate {
  final double maxHeight;
  final double minHeight;
  final Color? color;
  final EdgeInsetsGeometry? margin;
  final Widget child;

  const PersistentHeader({
    this.maxHeight = 80.0,
    this.minHeight = 80.0,
    this.color,
    this.margin,
    required this.child,
  });

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(
      margin: margin,
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      height: 72.0,
      width: double.infinity,
      color: color ?? kScaffoldColor,
      child: child,
    );
  }

  @override
  double get maxExtent => max(maxHeight, minHeight);

  @override
  double get minExtent => 80.0;

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) {
    return true;
  }
}

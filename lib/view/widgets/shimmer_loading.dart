import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerLoading extends StatelessWidget {
  final Color baseColor;
  final Color highlightColor;
  final double borderRadius;
  final Widget child;

  const ShimmerLoading({
    Key? key,
    this.baseColor = Colors.grey,
    this.highlightColor = Colors.white,
    this.borderRadius = 0.0,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Shimmer(
      gradient: LinearGradient(
        colors: [baseColor, highlightColor, baseColor],
        stops: const [0.1, 0.3, 0.6],
        tileMode: TileMode.mirror,
      ),
      child: child,
    );
  }
}

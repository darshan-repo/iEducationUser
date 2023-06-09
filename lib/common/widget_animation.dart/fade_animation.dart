
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

Widget animation(
  BuildContext context, {
  required Widget child,
  required int seconds,
  double horizontalOffset = 0,
  double verticalOffset = 0,
}) {
  return AnimationLimiter(
    child: AnimationConfiguration.staggeredList(
      position: 10,
      duration: Duration(milliseconds: seconds),
      child: SlideAnimation(
        horizontalOffset: horizontalOffset,
        verticalOffset: verticalOffset,
        child: FadeInAnimation(child: child),
      ),
    ),
  );
}

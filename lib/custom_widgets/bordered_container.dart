import 'package:flutter/material.dart';

class BorderedContainer extends StatelessWidget {
  const BorderedContainer(
      {super.key,
      this.isExpandble = false,
      this.color,
      this.height,
      this.width,
      required this.child});
  final Widget child;
  final Color? color;
  final double? height;
  final double? width;
  final bool isExpandble;

  @override
  Widget build(BuildContext context) {
    if (isExpandble) {
      // Expandable Container
      // Stetch the container width and height to take the parent's size
      return Expanded(
          child: Container(
        height: height,
        width: width,
        alignment: Alignment.center,
        decoration: BoxDecoration(color: color, border: Border.all()),
        child: child,
      ));
    } else {
      return Container(
        height: height,
        width: width,
        alignment: Alignment.center,
        decoration: BoxDecoration(color: color, border: Border.all()),
        child: child,
      );
    }
  }
}

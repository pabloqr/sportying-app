import 'package:flutter/material.dart';

class DateContainer extends StatelessWidget {
  const DateContainer({
    super.key,
    this.verticalPadding,
    this.horizontalPadding,
    this.width,
    this.height,
    this.borderRadius,
    this.color,
    this.border,
    required this.child,
  });

  final double? verticalPadding;
  final double? horizontalPadding;

  final double? width;
  final double? height;

  final double? borderRadius;

  final Color? color;
  final BoxBorder? border;

  final Widget child;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Container(
      padding: EdgeInsets.symmetric(horizontal: horizontalPadding ?? 14.0, vertical: verticalPadding ?? 12.0),
      width: width,
      height: height,
      decoration: BoxDecoration(
        color:
            color ??
            (Theme.brightnessOf(context) == Brightness.light
                ? colorScheme.surfaceContainerLowest
                : colorScheme.surfaceContainerHigh),
        borderRadius: BorderRadius.circular(borderRadius ?? 12.0),
        border: border, // Border.all(color: Colors.white.withAlpha(75), width: 2),
      ),
      child: child,
    );
  }
}

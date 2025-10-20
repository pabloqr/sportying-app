import 'package:flutter/material.dart';

class CustomContainer extends StatelessWidget {
  const CustomContainer._(this.isTranslucent, this.width, this.height, this.color, this.border, this.child);

  factory CustomContainer.filled({
    double? width,
    double? height,
    Color? color,
    BoxBorder? border,
    required Widget child,
  }) => CustomContainer._(false, width, height, color, border, child);

  factory CustomContainer.translucent({
    double? width,
    double? height,
    Color? color,
    BoxBorder? border,
    required Widget child,
  }) => CustomContainer._(true, width, height, color, border, child);

  final bool isTranslucent;

  final double? width;
  final double? height;

  final Color? color;
  final BoxBorder? border;

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14.0, vertical: 12.0),
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: isTranslucent ? color?.withAlpha(50) ?? Colors.white.withAlpha(50) : color ?? Colors.white,
        borderRadius: BorderRadius.circular(20.0),
        border: border, // Border.all(color: Colors.white.withAlpha(75), width: 2),
      ),
      child: child,
    );
  }
}

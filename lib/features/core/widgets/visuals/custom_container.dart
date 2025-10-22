import 'package:flutter/material.dart';

class CustomContainer extends StatelessWidget {
  const CustomContainer._(
    this.isTranslucent,
    this.verticalPadding,
    this.horizontalPadding,
    this.width,
    this.height,
    this.borderRadius,
    this.color,
    this.border,
    this.child,
  );

  factory CustomContainer.filled({
    double? verticalPadding,
    double? horizontalPadding,
    double? width,
    double? height,
    double? borderRadius,
    Color? color,
    BoxBorder? border,
    required Widget child,
  }) => CustomContainer._(false, verticalPadding, horizontalPadding, width, height, borderRadius, color, border, child);

  factory CustomContainer.translucent({
    double? verticalPadding,
    double? horizontalPadding,
    double? width,
    double? height,
    double? borderRadius,
    Color? color,
    BoxBorder? border,
    required Widget child,
  }) => CustomContainer._(true, verticalPadding, horizontalPadding, width, height, borderRadius, color, border, child);

  final bool isTranslucent;

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
    return Container(
      padding: EdgeInsets.symmetric(horizontal: horizontalPadding ?? 14.0, vertical: verticalPadding ?? 12.0),
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: isTranslucent ? color?.withAlpha(50) ?? Colors.white.withAlpha(50) : color ?? Colors.white,
        borderRadius: BorderRadius.circular(borderRadius ?? 12.0),
        border: border, // Border.all(color: Colors.white.withAlpha(75), width: 2),
      ),
      child: child,
    );
  }
}

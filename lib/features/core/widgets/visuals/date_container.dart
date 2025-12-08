import 'package:flutter/material.dart';
import 'package:sportying_app/core/utils/extension_utilities.dart';

class DateContainer extends StatelessWidget {
  const DateContainer({
    super.key,
    this.verticalPadding,
    this.horizontalPadding,
    this.width,
    this.height,
    this.margin,
    this.borderRadius,
    this.color,
    this.border,
    required this.date,
    this.onTap,
  });

  final double? verticalPadding;
  final double? horizontalPadding;

  final double? width;
  final double? height;

  final EdgeInsetsGeometry? margin;

  final double? borderRadius;

  final Color? color;
  final BoxBorder? border;

  final DateTime date;

  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      width: width,
      height: height,
      margin: margin,
      decoration: BoxDecoration(
        color:
            color ??
            (Theme.brightnessOf(context) == Brightness.light
                ? colorScheme.surfaceContainerLowest
                : colorScheme.surfaceContainerHigh),
        borderRadius: BorderRadius.circular(borderRadius ?? 12.0),
        border: border, // Border.all(color: Colors.white.withAlpha(75), width: 2),
      ),
      clipBehavior: Clip.antiAlias,
      child: onTap != null
          ? Material(
              type: MaterialType.transparency,
              child: InkWell(onTap: onTap, child: _buildContent(context)),
            )
          : _buildContent(context),
    );
  }

  Widget _buildContent(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: horizontalPadding ?? 14.0, vertical: verticalPadding ?? 12.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(date.toFormattedWeekDay0().toUpperCase(), style: textTheme.bodyMedium),
          Text(date.toFormattedMonthDay0(), style: textTheme.titleLarge),
          Text(date.toFormattedMonth0().toUpperCase(), style: textTheme.bodyMedium),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:sportying_app/domain/models/core/widget_status.dart';

class SmallChip extends StatelessWidget {
  final WidgetStatus status;

  final bool inverse;

  final String? label;
  final IconData? icon;

  const SmallChip._(this.status, this.inverse, this.label, this.icon);

  factory SmallChip.neutral(bool inverse, {String? label, IconData? icon}) =>
      SmallChip._(WidgetStatus.neutral, inverse, label, icon);

  factory SmallChip.neutralTranslucent(bool inverse, {String? label, IconData? icon}) =>
      SmallChip._(WidgetStatus.neutralTranslucent, inverse, label, icon);

  factory SmallChip.alert(bool inverse, {String? label, IconData? icon}) =>
      SmallChip._(WidgetStatus.alert, inverse, label, icon);

  factory SmallChip.success(bool inverse, {String? label, IconData? icon}) =>
      SmallChip._(WidgetStatus.success, inverse, label, icon);

  factory SmallChip.error(bool inverse, {String? label, IconData? icon}) =>
      SmallChip._(WidgetStatus.error, inverse, label, icon);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(6.0),
      decoration: BoxDecoration(
        color: inverse ? status.colorOnSurface(context) : status.colorSurface(context),
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: _buildContent(context),
    );
  }

  Widget? _buildContent(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    if (label != null && icon != null) {
      return Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        spacing: 4.0,
        children: [
          Icon(
            icon!,
            size: 16,
            fill: 0,
            weight: 400,
            grade: 0,
            opticalSize: 16,
            color: inverse ? status.colorSurface(context) : status.colorOnSurface(context),
          ),
          Text(
            label!,
            style: textTheme.labelSmall?.copyWith(
              color: inverse ? status.colorSurface(context) : status.colorOnSurface(context),
            ),
            overflow: TextOverflow.fade,
            softWrap: false,
          ),
        ],
      );
    } else if (label != null) {
      return Text(
        label!,
        style: textTheme.labelSmall?.copyWith(
          color: inverse ? status.colorSurface(context) : status.colorOnSurface(context),
        ),
        overflow: TextOverflow.fade,
        softWrap: false,
      );
    } else if (icon != null) {
      return Icon(
        icon!,
        size: 16,
        fill: 0,
        weight: 400,
        grade: 0,
        opticalSize: 16,
        color: inverse ? status.colorSurface(context) : status.colorOnSurface(context),
      );
    }
    return null;
  }
}

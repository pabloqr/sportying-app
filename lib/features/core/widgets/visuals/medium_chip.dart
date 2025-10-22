import 'package:flutter/material.dart';
import 'package:sportying_app/features/core/utils/widget_status.dart';

@Deprecated('Use [CustomChip] class.')
class MediumChip extends StatelessWidget {
  final WidgetStatus status;

  final bool inverse;

  final String? label;
  final IconData? icon;

  const MediumChip._(this.status, this.inverse, this.label, this.icon);

  factory MediumChip.neutral(bool inverse, {String? label, IconData? icon}) =>
      MediumChip._(WidgetStatus.neutral, inverse, label, icon);

  factory MediumChip.neutralTranslucent(bool inverse, {String? label, IconData? icon}) =>
      MediumChip._(WidgetStatus.neutralTranslucent, inverse, label, icon);

  factory MediumChip.alert(bool inverse, {String? label, IconData? icon}) =>
      MediumChip._(WidgetStatus.alert, inverse, label, icon);

  factory MediumChip.success(bool inverse, {String? label, IconData? icon}) =>
      MediumChip._(WidgetStatus.success, inverse, label, icon);

  factory MediumChip.error(bool inverse, {String? label, IconData? icon}) =>
      MediumChip._(WidgetStatus.error, inverse, label, icon);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
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
            style: textTheme.labelMedium?.copyWith(
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
        style: textTheme.labelMedium?.copyWith(
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

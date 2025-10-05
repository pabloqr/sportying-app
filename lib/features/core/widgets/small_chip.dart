import 'package:flutter/material.dart';
import 'package:sportying_app/domain/models/core/widget_status.dart';

class SmallChip extends StatelessWidget {
  final WidgetStatus status;

  final String? label;
  final IconData? icon;

  const SmallChip._({required this.status, this.label, this.icon});

  factory SmallChip.neutralSurface({String? label, IconData? icon}) =>
      SmallChip._(status: WidgetStatus.neutralSurface, label: label, icon: icon);

  factory SmallChip.neutralCard({String? label, IconData? icon}) =>
      SmallChip._(status: WidgetStatus.neutralCard, label: label, icon: icon);

  factory SmallChip.alert({String? label, IconData? icon}) =>
      SmallChip._(status: WidgetStatus.alert, label: label, icon: icon);

  factory SmallChip.success({String? label, IconData? icon}) =>
      SmallChip._(status: WidgetStatus.success, label: label, icon: icon);

  factory SmallChip.error({String? label, IconData? icon}) =>
      SmallChip._(status: WidgetStatus.error, label: label, icon: icon);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(6.0),
      decoration: BoxDecoration(color: status.colorSurface(context), borderRadius: BorderRadius.circular(8.0)),
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
          Icon(icon!, size: 16, fill: 0, weight: 400, grade: 0, opticalSize: 16, color: status.colorOnSurface(context)),
          Text(label!, style: textTheme.labelSmall?.copyWith(color: status.colorOnSurface(context))),
        ],
      );
    } else if (label != null) {
      return Text(label!, style: textTheme.labelSmall?.copyWith(color: status.colorOnSurface(context)));
    } else if (icon != null) {
      return Icon(
        icon!,
        size: 16,
        fill: 0,
        weight: 400,
        grade: 0,
        opticalSize: 16,
        color: status.colorOnSurface(context),
      );
    }
    return null;
  }
}

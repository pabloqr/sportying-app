import 'package:flutter/material.dart';
import 'package:sportying_app/domain/models/core/widget_status.dart';

class MediumChip extends StatelessWidget {
  final WidgetStatus status;
  final String label;

  const MediumChip._({required this.status, required this.label});

  factory MediumChip.neutralSurface({required String label}) =>
      MediumChip._(status: WidgetStatus.neutralLight, label: label);

  factory MediumChip.neutralCard({required String label}) =>
      MediumChip._(status: WidgetStatus.neutralDark, label: label);

  factory MediumChip.alert({required String label}) => MediumChip._(status: WidgetStatus.alert, label: label);

  factory MediumChip.success({required String label}) => MediumChip._(status: WidgetStatus.success, label: label);

  factory MediumChip.error({required String label}) => MediumChip._(status: WidgetStatus.error, label: label);

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
      decoration: BoxDecoration(color: status.colorSurface(context), borderRadius: BorderRadius.circular(8.0)),
      child: Text(label, style: textTheme.labelMedium?.copyWith(color: status.colorOnSurface(context))),
    );
  }
}

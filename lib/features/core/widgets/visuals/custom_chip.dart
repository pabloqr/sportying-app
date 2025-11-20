import 'package:flutter/material.dart';
import 'package:sportying_app/features/core/utils/widget_palette.dart';
import 'package:sportying_app/features/core/utils/widget_size.dart';
import 'package:sportying_app/features/core/utils/widget_status.dart';

class CustomChip extends StatelessWidget {
  const CustomChip._(this.size, this.status, this.palette, this.icon, this.filledIcon, this.label);

  final WidgetSize size;
  final WidgetStatus status;

  final WidgetPalette palette;

  final IconData? icon;
  final bool? filledIcon;

  final String? label;

  static ChipBuilder get small => ChipBuilder(WidgetSize.small);
  static ChipBuilder get medium => ChipBuilder(WidgetSize.medium);
  static ChipBuilder get large => ChipBuilder(WidgetSize.large);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: _getPadding(),
      decoration: BoxDecoration(color: _getSurfaceColor(context), borderRadius: BorderRadius.circular(8.0)),
      child: _buildContent(context),
    );
  }

  EdgeInsets _getPadding() {
    switch (size) {
      case WidgetSize.small:
        return EdgeInsets.all(6.0);
      case WidgetSize.medium:
        return EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0);
      case WidgetSize.large:
        return EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0);
    }
  }

  Color _getSurfaceColor(BuildContext context) {
    switch (palette) {
      case WidgetPalette.normal:
        return status.colorSurface(context);
      case WidgetPalette.inverse:
        return status.colorOnSurface(context);
      case WidgetPalette.primary:
        return status.colorPrimary(context);
    }
  }

  Color _getOnSurfaceColor(BuildContext context) {
    switch (palette) {
      case WidgetPalette.normal:
        return status.colorOnSurface(context);
      case WidgetPalette.inverse:
        return status.colorSurface(context);
      case WidgetPalette.primary:
        return status.colorOnPrimary(context);
    }
  }

  TextStyle? _getTextStyle(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final baseStyle = switch (size) {
      WidgetSize.small => textTheme.labelSmall,
      WidgetSize.medium => textTheme.labelMedium,
      WidgetSize.large => textTheme.labelLarge,
    };

    return baseStyle?.copyWith(color: _getOnSurfaceColor(context));
  }

  double _getIconSize() {
    switch (size) {
      case WidgetSize.small:
        return 16.0;
      case WidgetSize.medium:
        return 16.0;
      case WidgetSize.large:
        return 20.0;
    }
  }

  Widget? _buildContent(BuildContext context) {
    final iconColor = _getOnSurfaceColor(context);

    if (label != null && icon != null) {
      return Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        spacing: 4.0,
        children: [
          Icon(
            icon!,
            size: _getIconSize(),
            fill: filledIcon ?? false ? 1 : 0,
            weight: 400,
            grade: 0,
            opticalSize: _getIconSize(),
            color: iconColor,
          ),
          Text(label!, style: _getTextStyle(context), overflow: TextOverflow.fade, softWrap: false),
        ],
      );
    } else if (label != null) {
      return Text(label!, style: _getTextStyle(context), overflow: TextOverflow.fade, softWrap: false);
    } else if (icon != null) {
      return Icon(
        icon!,
        size: _getIconSize(),
        fill: filledIcon ?? false ? 1 : 0,
        weight: 400,
        grade: 0,
        opticalSize: _getIconSize(),
        color: iconColor,
      );
    }
    return null;
  }
}

class ChipBuilder {
  final WidgetSize size;

  const ChipBuilder(this.size);

  CustomChip neutral({required WidgetPalette palette, IconData? icon, bool? filledIcon, String? label}) {
    return CustomChip._(size, WidgetStatus.neutral, palette, icon, filledIcon, label);
  }

  CustomChip translucent({required WidgetPalette palette, IconData? icon, bool? filledIcon, String? label}) {
    return CustomChip._(size, WidgetStatus.translucent, palette, icon, filledIcon, label);
  }

  CustomChip alert({required WidgetPalette palette, IconData? icon, bool? filledIcon, String? label}) {
    return CustomChip._(size, WidgetStatus.alert, palette, icon, filledIcon, label);
  }

  CustomChip success({required WidgetPalette palette, IconData? icon, bool? filledIcon, String? label}) {
    return CustomChip._(size, WidgetStatus.success, palette, icon, filledIcon, label);
  }

  CustomChip error({required WidgetPalette palette, IconData? icon, bool? filledIcon, String? label}) {
    return CustomChip._(size, WidgetStatus.error, palette, icon, filledIcon, label);
  }
}

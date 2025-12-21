import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:material_symbols_icons/material_symbols_icons.dart';
import 'package:sportying_app/core/utils/extension_utilities.dart';
import 'package:sportying_app/domain/models/complexes/complex.dart';
import 'package:sportying_app/domain/models/complexes/sport.dart';
import 'package:sportying_app/features/core/utils/widget_palette.dart';
import 'package:sportying_app/features/core/utils/widget_side.dart';
import 'package:sportying_app/features/core/widgets/scaffolds/labeled_info_widget.dart';
import 'package:sportying_app/features/core/widgets/utils/marquee_widget.dart';
import 'package:sportying_app/features/core/widgets/visuals/custom_chip.dart';

//--------------------------------------------------------------------------------------------------------------------//
// CONSTANTS
//--------------------------------------------------------------------------------------------------------------------//

/// Opacity applied to non-selected cards in carousel mode
const double _kNonSelectedOpacity = 0.6;

/// Border width for selected cards in carousel mode
const double _kSelectedBorderWidth = 3.0;

/// Gradient stops for carousel card overlay
const List<double> _kCarouselGradientStops = [0.4, 1.0];

/// Gradient stops for shader mask in carousel
const List<double> _kShaderMaskStops = [0.85, 1.0];

/// Alpha values for gradient overlay
const int _kGradientStartAlpha = 25;
const int _kGradientEndAlpha = 150;

/// Image container height for tiles
const double _kTileImageSize = 96.0;

/// Image container height for cards
const double _kCardImageHeight = 200.0;

/// Star icon size
const double _kStarIconSize = 18.0;

/// Button overlay alpha
const int _kButtonOverlayAlpha = 25;

//--------------------------------------------------------------------------------------------------------------------//
// ENUMS
//--------------------------------------------------------------------------------------------------------------------//

enum _ComplexCardType { carousel, tile, card }

//--------------------------------------------------------------------------------------------------------------------//
// WIDGETS
//--------------------------------------------------------------------------------------------------------------------//

/// A card widget that displays complex information in different layouts.
///
/// Supports three display modes:
/// - [ComplexCard.carousel]: Horizontal carousel with image background
/// - [ComplexCard.tile]: Compact tile layout (ready for custom implementation)
/// - [ComplexCard.card]: Full card layout with detailed information
class ComplexCard extends StatelessWidget {
  ComplexCard.carousel({
    super.key,
    required this.complex,
    required this.rating,
    this.index,
    ValueNotifier<int>? selectedIndex,
  }) : _type = _ComplexCardType.carousel,
       fullRadiusSide = null,
       selectedIndex = selectedIndex ?? ValueNotifier<int>(-1),
       onTap = null;

  ComplexCard.tile({
    super.key,
    this.fullRadiusSide = WidgetSide.none,
    required this.complex,
    required this.rating,
    this.index,
    ValueNotifier<int>? selectedIndex,
    this.onTap,
  }) : _type = _ComplexCardType.tile,
       selectedIndex = selectedIndex ?? ValueNotifier<int>(-1);

  ComplexCard.card({
    super.key,
    required this.complex,
    required this.rating,
    this.index,
    ValueNotifier<int>? selectedIndex,
  }) : _type = _ComplexCardType.card,
       fullRadiusSide = null,
       selectedIndex = selectedIndex ?? ValueNotifier<int>(-1),
       onTap = null;

  final _ComplexCardType _type;

  final WidgetSide? fullRadiusSide;

  final Complex complex;
  final double rating;

  final int? index;
  final ValueNotifier<int> selectedIndex;

  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    switch (_type) {
      case _ComplexCardType.carousel:
        return _ComplexCarouselCard(complex: complex, rating: rating, index: index, selectedIndex: selectedIndex);
      case _ComplexCardType.tile:
        return _ComplexTileCard(
          fullRadiusSide: fullRadiusSide!,
          complex: complex,
          rating: rating,
          index: index,
          selectedIndex: selectedIndex,
          onTap: onTap,
        );
      case _ComplexCardType.card:
        return _ComplexDisplayCard(complex: complex, rating: rating);
    }
  }
}

class _ComplexCarouselCard extends StatelessWidget {
  const _ComplexCarouselCard({
    required this.complex,
    required this.rating,
    required this.index,
    required this.selectedIndex,
  });

  final Complex complex;
  final double rating;

  final int? index;
  final ValueNotifier<int> selectedIndex;

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<int>(
      valueListenable: selectedIndex,
      builder: (context, currentIndex, _) {
        final isSelected = index == currentIndex;
        final hasSelection = selectedIndex.value != -1;
        final opacity = hasSelection && !isSelected ? _kNonSelectedOpacity : 1.0;

        return Card(
          margin: EdgeInsets.zero,
          color: Colors.transparent,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.0),
            side: isSelected
                ? BorderSide(color: Theme.of(context).colorScheme.primary, width: _kSelectedBorderWidth)
                : BorderSide.none,
          ),
          clipBehavior: Clip.none,
          child: Opacity(opacity: opacity, child: _buildContent(context)),
        );
      },
    );
  }

  Widget _buildContent(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final brightness = Theme.brightnessOf(context);

    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(image: AssetImage('assets/images/placeholders/court.jpg'), fit: BoxFit.cover),
      ),
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.black.withAlpha(_kGradientStartAlpha), Colors.black.withAlpha(_kGradientEndAlpha)],
            stops: _kCarouselGradientStops,
          ),
        ),
        padding: const EdgeInsets.all(16.0),
        child: SizedBox(
          width: double.infinity,
          child: ShaderMask(
            shaderCallback: (bounds) => LinearGradient(
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
              colors: [colorScheme.surface, colorScheme.surface.withAlpha(0)],
              stops: _kShaderMaskStops,
            ).createShader(bounds),
            blendMode: BlendMode.dstIn,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // TODO: Replace with actual condition
                if (true) _AvailabilityChip(),
                Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: 12.0,
                  children: [_buildTitle(context, brightness), _buildSportsRow(context)],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTitle(BuildContext context, Brightness brightness) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    final titleColor = brightness == Brightness.light ? colorScheme.surface : colorScheme.onSurface;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(complex.name, style: textTheme.titleLarge?.copyWith(color: titleColor), softWrap: false),
        const SizedBox(height: 4.0),
        ClipRect(
          child: OverflowBox(
            alignment: Alignment.centerLeft,
            maxWidth: double.infinity,
            fit: OverflowBoxFit.deferToChild,
            child: _ComplexRatingWidget(rating: rating, showStars: true),
          ),
        ),
      ],
    );
  }

  Widget _buildSportsRow(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ClipRect(
        child: OverflowBox(
          alignment: Alignment.centerLeft,
          maxWidth: double.infinity,
          fit: OverflowBoxFit.deferToChild,
          child: _ComplexSportsRow(sports: complex.sports),
        ),
      ),
    );
  }
}

class _ComplexTileCard extends StatelessWidget {
  const _ComplexTileCard({
    this.fullRadiusSide = WidgetSide.none,
    required this.complex,
    required this.rating,
    required this.index,
    required this.selectedIndex,
    required this.onTap,
  });

  final WidgetSide fullRadiusSide;

  final Complex complex;
  final double rating;

  final int? index;
  final ValueNotifier<int> selectedIndex;

  final VoidCallback? onTap;

  static BorderRadius _calculateBorderRadius(WidgetSide side) {
    if (side == WidgetSide.all) return BorderRadius.circular(12.0);
    if (side == WidgetSide.none) return BorderRadius.circular(4.0);

    final top = side == WidgetSide.top;
    final bottom = side == WidgetSide.bottom;

    return BorderRadius.vertical(top: Radius.circular(top ? 12.0 : 4.0), bottom: Radius.circular(bottom ? 12.0 : 4.0));
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return ValueListenableBuilder(
      valueListenable: selectedIndex,
      builder: (context, currentIndex, _) {
        final isSelected = index == currentIndex;

        return AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          margin: const EdgeInsets.symmetric(vertical: 1.0),
          decoration: BoxDecoration(
            color: isSelected
                ? colorScheme.primaryContainer
                : Theme.brightnessOf(context) == Brightness.light
                ? colorScheme.surfaceContainerLowest
                : colorScheme.surfaceContainerHigh,
            borderRadius: _calculateBorderRadius(isSelected ? WidgetSide.all : fullRadiusSide),
          ),
          clipBehavior: Clip.antiAlias,
          child: _buildContent(context, isSelected),
        );
      },
    );
  }

  Widget _buildContent(BuildContext context, bool isSelected) {
    return Material(
      type: MaterialType.transparency,
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            spacing: 16.0,
            children: [
              _ComplexImageContainer(width: _kTileImageSize, height: _kTileImageSize, borderRadius: 8.0),
              _buildBody(context, isSelected),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildBody(BuildContext context, bool isSelected) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: 8.0,
        children: [
          _ComplexTitle(brightness: Brightness.light, name: complex.name, address: complex.address),
          _buildInfo(context, isSelected),
        ],
      ),
    );
  }

  Widget _buildInfo(BuildContext context, bool isSelected) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      spacing: 8.0,
      children: [
        CustomChip.medium.neutral(
          palette: WidgetPalette.primary,
          icon: Symbols.star_rounded,
          filledIcon: true,
          label: rating.toString(),
        ),
        Expanded(
          child: LabeledInfoWidget.icon(
            icon: Symbols.schedule_rounded,
            label: 'Schedule',
            text: '${complex.timeIni} - ${complex.timeEnd}',
          ),
        ),
      ],
    );
  }
}

class _ComplexDisplayCard extends StatelessWidget {
  const _ComplexDisplayCard({required this.complex, required this.rating});

  final Complex complex;
  final double rating;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final brightness = Theme.brightnessOf(context);

    return Card.filled(
      margin: const EdgeInsets.symmetric(vertical: 4.0),
      color: brightness == Brightness.light ? colorScheme.surfaceContainerLowest : colorScheme.surfaceContainerHigh,
      clipBehavior: Clip.antiAlias,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          spacing: 16.0,
          children: [
            _ComplexTitle(name: complex.name, address: complex.address),
            _ComplexImageContainer(
              height: _kCardImageHeight,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    spacing: 8.0,
                    children: [
                      if (true) _AvailabilityChip(),
                      CustomChip.medium.translucent(
                        palette: WidgetPalette.primary,
                        icon: Symbols.star_rounded,
                        filledIcon: true,
                        label: rating.toString(),
                      ),
                    ],
                  ),
                  _ComplexSportsRow(sports: complex.sports),
                ],
              ),
            ),
            _buildInfo(context),
            _ComplexActionButtons(onMoreInfo: () {}, onBookCourt: () {}),
          ],
        ),
      ),
    );
  }

  Widget _buildInfo(BuildContext context) {
    return Row(
      spacing: 4.0,
      children: [
        Expanded(
          child: LabeledInfoWidget.icon(
            icon: Symbols.schedule_rounded,
            label: 'Schedule',
            text: '${complex.timeIni} - ${complex.timeEnd}',
          ),
        ),
      ],
    );
  }
}

class _ComplexTitle extends StatelessWidget {
  const _ComplexTitle({this.brightness = Brightness.light, required this.name, required this.address});

  final Brightness? brightness;

  final String name;
  final String address;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: 4.0,
      children: [
        Text(
          name,
          style: textTheme.titleLarge?.copyWith(
            color: brightness == Brightness.light ? colorScheme.onSurface : colorScheme.surface,
          ),
        ),
        Row(
          spacing: 4.0,
          children: [
            Icon(
              Symbols.location_on_rounded,
              size: 18,
              fill: 0,
              weight: 400,
              grade: 0,
              opticalSize: 18,
              color: brightness == Brightness.light ? colorScheme.onSurfaceVariant : colorScheme.outlineVariant,
            ),
            Expanded(
              child: MarqueeWidget(
                child: Text(
                  address,
                  style: textTheme.bodyMedium?.copyWith(
                    color: brightness == Brightness.light ? colorScheme.onSurfaceVariant : colorScheme.outlineVariant,
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

/// Image container with rating and sports overlay
class _ComplexImageContainer extends StatelessWidget {
  const _ComplexImageContainer({this.width, this.height, this.borderRadius, this.child});

  final double? width;
  final double? height;

  final double? borderRadius;

  final Widget? child;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        image: const DecorationImage(image: AssetImage('assets/images/placeholders/court.jpg'), fit: BoxFit.cover),
        borderRadius: BorderRadius.circular(borderRadius ?? 12.0),
      ),
      alignment: AlignmentGeometry.topCenter,
      padding: const EdgeInsets.all(16.0),
      child: child,
    );
  }
}

/// Displays the availability status chip
class _AvailabilityChip extends StatelessWidget {
  const _AvailabilityChip();

  @override
  Widget build(BuildContext context) {
    final palette = Theme.brightnessOf(context) == Brightness.light ? WidgetPalette.inverse : WidgetPalette.normal;

    return CustomChip.medium.success(palette: palette, label: 'Available');
  }
}

/// Displays the rating with stars and numeric value
class _ComplexRatingWidget extends StatelessWidget {
  const _ComplexRatingWidget({required this.rating, required this.showStars});

  final double rating;
  final bool showStars;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Row(
      spacing: 4.0,
      children: [
        if (showStars) _buildStars(context) else _buildSingleStar(context),
        Text(rating.toString(), style: textTheme.bodyMedium?.copyWith(color: colorScheme.primary), softWrap: false),
      ],
    );
  }

  Widget _buildStars(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Row(
      children: List.generate(5, (index) {
        final iconData = _getStarIcon(index);
        final iconFill = _getStarFill(index);

        return Icon(
          iconData,
          color: colorScheme.primary,
          size: _kStarIconSize,
          fill: iconFill,
          weight: 400,
          grade: 0,
          opticalSize: _kStarIconSize,
        );
      }),
    );
  }

  Widget _buildSingleStar(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Icon(
      Symbols.star_rounded,
      color: colorScheme.primary,
      size: _kStarIconSize,
      fill: 1,
      weight: 400,
      grade: 0,
      opticalSize: _kStarIconSize,
    );
  }

  IconData _getStarIcon(int index) {
    if (rating >= index + 1) return Symbols.star_rounded;
    if (rating >= index + 0.5) return Symbols.star_half_rounded;
    return Symbols.star_rounded;
  }

  double _getStarFill(int index) {
    return rating >= index + 0.5 ? 1.0 : 0.0;
  }
}

/// Displays the sports chips row
class _ComplexSportsRow extends StatelessWidget {
  final Set<Sport> sports;

  const _ComplexSportsRow({required this.sports});

  @override
  Widget build(BuildContext context) {
    return Row(
      spacing: 4.0,
      children: sports.map((sport) {
        return CustomChip.small.neutral(palette: WidgetPalette.primary, label: sport.name.toCapitalized());
      }).toList(),
    );
  }
}

/// Action buttons for the card (More info and Book court)
class _ComplexActionButtons extends StatelessWidget {
  const _ComplexActionButtons({required this.onMoreInfo, required this.onBookCourt});

  final VoidCallback onMoreInfo;
  final VoidCallback onBookCourt;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      spacing: 4.0,
      children: [
        TextButton(
          style: ButtonStyle(
            overlayColor: WidgetStatePropertyAll(_getTextButtonOverlayColor(context)),
            foregroundColor: WidgetStatePropertyAll(_getTextButtonForegroundColor(context)),
          ),
          onPressed: onMoreInfo,
          child: const Text('More info'),
        ),
        FilledButton(
          style: ButtonStyle(
            overlayColor: WidgetStatePropertyAll(colorScheme.onPrimary.withAlpha(_kButtonOverlayAlpha)),
            backgroundColor: WidgetStatePropertyAll(colorScheme.primary),
            foregroundColor: WidgetStatePropertyAll(colorScheme.onPrimary),
          ),
          onPressed: onBookCourt,
          child: const Text('Book court'),
        ),
      ],
    );
  }

  Color _getTextButtonOverlayColor(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Theme.brightnessOf(context) == Brightness.light
        ? colorScheme.onPrimary.withAlpha(_kButtonOverlayAlpha)
        : colorScheme.primary.withAlpha(_kButtonOverlayAlpha);
  }

  Color _getTextButtonForegroundColor(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Theme.brightnessOf(context) == Brightness.light ? colorScheme.onPrimary : colorScheme.primary;
  }
}

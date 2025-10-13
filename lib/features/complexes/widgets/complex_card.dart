import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:material_symbols_icons/material_symbols_icons.dart';
import 'package:sportying_app/core/utils/extension_utilities.dart';
import 'package:sportying_app/domain/models/complexes/complex.dart';
import 'package:sportying_app/domain/models/core/widget_size.dart';
import 'package:sportying_app/features/core/themes/theme.dart';
import 'package:sportying_app/features/core/widgets/scaffolds/labeled_info_widget.dart';
import 'package:sportying_app/features/core/widgets/visuals/small_chip.dart';

class ComplexCard extends StatelessWidget {
  final WidgetSize size;

  final Complex complex;
  final double rating;

  final int? index;
  final ValueNotifier<int> selectedIndex;

  const ComplexCard._(this.size, this.complex, this.rating, this.index, this.selectedIndex);

  factory ComplexCard.small({
    required Complex complex,
    required double rating,
    int? index,
    ValueNotifier<int>? selectedIndex,
  }) {
    ValueNotifier<int> notifier = selectedIndex ?? ValueNotifier<int>(-1);
    return ComplexCard._(WidgetSize.small, complex, rating, index, notifier);
  }

  factory ComplexCard.medium({
    required Complex complex,
    required double rating,
    int? index,
    ValueNotifier<int>? selectedIndex,
  }) {
    ValueNotifier<int> notifier = selectedIndex ?? ValueNotifier<int>(-1);
    return ComplexCard._(WidgetSize.medium, complex, rating, index, notifier);
  }

  factory ComplexCard.large({
    required Complex complex,
    required double rating,
    int? index,
    ValueNotifier<int>? selectedIndex,
  }) {
    ValueNotifier<int> notifier = selectedIndex ?? ValueNotifier<int>(-1);
    return ComplexCard._(WidgetSize.large, complex, rating, index, notifier);
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<int>(
      valueListenable: selectedIndex,
      builder: (context, currentIndex, _) {
        return size == WidgetSize.small
            ? _buildSmallCard(context, currentIndex)
            : Card.filled(
                margin: const EdgeInsets.all(4.0),
                clipBehavior: Clip.antiAlias,
                child: _buildLargeCard(context),
              );
      },
    );
  }

  Widget _buildSmallCard(BuildContext context, int currentIndex) {
    return Card(
      margin: EdgeInsetsGeometry.zero,
      color: Colors.transparent,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(28.0),
        side: index == currentIndex
            ? BorderSide(color: Theme.of(context).colorScheme.primary, width: 3.0)
            : BorderSide.none,
      ),
      clipBehavior: Clip.none,
      child: Opacity(
        opacity: selectedIndex.value != -1 && index != currentIndex ? 0.6 : 1.0,
        child: _buildSmallCardContent(context),
      ),
    );
  }

  Widget _buildSmallCardContent(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Container(
      decoration: BoxDecoration(
        image: const DecorationImage(image: AssetImage('assets/images/placeholders/court.jpg'), fit: BoxFit.cover),
      ),
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.black.withAlpha(25), Colors.black.withAlpha(150)],
            stops: const [0.4, 1.0],
          ),
        ),
        padding: const EdgeInsets.all(16.0),
        child: SizedBox(
          width: double.infinity,
          child: ShaderMask(
            shaderCallback: (Rect bounds) {
              return LinearGradient(
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
                colors: [colorScheme.surface, colorScheme.surface.withAlpha(0)],
                stops: [0.85, 1.0],
              ).createShader(bounds);
            },
            blendMode: BlendMode.dstIn,
            child: _buildSmallCardBody(context),
          ),
        ),
      ),
    );
  }

  Widget _buildSmallCardBody(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SmallChip.success(label: 'Available'),
        Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: 12.0,
          children: [
            _buildHeader(context),
            SizedBox(
              width: double.infinity,
              child: ClipRect(
                child: OverflowBox(
                  alignment: Alignment.centerLeft,
                  maxWidth: double.infinity,
                  fit: OverflowBoxFit.deferToChild,
                  child: _buildSportsRow(context),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildLargeCard(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 200.0,
          decoration: BoxDecoration(
            image: const DecorationImage(image: AssetImage('assets/images/placeholders/court.jpg'), fit: BoxFit.cover),
            borderRadius: BorderRadius.circular(12.0),
          ),
          alignment: AlignmentGeometry.topCenter,
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                spacing: 8.0,
                children: [
                  // TODO: substitute condition with real condition
                  if (true) SmallChip.success(label: 'Available'),
                ],
              ),
              _buildSportsRow(context),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: SizedBox(width: double.infinity, child: _buildLargeCardBody(context)),
        ),
      ],
    );
  }

  Widget _buildLargeCardBody(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final brightness = Theme.of(context).brightness;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: 16.0,
      children: [
        _buildHeader(context),
        Column(
          spacing: 8.0,
          children: [
            LabeledInfoWidget.dark(icon: Symbols.location_on_rounded, label: 'Address', text: complex.address),
            LabeledInfoWidget.dark(
              icon: Symbols.schedule_rounded,
              label: 'Schedule',
              text: '${complex.timeIni} - ${complex.timeEnd}',
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          spacing: 4.0,
          children: [
            TextButton(
              style: ButtonStyle(
                overlayColor: WidgetStatePropertyAll(
                  brightness == Brightness.light
                      ? colorScheme.secondary.withAlpha(25)
                      : colorScheme.secondary.withAlpha(25),
                ),
                foregroundColor: WidgetStatePropertyAll(
                  brightness == Brightness.light ? colorScheme.secondary : colorScheme.secondary,
                ),
              ),
              onPressed: () {},
              child: const Text('More info'),
            ),
            FilledButton(
              style: ButtonStyle(
                overlayColor: WidgetStatePropertyAll(
                  brightness == Brightness.light
                      ? colorScheme.secondary.withAlpha(25)
                      : colorScheme.secondary.withAlpha(25),
                ),
                backgroundColor: WidgetStatePropertyAll(
                  brightness == Brightness.light ? colorScheme.secondary : colorScheme.secondary,
                ),
                foregroundColor: WidgetStatePropertyAll(
                  brightness == Brightness.light ? colorScheme.onSecondary : colorScheme.onSecondary,
                ),
              ),
              onPressed: () {},
              child: const Text('Book court'),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildHeader(BuildContext context) {
    return _buildTitle(context);
  }

  Widget _buildTitle(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    final brightness = Theme.of(context).brightness;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          complex.name,
          style: textTheme.titleLarge?.copyWith(
            color: size == WidgetSize.small
                ? brightness == Brightness.light
                      ? colorScheme.surface
                      : colorScheme.onSurface
                : brightness == Brightness.light
                ? colorScheme.onSurface
                : colorScheme.onSurface,
          ),
          softWrap: false,
        ),
        const SizedBox(height: 4.0),
        ClipRect(
          child: OverflowBox(
            alignment: Alignment.centerLeft,
            maxWidth: double.infinity,
            fit: OverflowBoxFit.deferToChild,
            child: Row(
              spacing: 4.0,
              children: [
                Row(
                  children: List.generate(5, (index) {
                    IconData icon = Symbols.star_rounded;
                    double iconFill = 0.0;

                    if (rating >= index + 0.5) {
                      iconFill = 1.0;
                      icon = rating >= index + 1 ? icon : Symbols.star_half_rounded;
                    }

                    return Icon(
                      icon,
                      color: size == WidgetSize.small
                          ? colorScheme.primary
                          : brightness == Brightness.light
                          ? ClientTheme.primaryDim
                          : colorScheme.primary,
                      size: 18,
                      fill: iconFill,
                      weight: 400,
                      grade: 0,
                      opticalSize: 18,
                    );
                  }),
                ),
                Text(
                  rating.toString(),
                  style: textTheme.bodyMedium?.copyWith(
                    color: size == WidgetSize.small
                        ? colorScheme.primary
                        : brightness == Brightness.light
                        ? ClientTheme.primaryDim
                        : colorScheme.primary,
                  ),
                  softWrap: false,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildSportsRow(BuildContext context) {
    return Row(
      spacing: 4.0,
      children: complex.sports.map((sport) {
        return SmallChip.neutral(label: sport.name.toCapitalized());
      }).toList(),
    );
  }
}

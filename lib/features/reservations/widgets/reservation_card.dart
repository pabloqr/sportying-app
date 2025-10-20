import 'package:flutter/material.dart';
import 'package:material_symbols_icons/material_symbols_icons.dart';
import 'package:sportying_app/core/utils/extension_utilities.dart';
import 'package:sportying_app/domain/models/reservations/reservation.dart';
import 'package:sportying_app/domain/models/reservations/reservation_status.dart';
import 'package:sportying_app/features/core/widgets/visuals/pulsing_dot.dart';
import 'package:sportying_app/features/core/widgets/visuals/custom_container.dart';
// import 'package:sportying_app/features/core/widgets/visuals/translucent_container.dart';

class ReservationCard extends StatefulWidget {
  const ReservationCard({super.key, required this.reservation});

  final Reservation reservation;

  @override
  State<ReservationCard> createState() => _ReservationCardState();
}

class _ReservationCardState extends State<ReservationCard> {
  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Card(
      margin: EdgeInsetsGeometry.zero,
      color: Colors.transparent,
      // shape: RoundedRectangleBorder(borderRadius: BorderRadiusGeometry.circular(28.0)),
      elevation: 0.0,
      clipBehavior: Clip.antiAlias,
      child: Stack(
        children: [
          Column(
            children: [
              Container(
                padding: const EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 16.0),
                decoration: BoxDecoration(color: widget.reservation.reservationStatus.colorSurface(context)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  spacing: 8.0,
                  children: [
                    Row(
                      spacing: 8.0,
                      children: [
                        Icon(
                          Symbols.sports_tennis_rounded,
                          size: 32,
                          fill: 0,
                          weight: 400,
                          grade: 0,
                          opticalSize: 32,
                          color: colorScheme.onSurface,
                        ),
                        Text(
                          widget.reservation.court.sport.name.toCapitalized(),
                          style: textTheme.titleLarge?.copyWith(color: colorScheme.onSurface),
                        ),
                      ],
                    ),
                    Row(
                      spacing: 4.0,
                      children: [
                        if (widget.reservation.reservationStatus.isActive)
                          PulsingDot(color: widget.reservation.reservationStatus.colorOnSurface(context)),
                        Text(
                          widget.reservation.reservationStatus.name.toUpperCase(),
                          style: textTheme.titleSmall?.copyWith(
                            color: widget.reservation.reservationStatus.colorOnSurface(context),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const Divider(height: 1.0),
              Container(
                padding: const EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 16.0),
                decoration: BoxDecoration(color: colorScheme.surfaceContainerLowest),
                child: Column(
                  spacing: 16.0,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      spacing: 8.0,
                      children: [
                        CustomContainer.filled(
                          width: 65.0,
                          color: colorScheme.surfaceContainerHighest,
                          child: Column(
                            children: [
                              Text(
                                widget.reservation.dateIni.toFormattedWeekDay0().toUpperCase(),
                                style: textTheme.bodyMedium,
                              ),
                              Text(widget.reservation.dateIni.toFormattedMonthDay0(), style: textTheme.titleLarge),
                              Text(
                                widget.reservation.dateIni.toFormattedMonth0().toUpperCase(),
                                style: textTheme.bodyMedium,
                              ),
                            ],
                          ),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                              '${widget.reservation.dateIni.toFormattedTime0()} - ${widget.reservation.dateEnd.toFormattedTime0()}',
                              style: textTheme.titleLarge?.copyWith(color: colorScheme.onSurface),
                            ),
                            Row(
                              spacing: 4.0,
                              children: [
                                Icon(
                                  Symbols.sports_rounded,
                                  size: 18,
                                  fill: 0,
                                  weight: 400,
                                  grade: 0,
                                  opticalSize: 18,
                                  color: colorScheme.onSurfaceVariant,
                                ),
                                Text(
                                  widget.reservation.court.name,
                                  style: textTheme.bodyMedium?.copyWith(color: colorScheme.onSurfaceVariant),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      spacing: 4.0,
                      children: [
                        Text(
                          widget.reservation.complex.name,
                          style: textTheme.titleLarge?.copyWith(color: colorScheme.onSurface),
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
                              color: colorScheme.onSurfaceVariant,
                            ),
                            Text(
                              widget.reservation.complex.address,
                              style: textTheme.bodyMedium?.copyWith(color: colorScheme.onSurfaceVariant),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const Divider(height: 1.0),
              Container(
                padding: const EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 16.0),
                decoration: BoxDecoration(color: colorScheme.surfaceContainerLowest),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('00,00€', style: textTheme.titleLarge?.copyWith(color: colorScheme.onSurface)),
                        Row(
                          children: [
                            Icon(
                              Symbols.tag_rounded,
                              size: 18,
                              fill: 0,
                              weight: 400,
                              grade: 0,
                              opticalSize: 18,
                              color: colorScheme.onSurfaceVariant,
                            ),
                            Text(
                              widget.reservation.id.toString().padLeft(8, '0'),
                              style: textTheme.bodyMedium?.copyWith(color: colorScheme.onSurfaceVariant),
                            ),
                          ],
                        ),
                      ],
                    ),
                    TextButton.icon(
                      style: ButtonStyle(
                        padding: WidgetStatePropertyAll(const EdgeInsets.fromLTRB(8.0, 4.0, 0.0, 4.0)),
                        overlayColor: WidgetStatePropertyAll(colorScheme.onPrimary.withAlpha(25)),
                        foregroundColor: WidgetStatePropertyAll(colorScheme.onPrimary),
                      ),
                      onPressed: () {},
                      iconAlignment: IconAlignment.end,
                      icon: Icon(
                        Symbols.chevron_right_rounded,
                        size: 24,
                        fill: 0,
                        weight: 400,
                        grade: 0,
                        opticalSize: 24,
                      ),
                      label: Text('More info'),
                    ),
                  ],
                ),
              ),
            ],
          ),
          Positioned(
            left: 0,
            top: 0,
            bottom: 0,
            child: Container(
              width: 4,
              decoration: BoxDecoration(color: widget.reservation.reservationStatus.colorOnSurface(context)),
            ),
          ),
        ],
      ),
    );
  }
}

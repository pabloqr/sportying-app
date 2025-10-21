import 'package:flutter/material.dart';
import 'package:material_symbols_icons/material_symbols_icons.dart';
import 'package:sportying_app/core/utils/extension_utilities.dart';
import 'package:sportying_app/domain/models/reservations/reservation.dart';
import 'package:sportying_app/domain/models/reservations/reservation_status.dart';
import 'package:sportying_app/features/core/widgets/visuals/custom_container.dart';
import 'package:sportying_app/features/core/widgets/visuals/pulsing_dot.dart';

class ReservationCard extends StatefulWidget {
  const ReservationCard({super.key, required this.reservation});

  final Reservation reservation;

  @override
  State<ReservationCard> createState() => _ReservationCardState();
}

class _ReservationCardState extends State<ReservationCard> {
  @override
  Widget build(BuildContext context) {
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
              _buildHeader(context),
              const Divider(height: 1.0),
              _buildBody(context),
              const Divider(height: 1.0),
              _buildFooter(context),
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

  Widget _buildHeader(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Material(
      color: widget.reservation.reservationStatus.colorSurface(context),
      child: InkWell(
        overlayColor: WidgetStatePropertyAll(
          widget.reservation.reservationStatus.colorOnSurface(context).withAlpha(25),
        ),
        onTap: () {},
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            spacing: 8.0,
            children: [
              Row(
                spacing: 8.0,
                children: [
                  Icon(
                    Symbols.sports_tennis_rounded,
                    size: 28,
                    fill: 0,
                    weight: 400,
                    grade: 0,
                    opticalSize: 28,
                    color: colorScheme.onSurface,
                  ),
                  Text(
                    widget.reservation.court.sport.name.toCapitalized(),
                    style: textTheme.titleLarge?.copyWith(color: colorScheme.onSurfaceVariant),
                  ),
                ],
              ),
              Row(
                spacing: 16.0,
                children: [
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
                  Icon(
                    Symbols.chevron_right_rounded,
                    size: 24,
                    fill: 0,
                    weight: 400,
                    grade: 0,
                    opticalSize: 24,
                    color: colorScheme.onSurface,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildBody(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Container(
      padding: const EdgeInsets.all(16.0),
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
                    Text(widget.reservation.dateIni.toFormattedWeekDay0().toUpperCase(), style: textTheme.bodyMedium),
                    Text(widget.reservation.dateIni.toFormattedMonthDay0(), style: textTheme.titleLarge),
                    Text(widget.reservation.dateIni.toFormattedMonth0().toUpperCase(), style: textTheme.bodyMedium),
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
    );
  }

  Widget _buildFooter(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
      decoration: BoxDecoration(color: colorScheme.surfaceContainerLowest),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
    );
  }
}

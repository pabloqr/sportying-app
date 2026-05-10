import 'package:flutter/material.dart';
import 'package:material_symbols_icons/material_symbols_icons.dart';
import 'package:sportying_app/core/utils/extension_utils.dart';
import 'package:sportying_app/domain/models/reservations/reservation.dart';
import 'package:sportying_app/features/core/widgets/scaffolds/labeled_info_widget.dart';
import 'package:sportying_app/features/core/widgets/utils/marquee_widget.dart';
import 'package:sportying_app/features/core/widgets/visuals/time_progress_indicator.dart';

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
    final brightness = Theme.brightnessOf(context);

    return Card(
      margin: const EdgeInsets.symmetric(vertical: 4.0),
      color: brightness == Brightness.light ? colorScheme.surfaceContainerLowest : colorScheme.surfaceContainerHigh,
      elevation: 0.0,
      clipBehavior: Clip.antiAlias,
      child: Column(children: [_buildHeader(context), _buildBody(context), _buildButtons(context)]),
    );
  }

  Widget _buildHeader(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Container(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        spacing: 8.0,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: 4.0,
              children: [
                Text(
                  widget.reservation.complex.name,
                  style: textTheme.titleMedium?.copyWith(color: colorScheme.onSurface),
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
                    Expanded(
                      child: MarqueeWidget(
                        child: Text(
                          widget.reservation.complex.address,
                          style: textTheme.bodyMedium?.copyWith(color: colorScheme.onSurfaceVariant),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          IconButton.filled(
            onPressed: () {},
            icon: Icon(
              Symbols.directions_rounded,
              size: 24,
              fill: 1,
              weight: 400,
              grade: 0,
              opticalSize: 24,
              color: colorScheme.onPrimary,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBody(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(spacing: 2.0, children: [_buildProgressIndicator(context), _buildInfo(context)]),
    );
  }

  Widget _buildProgressIndicator(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: colorScheme.surfaceContainerLow,
        borderRadius: BorderRadius.vertical(top: Radius.circular(12.0), bottom: Radius.circular(4.0)),
      ),
      child: Row(
        spacing: 16.0,
        children: [
          TimeProgressIndicator(
            sport: widget.reservation.court.sport,
            date: DateTimeRange(start: widget.reservation.dateIni, end: widget.reservation.dateEnd),
            status: widget.reservation.reservationStatus,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: 8.0,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${widget.reservation.dateIni.toFormattedTime0()} - ${widget.reservation.dateEnd.toFormattedTime0()}',
                    style: textTheme.titleMedium?.copyWith(color: colorScheme.onSurface),
                  ),
                  Text(
                    widget.reservation.dateIni.toFormattedDate2(),
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

  Widget _buildInfo(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Row(
      spacing: 2.0,
      children: [
        Expanded(
          child: Container(
            padding: const EdgeInsets.all(16.0),
            height: 80.0,
            decoration: BoxDecoration(
              color: colorScheme.surfaceContainerLow,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(4.0),
                topRight: Radius.circular(4.0),
                bottomLeft: Radius.circular(12.0),
                bottomRight: Radius.circular(4.0),
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                LabeledInfoWidget(
                  label: 'FACILITY',
                  text: '${widget.reservation.court.sport.name.toCapitalized()} · ${widget.reservation.court.name}',
                  customTextTheme: textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: colorScheme.onSurface,
                  ),
                ),
              ],
            ),
          ),
        ),
        Expanded(
          child: Container(
            padding: const EdgeInsets.all(16.0),
            height: 80.0,
            decoration: BoxDecoration(
              color: colorScheme.surfaceContainerLow,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(4.0),
                topRight: Radius.circular(4.0),
                bottomLeft: Radius.circular(4.0),
                bottomRight: Radius.circular(12.0),
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                LabeledInfoWidget(
                  label: 'PRICE',
                  text: '00,00€',
                  customTextTheme: textTheme.titleMedium?.copyWith(color: colorScheme.onSurface),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildButtons(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        spacing: 4.0,
        children: [
          TextButton(onPressed: () {}, child: const Text('More info')),
          FilledButton(onPressed: () {}, child: const Text('Modify')),
        ],
      ),
    );
  }
}

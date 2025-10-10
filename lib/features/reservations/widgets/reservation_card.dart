import 'package:flutter/material.dart';
import 'package:material_symbols_icons/material_symbols_icons.dart';
import 'package:sportying_app/core/utils/extension_utilities.dart';
import 'package:sportying_app/domain/models/reservations/reservation.dart';
import 'package:sportying_app/domain/models/reservations/reservation_status.dart';
import 'package:sportying_app/features/core/widgets/info_section_widget.dart';
import 'package:sportying_app/features/core/widgets/labeled_info_widget.dart';
import 'package:sportying_app/features/core/widgets/marquee_widget.dart';

class ReservationCard extends StatefulWidget {
  final int? userId;
  final Reservation reservation;

  const ReservationCard({super.key, required this.userId, required this.reservation});

  @override
  State<ReservationCard> createState() => _ReservationCardState();
}

class _ReservationCardState extends State<ReservationCard> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Card.filled(
      margin: const EdgeInsets.all(4.0),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: 16.0,
          children: [
            Row(
              spacing: 8.0,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    spacing: 4.0,
                    children: [
                      Text(widget.reservation.complex.name, style: textTheme.titleLarge),
                      MarqueeWidget(
                        child: Text(
                          widget.reservation.complex.address,
                          style: textTheme.titleSmall?.copyWith(color: colorScheme.onSurfaceVariant),
                          overflow: TextOverflow.fade,
                        ),
                      ),
                    ],
                  ),
                ),
                widget.reservation.reservationStatus.mediumStatusChip,
              ],
            ),
            InfoSectionWidget(
              leftChildren: [
                LabeledInfoWidget(
                  icon: Symbols.location_on_rounded,
                  label: 'Court',
                  text: widget.reservation.court.name,
                ),
                LabeledInfoWidget(icon: Symbols.sports_rounded, label: 'Sport', text: 'Sport'),
              ],
              rightChildren: [
                LabeledInfoWidget(
                  icon: Symbols.calendar_month_rounded,
                  label: 'Date',
                  text: widget.reservation.dateIni.toFormattedDate(),
                ),
                LabeledInfoWidget(
                  icon: Symbols.schedule_rounded,
                  label: 'Time',
                  text:
                      '${widget.reservation.dateIni.toFormattedTime()} - ${widget.reservation.dateEnd.toFormattedTime()}',
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              spacing: 4.0,
              children: [
                TextButton(onPressed: () {}, child: const Text('More info')),
                if (widget.reservation.reservationStatus == ReservationStatus.scheduled ||
                    widget.reservation.reservationStatus == ReservationStatus.weather)
                  FilledButton(onPressed: () {}, child: const Text('Modify')),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

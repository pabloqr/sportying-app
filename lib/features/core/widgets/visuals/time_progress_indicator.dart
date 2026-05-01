import 'package:flutter/material.dart';
import 'package:material_symbols_icons/material_symbols_icons.dart';
import 'package:sportying_app/core/utils/extension_utilities.dart';
import 'package:sportying_app/domain/models/complexes/sport.dart';
import 'package:sportying_app/domain/models/reservations/reservation_status.dart';
import 'package:sportying_app/features/core/widgets/utils/dashed_circular_border_painter.dart';

class TimeProgressIndicator extends StatelessWidget {
  const TimeProgressIndicator({super.key, required this.sport, required this.date, required this.status});

  final Sport sport;

  final DateTimeRange date;
  final ReservationStatus status;

  @override
  Widget build(BuildContext context) {
    if (status == ReservationStatus.scheduled && DateTime.now().isBetween(date.start, date.end)) {
      return _buildOngoingIndicator(context);
    }

    final isUpcoming = status == ReservationStatus.scheduled || status == ReservationStatus.weather;
    return isUpcoming ? _buildUpcomingIndicator(context) : _buildCompletedIndicator(context);
  }

  Widget _buildUpcomingIndicator(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Container(
      alignment: AlignmentGeometry.center,
      width: 96.0,
      height: 96.0,
      decoration: BoxDecoration(color: status.colorSurface(context), shape: BoxShape.circle),
      child: CustomPaint(
        painter: DashedCircularBorderPainter(
          color: status.colorPrimary(context),
          strokeWidth: 2.0,
          dashLength: 8.0,
          dashGap: 6.0,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          spacing: 4.0,
          children: [
            Icon(
              status.icon,
              size: 28,
              fill: 0,
              weight: 400,
              grade: 0,
              opticalSize: 28,
              color: status.colorOnSurface(context),
            ),
            Text(
              status.name.toCapitalized(),
              textAlign: TextAlign.center,
              style: textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.bold, color: status.colorOnSurface(context)),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildOngoingIndicator(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    // Calcular la fracción de tiempo pasada entre el inicio y el final de la reserva
    double fraction;

    // Obtener el instante de tiempo actual
    final current = DateTime.now();

    // Calcular la duración total de tiempo
    final totalDuration = date.end.difference(date.start).inMilliseconds;
    if (totalDuration == 0) fraction = 0.0;

    // Obtener el tiempo pasado hasta el instante actual
    final elapsed = current.difference(date.start).inMilliseconds;

    // Calcular la fracción de tiempo transcurrida y asegurar que se encuentra en rango
    fraction = elapsed / totalDuration;
    fraction.clamp(0.0, 1.0);

    // Calcular el tiempo restante y obtener la cadena de texto representativa
    final remaining = date.end.difference(current);
    final remainingText = remaining.inHours > 0 && remaining.inMinutes.remainder(60) > 0
        ? '${remaining.inHours}h ${remaining.inMinutes.remainder(60)}m'
        : remaining.inHours > 0
        ? '${remaining.inHours}h'
        : '${remaining.inMinutes}m';

    return Stack(
      alignment: AlignmentGeometry.center,
      children: [
        CircularProgressIndicator(
          // ignore: deprecated_member_use
          year2023: false,
          padding: EdgeInsets.zero,
          backgroundColor: colorScheme.primaryContainer,
          constraints: BoxConstraints(minWidth: 96.0, minHeight: 96.0),
          strokeWidth: 6.0,
          value: fraction,
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          spacing: 6.0,
          children: [
            Icon(sport.icon, size: 28, fill: 0, weight: 400, grade: 0, opticalSize: 28),
            Column(
              children: [
                Text('REMAINING', style: textTheme.labelSmall?.copyWith(color: colorScheme.onSurfaceVariant)),
                Text(remainingText, style: textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.bold)),
              ],
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildCompletedIndicator(BuildContext context) {
    return Container(
      alignment: AlignmentGeometry.center,
      width: 48.0,
      height: 48.0,
      decoration: BoxDecoration(color: status.colorOnSurface(context), shape: BoxShape.circle),
      child: Icon(
        Symbols.check_rounded,
        size: 28,
        fill: 0,
        weight: 400,
        grade: 0,
        opticalSize: 28,
        color: status.colorSurface(context),
      ),
    );
  }
}

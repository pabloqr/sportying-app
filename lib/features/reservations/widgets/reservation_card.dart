import 'package:flutter/material.dart';
import 'package:material_symbols_icons/material_symbols_icons.dart';
import 'package:sportying_app/domain/models/reservations/reservation.dart';
import 'package:sportying_app/features/core/utils/dashed_line_painter.dart';
import 'package:sportying_app/features/core/widgets/info_section_widget.dart';
import 'package:sportying_app/features/core/widgets/labeled_info_widget.dart';
import 'package:sportying_app/features/core/widgets/small_chip.dart';
import 'package:sportying_app/features/core/widgets/translucent_container.dart';

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

    final brightness = Theme.of(context).brightness;

    return Stack(
      clipBehavior: Clip.none,
      children: [
        ClipPath(
          clipper: _TicketClipper(),
          child: Card.filled(
            margin: EdgeInsets.zero,
            color: Colors.transparent,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(28.0)),
            clipBehavior: Clip.antiAlias,
            child: Column(
              children: [
                Container(
                  padding: EdgeInsets.fromLTRB(16.0, 24.0, 16.0, 16.0),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [colorScheme.primary, colorScheme.primary.withAlpha(200)],
                    ),
                  ),
                  child: Column(
                    spacing: 16.0,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        spacing: 16.0,
                        children: [
                          TranslucentContainer(
                            child: Icon(
                              Symbols.sports_tennis_rounded,
                              size: 24,
                              fill: 0,
                              weight: 400,
                              grade: 0,
                              opticalSize: 24,
                              color: colorScheme.onPrimary,
                            ),
                          ),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              spacing: 4.0,
                              children: [
                                Text(
                                  'Sports Complex Plaza',
                                  style: textTheme.titleLarge?.copyWith(color: colorScheme.onPrimary),
                                ),
                                Text(
                                  'Av. Principal 123, Granada',
                                  style: textTheme.titleSmall?.copyWith(
                                    color: brightness == Brightness.light
                                        ? colorScheme.primaryContainer
                                        : colorScheme.onPrimaryContainer,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      Column(
                        spacing: 4.0,
                        children: [
                          TranslucentContainer(
                            child: LabeledInfoWidget.light(
                              showIcon: false,
                              icon: Symbols.calendar_month_rounded,
                              label: 'Date',
                              text: 'Mon, 00 Jan 0000',
                            ),
                          ),
                          TranslucentContainer(
                            child: InfoSectionWidget(
                              leftChildren: [
                                LabeledInfoWidget.light(
                                  showIcon: false,
                                  icon: Symbols.location_on_rounded,
                                  label: 'Court',
                                  text: 'Court 1',
                                ),
                              ],
                              rightChildren: [
                                LabeledInfoWidget.light(
                                  showIcon: false,
                                  icon: Symbols.schedule_rounded,
                                  label: 'Time',
                                  text: '00:00 - 00:00',
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Row(
                  children: [
                    Expanded(
                      child: CustomPaint(
                        painter: DashedLinePainter(
                          color: brightness == Brightness.light ? colorScheme.tertiary : colorScheme.tertiaryContainer,
                        ),
                        child: const SizedBox(height: 1),
                      ),
                    ),
                  ],
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                  color: brightness == Brightness.light ? colorScheme.tertiary : colorScheme.tertiaryContainer,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '00,00€',
                        style: textTheme.titleLarge?.copyWith(
                          color: brightness == Brightness.light
                              ? colorScheme.onTertiary
                              : colorScheme.onTertiaryContainer,
                        ),
                      ),
                      TextButton(
                        style: ButtonStyle(
                          overlayColor: WidgetStatePropertyAll(
                            brightness == Brightness.light
                                ? colorScheme.tertiaryContainer.withAlpha(25)
                                : colorScheme.tertiary.withAlpha(25),
                          ),
                          foregroundColor: WidgetStatePropertyAll(
                            brightness == Brightness.light ? colorScheme.onTertiary : colorScheme.onTertiaryContainer,
                          ),
                        ),
                        onPressed: () {},
                        child: Text('More info'),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        Positioned(
          left: 16.0,
          top: -8.0,
          child: brightness == Brightness.light
              ? SmallChip.neutralLight(label: 'Scheduled')
              : SmallChip.neutralDark(label: 'Scheduled'),
        ),
      ],
    );
  }
}

class _TicketClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    double cornerRadius = 20.0;
    double notchRadius = 12.0;
    double notchPosition = 284.0; // Posición del notch horizontal

    // Empezar desde la esquina superior izquierda (con radio)
    path.moveTo(cornerRadius, 0);

    // Línea superior hasta la esquina superior derecha
    path.lineTo(size.width - cornerRadius, 0);

    // Esquina superior derecha redondeada
    path.quadraticBezierTo(size.width, 0, size.width, cornerRadius);

    // Lado derecho hasta antes del notch derecho
    path.lineTo(size.width, notchPosition - notchRadius);

    // Notch semicircular derecho
    path.arcToPoint(
      Offset(size.width, notchPosition + notchRadius),
      radius: Radius.circular(notchRadius),
      clockwise: false,
    );

    // Continuar por el lado derecho hasta la esquina inferior derecha
    path.lineTo(size.width, size.height - cornerRadius);

    // Esquina inferior derecha redondeada
    path.quadraticBezierTo(size.width, size.height, size.width - cornerRadius, size.height);

    // Línea inferior hasta la esquina inferior izquierda
    path.lineTo(cornerRadius, size.height);

    // Esquina inferior izquierda redondeada
    path.quadraticBezierTo(0, size.height, 0, size.height - cornerRadius);

    // Lado izquierdo hasta antes del notch izquierdo
    path.lineTo(0, notchPosition + notchRadius);

    // Notch semicircular izquierdo
    path.arcToPoint(Offset(0, notchPosition - notchRadius), radius: Radius.circular(notchRadius), clockwise: false);

    // Continuar hasta la esquina superior izquierda
    path.lineTo(0, cornerRadius);

    // Esquina superior izquierda redondeada
    path.quadraticBezierTo(0, 0, cornerRadius, 0);

    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}

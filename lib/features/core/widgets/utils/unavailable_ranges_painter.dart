import 'package:flutter/material.dart';

class UnavailableRangesPainter extends CustomPainter {
  UnavailableRangesPainter({
    required this.unavailableRanges,
    required this.minTime,
    required this.maxTime,
    required this.fillColor,
    required this.strokeColor,
    this.restrictionHeight = 0.6,
    this.verticalOffset = 0.2,
    this.horizontalPadding = 5.0,
    this.minWidth = 0.0,
  });

  final List<RangeValues> unavailableRanges;
  final double minTime;
  final double maxTime;
  final double restrictionHeight;
  final double verticalOffset;
  final double horizontalPadding;
  final double minWidth;
  final Color fillColor;
  final Color strokeColor;

  @override
  void paint(Canvas canvas, Size size) {
    // Usa los colores pasados por parámetro
    final paint = Paint()
      ..color = fillColor
      ..style = PaintingStyle.fill;

    final strokePaint = Paint()
      ..color = strokeColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.0;

    // Radio del slider (aproximadamente la mitad de la altura del track)
    final trackRadius = size.height * 0.3;

    for (final restriction in unavailableRanges) {
      // Solo dibujar si la restricción está en el rango visible actual
      if (restriction.end > minTime && restriction.start < maxTime) {
        final startX = ((restriction.start - minTime) / (maxTime - minTime)) * size.width;
        final endX = ((restriction.end - minTime) / (maxTime - minTime)) * size.width;

        final clampedStartX = startX.clamp(0.0, size.width);
        final clampedEndX = endX.clamp(0.0, size.width);

        final rect = Rect.fromLTWH(clampedStartX, size.height * 0.2, clampedEndX - clampedStartX, size.height * 0.6);

        // Determinar qué esquinas deben ser redondeadas
        final touchesLeftEdge = startX <= 0.0;
        final touchesRightEdge = endX >= size.width;

        // Crear el RRect con redondeo condicional
        RRect roundedRect;

        if (touchesLeftEdge && touchesRightEdge) {
          // Toca ambos extremos - redondear ambos lados
          roundedRect = RRect.fromRectAndRadius(rect, Radius.circular(trackRadius));
        } else if (touchesLeftEdge) {
          // Toca solo el extremo izquierdo - redondear solo la izquierda
          roundedRect = RRect.fromRectAndCorners(
            rect,
            topLeft: Radius.circular(trackRadius),
            bottomLeft: Radius.circular(trackRadius),
            topRight: const Radius.circular(4),
            bottomRight: const Radius.circular(4),
          );
        } else if (touchesRightEdge) {
          // Toca solo el extremo derecho - redondear solo la derecha
          roundedRect = RRect.fromRectAndCorners(
            rect,
            topLeft: const Radius.circular(4),
            bottomLeft: const Radius.circular(4),
            topRight: Radius.circular(trackRadius),
            bottomRight: Radius.circular(trackRadius),
          );
        } else {
          // No toca ningún extremo - redondeo normal
          roundedRect = RRect.fromRectAndRadius(rect, const Radius.circular(4));
        }

        // Dibujar el rectángulo de restricción
        canvas.drawRRect(roundedRect, paint);

        // Dibujar el borde
        canvas.drawRRect(roundedRect, strokePaint);
      }
    }
  }

  @override
  bool shouldRepaint(covariant UnavailableRangesPainter oldDelegate) =>
      oldDelegate.unavailableRanges != unavailableRanges ||
      oldDelegate.minTime != minTime ||
      oldDelegate.maxTime != maxTime ||
      oldDelegate.fillColor != fillColor ||
      oldDelegate.strokeColor != strokeColor ||
      oldDelegate.restrictionHeight != restrictionHeight ||
      oldDelegate.verticalOffset != verticalOffset ||
      oldDelegate.horizontalPadding != horizontalPadding ||
      oldDelegate.minWidth != minWidth;
}

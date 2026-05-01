import 'package:flutter/material.dart';

class DashedCircularBorderPainter extends CustomPainter {
  final Color color;
  final double strokeWidth;
  final double dashLength;
  final double dashGap;

  DashedCircularBorderPainter({
    required this.color,
    required this.strokeWidth,
    required this.dashLength,
    required this.dashGap,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = strokeWidth
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round; // Opcional: bordes redondeados en las líneas

    // Definir el círculo base. Restamos la mitad del grosor para que el borde
    // quede dentro del área del widget.
    final radius = (size.width - strokeWidth) / 2;
    final center = Offset(size.width / 2, size.height / 2);

    // Creamos el camino (path) del círculo completo
    final circularPath = Path()..addOval(Rect.fromCircle(center: center, radius: radius));

    // Convertimos el camino sólido en discontinuo
    final dashedPath = _dashPath(circularPath, dashArray: CircularIntervalList<double>([dashLength, dashGap]));

    canvas.drawPath(dashedPath, paint);
  }

  // Función auxiliar para crear el efecto discontinuo en cualquier Path
  Path _dashPath(Path source, {required CircularIntervalList<double> dashArray}) {
    final dest = Path();
    for (final metric in source.computeMetrics()) {
      var distance = 0.0;
      var draw = true;
      while (distance < metric.length) {
        final len = dashArray.next;
        if (draw) {
          dest.addPath(metric.extractPath(distance, distance + len), Offset.zero);
        }
        distance += len;
        draw = !draw;
      }
    }
    return dest;
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

// Clase auxiliar pequeña para manejar el patrón de repetición
class CircularIntervalList<T> {
  final List<T> _vals;
  int _idx = 0;
  CircularIntervalList(this._vals);
  T get next {
    if (_idx >= _vals.length) _idx = 0;
    return _vals[_idx++];
  }
}

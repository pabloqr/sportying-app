import 'dart:math' as math;

import 'package:flutter/material.dart';

class WavyProgressIndicator extends StatefulWidget {
  const WavyProgressIndicator({
    super.key,
    required this.value,
    this.height = 8.0,
    this.progressColor,
    this.fillerColor,
    this.waveAmplitude = 4.0,
    this.waveFrequency = 0.12,
    this.animationDuration = const Duration(milliseconds: 300),
  });

  final double value;
  final double height;
  final Color? progressColor;
  final Color? fillerColor;
  final double waveAmplitude;
  final double waveFrequency;
  final Duration animationDuration;

  @override
  State<WavyProgressIndicator> createState() => _WavyProgressIndicatorState();
}

class _WavyProgressIndicatorState extends State<WavyProgressIndicator> with TickerProviderStateMixin {
  late AnimationController _waveController;
  late AnimationController _progressController;
  late AnimationController _flattenController;
  late Animation<double> _progressAnimation;
  late Animation<double> _flattenAnimation;

  double _currentValue = 0.0;
  double _previousValue = 0.0;

  @override
  void initState() {
    super.initState();

    // Controlador para el serpenteo continuo de las ondas
    _waveController = AnimationController(vsync: this, duration: const Duration(seconds: 2))..repeat();

    // Controlador para animar el progreso
    _progressController = AnimationController(vsync: this, duration: widget.animationDuration);

    // Controlador para aplanar las ondas al completar
    _flattenController = AnimationController(vsync: this, duration: const Duration(milliseconds: 500));

    _currentValue = widget.value;
    _previousValue = widget.value;

    _progressAnimation = Tween<double>(
      begin: _previousValue,
      end: _currentValue,
    ).animate(CurvedAnimation(parent: _progressController, curve: Curves.easeInOut));

    _flattenAnimation = Tween<double>(
      begin: 1.0,
      end: 0.0,
    ).animate(CurvedAnimation(parent: _flattenController, curve: Curves.easeInOut));

    // Iniciar animación de aplanado si ya está completo
    if (widget.value >= 1.0) {
      _flattenController.forward();
    }
  }

  @override
  void didUpdateWidget(WavyProgressIndicator oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (oldWidget.value != widget.value) {
      _previousValue = _currentValue;
      _currentValue = widget.value;

      _progressAnimation = Tween<double>(
        begin: _previousValue,
        end: _currentValue,
      ).animate(CurvedAnimation(parent: _progressController, curve: Curves.easeInOut));

      _progressController.forward(from: 0.0);

      // Animar aplanado al completar
      if (widget.value >= 1.0 && oldWidget.value < 1.0) {
        _flattenController.forward(from: 0.0);
      } else if (widget.value < 1.0 && oldWidget.value >= 1.0) {
        _flattenController.reverse(from: 1.0);
      }
    }
  }

  @override
  void dispose() {
    _waveController.dispose();
    _progressController.dispose();
    _flattenController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return AnimatedBuilder(
      animation: Listenable.merge([_waveController, _progressController, _flattenController]),
      builder: (context, child) {
        return Stack(
          children: [
            SizedBox(
              height: widget.height,
              child: CustomPaint(
                painter: _WavyProgressPainter(
                  value: _progressAnimation.value,
                  progressColor: widget.progressColor ?? colorScheme.primary,
                  fillerColor: widget.fillerColor ?? colorScheme.surfaceContainer,
                  waveAmplitude: widget.waveAmplitude,
                  waveFrequency: widget.waveFrequency,
                  wavePhase: _waveController.value * 2 * math.pi,
                  flattenFactor: _flattenAnimation.value,
                ),
                child: Container(),
              ),
            ),
            Positioned(
              top: 2.0,
              right: 4.0,
              child: Container(
                width: 4.0,
                height: 4.0,
                decoration: BoxDecoration(shape: BoxShape.circle, color: widget.progressColor),
              ),
            ),
          ],
        );
      },
    );
  }
}

class _WavyProgressPainter extends CustomPainter {
  final double value;
  final Color progressColor;
  final Color fillerColor;
  final double waveAmplitude;
  final double waveFrequency;
  final double wavePhase;
  final double flattenFactor;

  _WavyProgressPainter({
    required this.value,
    required this.progressColor,
    required this.fillerColor,
    required this.waveAmplitude,
    required this.waveFrequency,
    required this.wavePhase,
    required this.flattenFactor,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final progressWidth = size.width * value;

    if (value < 1.0) {
      final fillerPaint = Paint()
        ..color = fillerColor
        ..style = PaintingStyle.stroke
        ..strokeWidth = size.height
        ..strokeCap = StrokeCap.round;

      final path = Path();

      final startX = math.min(progressWidth + 12.0, size.width);

      path.moveTo(startX, size.height / 2.0);
      path.lineTo(size.width, size.height / 2.0);

      canvas.drawPath(path, fillerPaint);
    }

    // Dibujar progreso con ondas
    if (value > 0.0) {
      final progressPaint = Paint()
        ..color = progressColor
        ..style = PaintingStyle.stroke
        ..strokeWidth = size.height
        ..strokeCap = StrokeCap.round;

      final adjustedAmplitude = waveAmplitude * flattenFactor;
      final path = Path();

      // Calcular punto inicial siguiendo la onda
      final startY = size.height / 2 + math.sin(0 * waveFrequency + wavePhase) * adjustedAmplitude;

      path.moveTo(0, startY);

      // Dibujar línea ondulada
      for (double x = 1; x <= progressWidth; x += 1) {
        final y = size.height / 2 + math.sin(x * waveFrequency + wavePhase) * adjustedAmplitude;
        path.lineTo(x, y);
      }

      canvas.drawPath(path, progressPaint);
    }
  }

  @override
  bool shouldRepaint(_WavyProgressPainter oldDelegate) {
    return oldDelegate.value != value ||
        oldDelegate.wavePhase != wavePhase ||
        oldDelegate.flattenFactor != flattenFactor ||
        oldDelegate.progressColor != progressColor;
  }
}

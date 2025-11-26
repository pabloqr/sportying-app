import 'package:flutter/material.dart';
import 'package:sportying_app/features/core/utils/widget_size.dart';

class PulsingDot extends StatefulWidget {
  const PulsingDot.small({super.key, required this.color}) : size = WidgetSize.small;
  const PulsingDot.medium({super.key, required this.color}) : size = WidgetSize.medium;
  const PulsingDot.large({super.key, required this.color}) : size = WidgetSize.large;

  final WidgetSize size;

  final Color color;

  @override
  State<PulsingDot> createState() => _PulsingDotState();
}

class _PulsingDotState extends State<PulsingDot> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;
  late Animation<double> _opacityAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(duration: const Duration(milliseconds: 2000), vsync: this)..repeat();

    _scaleAnimation = Tween<double>(
      begin: 1.0,
      end: 3.5,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));

    _opacityAnimation = Tween<double>(
      begin: 200.0,
      end: 0.0,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  double get _containerSize {
    switch (widget.size) {
      case WidgetSize.small:
        return 18.0;
      case WidgetSize.medium:
        return 24.0;
      case WidgetSize.large:
        return 24.0;
    }
  }

  double get _dotSize {
    switch (widget.size) {
      case WidgetSize.small:
        return 6.0;
      case WidgetSize.medium:
        return 8.0;
      case WidgetSize.large:
        return 8.0;
    }
  }

  double get _blurRadius {
    switch (widget.size) {
      case WidgetSize.small:
        return 3.0;
      case WidgetSize.medium:
        return 4.0;
      case WidgetSize.large:
        return 4.0;
    }
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: _containerSize,
      height: _containerSize,
      child: Stack(
        alignment: Alignment.center,
        children: [
          // Onda expansiva
          AnimatedBuilder(
            animation: _controller,
            builder: (context, child) {
              return Transform.scale(
                scale: _scaleAnimation.value,
                child: Container(
                  width: _dotSize,
                  height: _dotSize,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: widget.color.withAlpha((_opacityAnimation.value * 0.6).round()),
                  ),
                ),
              );
            },
          ),
          // Punto central con pulso sutil
          AnimatedBuilder(
            animation: _controller,
            builder: (context, child) {
              final pulseValue = (1 + (0.15 * (0.5 - (_controller.value - 0.5).abs())));
              return Transform.scale(
                scale: pulseValue,
                child: Container(
                  width: _dotSize,
                  height: _dotSize,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: widget.color,
                    boxShadow: [
                      BoxShadow(color: widget.color.withAlpha(100), blurRadius: _blurRadius, spreadRadius: 0),
                    ],
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';

class PulsingDot extends StatefulWidget {
  final Color color;

  const PulsingDot({super.key, required this.color});

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

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 24,
      height: 24,
      child: Stack(
        alignment: Alignment.center,
        children: [
          // Onda expansiva (ripple effect)
          AnimatedBuilder(
            animation: _controller,
            builder: (context, child) {
              return Transform.scale(
                scale: _scaleAnimation.value,
                child: Container(
                  width: 8,
                  height: 8,
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
                  width: 8,
                  height: 8,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: widget.color,
                    boxShadow: [BoxShadow(color: widget.color.withAlpha(100), blurRadius: 4, spreadRadius: 0)],
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

import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:sportying_app/features/core/widgets/utils/animations.dart';

enum _FloatingActionButtonType { regular, extended }

class AnimatedFloatingActionButton extends StatefulWidget {
  const AnimatedFloatingActionButton({
    super.key,
    required this.animation,
    this.onPressed,
    required this.icon,
    this.label,
    this.elevation,
  }) : _type = _FloatingActionButtonType.regular;

  const AnimatedFloatingActionButton.extended({
    super.key,
    required this.animation,
    this.onPressed,
    this.icon,
    required this.label,
    this.elevation,
  }) : _type = _FloatingActionButtonType.extended;

  final _FloatingActionButtonType _type;

  final Animation<double> animation;

  final VoidCallback? onPressed;

  final Widget? icon;
  final Widget? label;

  final double? elevation;

  @override
  State<AnimatedFloatingActionButton> createState() => _AnimatedFloatingActionButtonState();
}

class _AnimatedFloatingActionButtonState extends State<AnimatedFloatingActionButton> {
  late final Animation<double> _scaleAnimation = ScaleAnimation(parent: widget.animation);
  late final Animation<double> _shapeAnimation = ShapeAnimation(parent: widget.animation);

  @override
  Widget build(BuildContext context) {
    return ScaleTransition(
      scale: _scaleAnimation,
      child: widget._type == _FloatingActionButtonType.regular
          ? FloatingActionButton(
              elevation: widget.elevation,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(lerpDouble(30, 15, _shapeAnimation.value)!)),
              ),
              onPressed: widget.onPressed,
              child: widget.icon,
            )
          : FloatingActionButton.extended(
              elevation: widget.elevation,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(lerpDouble(30, 15, _shapeAnimation.value)!)),
              ),
              onPressed: widget.onPressed,
              icon: widget.icon,
              label: widget.label!,
            ),
    );
  }
}

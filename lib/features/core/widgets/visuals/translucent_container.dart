import 'package:flutter/material.dart';

class TranslucentContainer extends StatelessWidget {
  const TranslucentContainer({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.white.withAlpha(50),
        borderRadius: BorderRadius.circular(20.0),
        border: Border.all(color: Colors.white.withAlpha(75), width: 2),
      ),
      child: child,
    );
  }
}

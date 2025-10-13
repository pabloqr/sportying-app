import 'package:flutter/material.dart';

class InfoSectionWidget extends StatelessWidget {
  final List<Widget> leftChildren;
  final List<Widget> rightChildren;

  const InfoSectionWidget({super.key, required this.leftChildren, required this.rightChildren});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      spacing: 8.0,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: 8.0,
            children: leftChildren,
          ),
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: 8.0,
            children: rightChildren,
          ),
        ),
      ],
    );
  }
}

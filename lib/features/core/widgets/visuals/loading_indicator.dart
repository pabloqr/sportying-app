import 'package:flutter/material.dart';

class LoadingIndicator extends StatelessWidget {
  const LoadingIndicator({super.key});

  @override
  Widget build(BuildContext context) {
    // ignore: deprecated_member_use
    return const SafeArea(child: Center(child: CircularProgressIndicator(year2023: false)));
  }
}

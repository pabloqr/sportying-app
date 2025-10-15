import 'package:flutter/material.dart';

void showSideSheet(BuildContext context, {required String title, List<Widget>? content}) {
  Navigator.of(context).push(
    PageRouteBuilder(
      opaque: false,
      pageBuilder: (context, animation, secondaryAnimation) {
        return _SideSheetContainer(
          title: title,
          content: content,
          animation: animation,
          secondaryAnimation: secondaryAnimation,
        );
      },
      transitionDuration: const Duration(milliseconds: 300),
      reverseTransitionDuration: const Duration(milliseconds: 250),
    ),
  );
}

class _SideSheetContainer extends StatelessWidget {
  final String title;
  final List<Widget>? content;

  final Animation<double> animation;
  final Animation<double> secondaryAnimation;

  const _SideSheetContainer({
    required this.title,
    required this.content,
    required this.animation,
    required this.secondaryAnimation,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: SafeArea(
        child: Stack(
          children: [
            FadeTransition(
              opacity: CurvedAnimation(
                parent: animation,
                curve: const Interval(0.0, 0.5, curve: Curves.easeOut),
              ),
              child: GestureDetector(
                onTap: () => Navigator.of(context).pop(), // Close on tap
                child: Container(color: colorScheme.scrim.withAlpha(153)),
              ),
            ),
            Align(
              alignment: Alignment.centerRight,
              child: SlideTransition(
                position: Tween<Offset>(
                  begin: const Offset(1.0, 0.0),
                  end: Offset.zero,
                ).animate(CurvedAnimation(parent: animation, curve: Curves.easeOutCubic)),
                child: LayoutBuilder(
                  builder: (context, constraints) {
                    final isFullWidth = constraints.maxWidth <= 360;
                    final borderRadius = isFullWidth
                        ? BorderRadius.zero
                        : const BorderRadius.only(topLeft: Radius.circular(16), bottomLeft: Radius.circular(16));

                    return Material(
                      color: colorScheme.surface,
                      elevation: 1.0,
                      borderRadius: borderRadius,
                      child: SizedBox(
                        width: 360.0,
                        height: double.infinity,
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(24.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                spacing: 16.0,
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    spacing: 12.0,
                                    children: [
                                      Expanded(
                                        child: Text(
                                          title,
                                          style: textTheme.titleLarge?.copyWith(color: colorScheme.onSurfaceVariant),
                                        ),
                                      ),
                                      IconButton(
                                        onPressed: () => Navigator.of(context).pop(),
                                        icon: const Icon(Icons.close_rounded),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            Expanded(
                              child: SingleChildScrollView(
                                padding: const EdgeInsets.symmetric(horizontal: 12.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.stretch,
                                  spacing: 8.0,
                                  children: content ?? [],
                                ),
                              ),
                            ),
                            const SizedBox(height: 24.0),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

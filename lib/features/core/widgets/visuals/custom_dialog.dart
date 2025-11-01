import 'package:flutter/material.dart';

Future<void> showCustomAlertDialog(
  BuildContext context, {
  required IconData icon,
  required String headline,
  required String supportingText,
  required Color headerColor,
  required Color iconColor,
  List<Widget>? actions,
}) {
  return showDialog(
    context: context,
    builder: (context) {
      final textTheme = Theme.of(context).textTheme;

      return Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24.0)),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          spacing: 16.0,
          children: [
            Container(
              decoration: BoxDecoration(
                color: headerColor,
                borderRadius: const BorderRadius.vertical(top: Radius.circular(24.0)),
              ),
              padding: const EdgeInsets.all(24.0),
              child: Center(
                child: Icon(icon, size: 48, fill: 0, weight: 400, grade: 0, opticalSize: 48, color: iconColor),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                spacing: 16.0,
                children: [
                  Text(headline, style: textTheme.headlineSmall, textAlign: TextAlign.center),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    spacing: 24.0,
                    children: [
                      Text(supportingText, style: textTheme.bodyMedium),
                      if (actions != null) ...[
                        Row(mainAxisAlignment: MainAxisAlignment.end, spacing: 8.0, children: actions),
                      ],
                    ],
                  ),
                  const SizedBox(height: 8.0),
                ],
              ),
            ),
          ],
        ),
      );
    },
  );
}

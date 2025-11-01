import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:sportying_app/features/core/utils/widget_status.dart';
import 'package:sportying_app/features/core/widgets/visuals/custom_dialog.dart';

class ReservationProcessScreen extends StatefulWidget {
  const ReservationProcessScreen({super.key});

  @override
  State<ReservationProcessScreen> createState() => _ReservationProcessScreenState();
}

class _ReservationProcessScreenState extends State<ReservationProcessScreen> {
  void _cancelReservation(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final brightness = Theme.of(context).brightness;

    final headerColor = WidgetStatus.alert.colorSurface(context);
    final iconColor = WidgetStatus.alert.colorOnSurface(context);

    final String text = 'Creation';

    showCustomAlertDialog(
      context,
      icon: WidgetStatus.alert.icon,
      headline: 'Leave reservation ${text.toLowerCase()}?',
      supportingText:
          'You are about to exit the reservation ${text.toLowerCase()} process. All unsaved changes will be lost.',
      headerColor: headerColor,
      iconColor: iconColor,
      actions: [
        TextButton(
          style: ButtonStyle(
            overlayColor: WidgetStatePropertyAll(
              brightness == Brightness.light ? colorScheme.onPrimary.withAlpha(25) : colorScheme.primary.withAlpha(25),
            ),
            foregroundColor: WidgetStatePropertyAll(
              brightness == Brightness.light ? colorScheme.onPrimary : colorScheme.primary,
            ),
          ),
          onPressed: () => context.pop(),
          child: const Text('Stay'),
        ),
        TextButton(
          style: ButtonStyle(
            overlayColor: WidgetStatePropertyAll(
              brightness == Brightness.light ? colorScheme.onPrimary.withAlpha(25) : colorScheme.primary.withAlpha(25),
            ),
            foregroundColor: WidgetStatePropertyAll(
              brightness == Brightness.light ? colorScheme.onPrimary : colorScheme.primary,
            ),
          ),
          onPressed: () async {
            context.pop();
            context.pop();
          },
          child: const Text('Leave'),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(onPressed: () => _cancelReservation(context), icon: const Icon(Icons.arrow_back_rounded)),
        title: Text('New reservation'),
      ),
      body: SafeArea(child: const Placeholder()),
    );
  }
}

import 'dart:math';

import 'package:flutter/material.dart';
import 'package:sportying_app/features/complexes/widgets/complex_card.dart';
import 'package:sportying_app/features/reservations/widgets/reservation_card.dart';
import 'package:sportying_app/features/users/view_model/client_dashboard_viewmodel.dart';

class ClientDashboardScreen extends StatefulWidget {
  const ClientDashboardScreen({super.key, required this.viewModel});

  final ClientDashboardViewModel viewModel;

  @override
  State<ClientDashboardScreen> createState() => _ClientDashboardScreenState();
}

class _ClientDashboardScreenState extends State<ClientDashboardScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Home')),
      body: SafeArea(
        top: false,
        child: ListenableBuilder(
          listenable: widget.viewModel.load,
          builder: (context, child) {
            if (widget.viewModel.load.running) {
              return const Center(child: CircularProgressIndicator());
            }

            if (widget.viewModel.load.error) {
              return ErrorIndicator(
                title: 'Error while loading home',
                label: 'Try again',
                onPressed: () => widget.viewModel.load.execute(6),
              );
            }

            return child!;
          },
          child: ListenableBuilder(
            listenable: widget.viewModel,
            builder: (context, _) {
              return SingleChildScrollView(
                padding: EdgeInsets.all(16.0),
                child: Column(
                  spacing: 16.0,
                  children: [
                    if (widget.viewModel.reservation != null)
                      ReservationCard(userId: 6, reservation: widget.viewModel.reservation!)
                    else
                      const Center(child: Text('No upcoming reservations')),

                    ConstrainedBox(
                      constraints: const BoxConstraints(maxHeight: 264.0),
                      child: CarouselView(
                        itemExtent: 240.0,
                        onTap: (index) {},
                        children: List<Widget>.generate(
                          widget.viewModel.complexes.isNotEmpty ? widget.viewModel.complexes.length : 10,
                          (int index) {
                            if (widget.viewModel.complexes.isEmpty) {
                              return Container(color: Theme.of(context).colorScheme.surfaceContainer);
                            }

                            return ComplexCard.small(
                              userId: null,
                              complex: widget.viewModel.complexes.elementAt(index),
                              rating: Random().nextInt(11) / 2.0,
                              sports: {},
                            );
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}

class ErrorIndicator extends StatelessWidget {
  const ErrorIndicator({super.key, required this.title, required this.label, required this.onPressed});

  final String title;
  final String label;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        IntrinsicWidth(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Center(
              child: Row(
                children: [
                  Icon(Icons.error_outline, color: Theme.of(context).colorScheme.onError),
                  const SizedBox(width: 10),
                  Text(title, style: TextStyle(color: Theme.of(context).colorScheme.onError)),
                ],
              ),
            ),
          ),
        ),
        const SizedBox(height: 10),
        FilledButton(
          onPressed: onPressed,
          style: ButtonStyle(
            backgroundColor: WidgetStatePropertyAll(Theme.of(context).colorScheme.errorContainer),
            foregroundColor: WidgetStatePropertyAll(Theme.of(context).colorScheme.onErrorContainer),
          ),
          child: Text(label),
        ),
      ],
    );
  }
}

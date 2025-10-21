import 'package:flutter/material.dart';
import 'package:sportying_app/features/core/widgets/utils/error_indicator.dart';
import 'package:sportying_app/features/reservations/widgets/reservation_card.dart';
import 'package:sportying_app/features/users/clients/view_model/client_reservations_viewmodel.dart';

class ClientReservationsScreen extends StatefulWidget {
  const ClientReservationsScreen({super.key, required this.viewModel});

  final ClientReservationsViewModel viewModel;

  @override
  State<ClientReservationsScreen> createState() => _ClientReservationsScreenState();
}

class _ClientReservationsScreenState extends State<ClientReservationsScreen> {
  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
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
          return ListView.builder(
            padding: const EdgeInsetsGeometry.only(left: 12.0, right: 12.0, bottom: 224.0),
            itemCount: widget.viewModel.reservations.isNotEmpty ? widget.viewModel.reservations.length : 10,
            itemBuilder: (context, index) {
              return ReservationCard(reservation: widget.viewModel.reservations.elementAt(index));
            },
          );
        },
      ),
    );
  }
}

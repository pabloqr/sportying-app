import 'dart:math';

import 'package:flutter/material.dart';
import 'package:material_symbols_icons/material_symbols_icons.dart';
import 'package:sportying_app/features/complexes/widgets/complex_card.dart';
import 'package:sportying_app/features/core/widgets/scaffolds/header.dart';
import 'package:sportying_app/features/core/widgets/visuals/error_indicator.dart';
import 'package:sportying_app/features/core/widgets/visuals/loading_indicator.dart';
import 'package:sportying_app/features/news/widgets/news_card.dart';
import 'package:sportying_app/features/reservations/reservation_process/widgets/reservation_card.dart';
import 'package:sportying_app/features/users/clients/home/view_model/client_home_viewmodel.dart';

class ClientHomeScreen extends StatefulWidget {
  const ClientHomeScreen({super.key, required this.viewModel});

  final ClientHomeViewModel viewModel;

  @override
  State<ClientHomeScreen> createState() => _ClientHomeScreenState();
}

class _ClientHomeScreenState extends State<ClientHomeScreen> {
  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: widget.viewModel.load,
      builder: (context, child) {
        if (widget.viewModel.load.running) return const LoadingIndicator();

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
            padding: EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 224.0),
            child: Column(
              spacing: 16.0,
              children: [_buildReservationSubsection(context), _buildDiscoverSubsection(), _buildNewsSubsection()],
            ),
          );
        },
      ),
    );
  }

  Widget _buildReservationSubsection(BuildContext context) {
    return Column(
      spacing: 16.0,
      children: [
        Header.subheader(
          container: HeaderContainer.card,
          title: 'Reservations',
          icon: Symbols.chevron_right_rounded,
          onPressed: () {},
        ),
        if (widget.viewModel.reservation != null)
          ReservationCard(reservation: widget.viewModel.reservation!)
        else
          const Center(child: Text('No upcoming reservations')),
      ],
    );
  }

  Widget _buildDiscoverSubsection() {
    return Column(
      spacing: 16.0,
      children: [
        Header.subheader(
          container: HeaderContainer.card,
          title: 'Discover',
          icon: Symbols.chevron_right_rounded,
          onPressed: () {},
        ),
        ConstrainedBox(
          constraints: const BoxConstraints(maxHeight: 264.0),
          child: CarouselView(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
            itemSnapping: true,
            itemExtent: 240.0,
            onTap: (index) {},
            children: List<Widget>.generate(
              widget.viewModel.complexes.isNotEmpty ? widget.viewModel.complexes.length : 10,
              (int index) {
                if (widget.viewModel.complexes.isEmpty) {
                  return Container(color: Theme.of(context).colorScheme.surfaceContainer);
                }

                return ComplexCard.carousel(
                  complex: widget.viewModel.complexes.elementAt(index),
                  rating: Random().nextInt(11) / 2.0,
                );
              },
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildNewsSubsection() {
    return Column(
      spacing: 16.0,
      children: [
        Header.subheader(
          container: HeaderContainer.card,
          title: 'News',
          icon: Symbols.chevron_right_rounded,
          onPressed: () {},
        ),
        ConstrainedBox(
          constraints: const BoxConstraints(maxHeight: 300.0),
          child: NewsCard(
            title: 'News title',
            date: DateTime.now().subtract(Duration(hours: Random().nextInt(8761))),
          ),
        ),
      ],
    );
  }
}

import 'dart:math';

import 'package:flutter/material.dart';
import 'package:material_symbols_icons/material_symbols_icons.dart';
import 'package:sportying_app/domain/models/complexes/complex.dart';
import 'package:sportying_app/domain/models/complexes/sport.dart';
import 'package:sportying_app/domain/models/courts/court.dart';
import 'package:sportying_app/domain/models/courts/court_status.dart';
import 'package:sportying_app/domain/models/reservations/availability_status.dart';
import 'package:sportying_app/domain/models/reservations/reservation.dart';
import 'package:sportying_app/domain/models/reservations/reservation_status.dart';
import 'package:sportying_app/domain/models/reservations/time_filter.dart';
import 'package:sportying_app/features/complexes/widgets/complex_card.dart';
import 'package:sportying_app/features/core/widgets/scaffolds/header.dart';
import 'package:sportying_app/features/core/widgets/utils/error_indicator.dart';
import 'package:sportying_app/features/news/widgets/news_card.dart';
import 'package:sportying_app/features/reservations/widgets/reservation_card.dart';
import 'package:sportying_app/features/users/clients/view_model/client_home_viewmodel.dart';

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
            padding: EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 88.0),
            child: Column(
              spacing: 16.0,
              children: [_buildReservationSubsection(), _buildDiscoverSubsection(), _buildNewsSubsection()],
            ),
          );
        },
      ),
    );
  }

  Widget _buildReservationSubsection() {
    return Column(
      spacing: 8.0,
      children: [
        Header.subheader(
          subheaderText: 'Upcoming reservation',
          showButton: true,
          buttonText: 'See all',
          icon: Symbols.chevron_right_rounded,
          onPressed: () {},
        ),
        if (widget.viewModel.reservation != null)
          ReservationCard(userId: 6, reservation: widget.viewModel.reservation!)
        else
          ReservationCard(
            userId: 6,
            reservation: Reservation(
              userId: -1,
              complex: Complex(
                name: 'Núñez Blanca',
                timeIni: '09:00',
                timeEnd: '23:00',
                address: 'Av. Principal 123, Granada',
                locLongitude: 0,
                locLatitude: 0,
                sports: {Sport.tennis, Sport.padel},
                createdAt: DateTime.now(),
                updatedAt: DateTime.now(),
              ),
              court: Court(
                complex: Complex(
                  name: 'Núñez Blanca',
                  timeIni: '09:00',
                  timeEnd: '23:00',
                  address: 'Av. Principal 123, Granada',
                  locLongitude: 0,
                  locLatitude: 0,
                  sports: {Sport.tennis, Sport.padel},
                  createdAt: DateTime.now(),
                  updatedAt: DateTime.now(),
                ),
                sport: Sport.tennis,
                name: 'Court 1',
                description: 'Tennis court 1',
                maxPeople: 4,
                status: CourtStatus.open,
                createdAt: DateTime.now(),
                updatedAt: DateTime.now(),
              ),
              dateIni: DateTime(2025, 10, 11, 9),
              dateEnd: DateTime(2025, 10, 11, 9),
              status: AvailabilityStatus.empty,
              reservationStatus: ReservationStatus.scheduled,
              timeFilter: TimeFilter.upcoming,
              createdAt: DateTime.now(),
              updatedAt: DateTime.now(),
            ),
          ),
        // const Center(child: Text('No upcoming reservations')),
      ],
    );
  }

  Widget _buildDiscoverSubsection() {
    return Column(
      spacing: 8.0,
      children: [
        Header.subheader(
          subheaderText: 'Discover',
          showButton: true,
          buttonText: 'Explore complexes',
          icon: Symbols.chevron_right_rounded,
          onPressed: () {},
        ),
        ConstrainedBox(
          constraints: const BoxConstraints(maxHeight: 264.0),
          child: CarouselView(
            itemSnapping: true,
            itemExtent: 240.0,
            onTap: (index) {},
            children: List<Widget>.generate(
              widget.viewModel.complexes.isNotEmpty ? widget.viewModel.complexes.length : 10,
              (int index) {
                if (widget.viewModel.complexes.isEmpty) {
                  return Container(color: Theme.of(context).colorScheme.surfaceContainer);
                }

                return ComplexCard.small(
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
      spacing: 8.0,
      children: [
        Header.subheader(
          subheaderText: 'News',
          showButton: true,
          buttonText: 'More news',
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

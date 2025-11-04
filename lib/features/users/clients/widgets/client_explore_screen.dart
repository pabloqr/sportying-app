import 'dart:math';

import 'package:flutter/material.dart';
import 'package:sportying_app/features/complexes/widgets/complex_card.dart';
import 'package:sportying_app/features/core/widgets/utils/error_indicator.dart';
import 'package:sportying_app/features/users/clients/view_model/client_explore_viewmodel.dart';

class ClientExploreScreen extends StatefulWidget {
  const ClientExploreScreen({super.key, required this.viewModel});

  final ClientExploreViewModel viewModel;

  @override
  State<ClientExploreScreen> createState() => _ClientExploreScreenState();
}

class _ClientExploreScreenState extends State<ClientExploreScreen> {
  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: widget.viewModel.load,
      builder: (context, child) {
        if (widget.viewModel.load.running) {
          return const SafeArea(child: Center(child: CircularProgressIndicator(year2023: false)));
        }

        if (widget.viewModel.load.error) {
          return ErrorIndicator(
            title: 'Error while loading home',
            label: 'Try again',
            onPressed: () => widget.viewModel.load.execute(),
          );
        }

        return child!;
      },
      child: ListenableBuilder(
        listenable: widget.viewModel,
        builder: (context, _) {
          return ListView.builder(
            padding: const EdgeInsets.only(left: 16.0, right: 16.0, bottom: 220.0),
            itemCount: widget.viewModel.complexes.isNotEmpty ? widget.viewModel.complexes.length : 10,
            itemBuilder: (context, index) {
              return ComplexCard.large(
                complex: widget.viewModel.complexes.elementAt(index),
                rating: Random().nextInt(11) / 2.0,
              );
            },
          );
        },
      ),
    );
  }
}

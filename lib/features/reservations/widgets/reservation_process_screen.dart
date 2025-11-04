import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:sportying_app/features/core/utils/widget_status.dart';
import 'package:sportying_app/features/core/widgets/visuals/custom_dialog.dart';
import 'package:sportying_app/features/core/widgets/visuals/wavy_progress_indicator.dart';

class ReservationProcessScreen extends StatefulWidget {
  const ReservationProcessScreen({super.key});

  @override
  State<ReservationProcessScreen> createState() => _ReservationProcessScreenState();
}

class _ReservationProcessScreenState extends State<ReservationProcessScreen> {
  final _pageController = PageController();

  int _currentPage = 0;

  final List<String> _pages = ['Sport', 'Complex', 'Court', 'Date and time', 'Summary'];
  final List<String> _pagesDetails = [
    'Select a sport to book a court.',
    'Select a complex to book a court.',
    'Select a court to book.',
    'Select date and time to complete your reservation.',
    'Check your selection and confirm your reservation.',
  ];

  bool _canContinue() {
    return true;
  }

  void _previousPage() {
    if (_currentPage > 0) {
      _pageController.previousPage(duration: const Duration(milliseconds: 500), curve: Curves.easeInOut);
    }
  }

  void _nextPage() {
    if (_canContinue() && _currentPage < _pages.length - 1) {
      _pageController.nextPage(duration: const Duration(milliseconds: 500), curve: Curves.easeInOut);
    }
  }

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
        leading: IconButton(
          onPressed: () => _currentPage == 0 ? _cancelReservation(context) : _previousPage(),
          icon: const Icon(Icons.arrow_back_rounded),
        ),
        title: Text('New reservation'),
      ),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: 24.0,
          children: [
            _buildHeader(context),
            _buildPagesIndicator(context),
            _buildPageView(context),
            _buildPageControls(context),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: 8.0,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'STEP ${_currentPage + 1} / ${_pages.length}',
                style: textTheme.bodyMedium?.copyWith(color: colorScheme.onSurfaceVariant),
              ),
              Text(_pages[_currentPage], style: textTheme.titleLarge?.copyWith(color: colorScheme.onSurface)),
            ],
          ),
          Text(_pagesDetails[_currentPage], style: textTheme.bodyMedium?.copyWith(color: colorScheme.onSurfaceVariant)),
        ],
      ),
    );
  }

  Widget _buildPagesIndicator(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
      decoration: BoxDecoration(
        boxShadow: _currentPage == _pages.length - 1
            ? [BoxShadow(color: colorScheme.primary.withAlpha(100), blurRadius: 8, spreadRadius: 3)]
            : null,
      ),
      child: WavyProgressIndicator(
        value: (_currentPage + 1) / _pages.length,
        progressColor: colorScheme.primary,
        fillerColor: colorScheme.surfaceContainer,
      ),
    );
  }

  Widget _buildPageView(BuildContext context) {
    return Expanded(
      child: PageView(
        controller: _pageController,
        physics: const NeverScrollableScrollPhysics(),
        onPageChanged: (index) => setState(() => _currentPage = index),
        children: List.generate(
          _pages.length,
          (index) => Center(child: Text('Content from page ${_pages[_currentPage]}')),
        ),
      ),
    );
  }

  Widget _buildPageControls(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      child: FilledButton(
        onPressed: _canContinue() ? _nextPage : null,
        child: Text(_currentPage != _pages.length - 1 ? 'Continue' : 'Confirm reservation'),
      ),
    );
  }
}

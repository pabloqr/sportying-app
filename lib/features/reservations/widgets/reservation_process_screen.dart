import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:sportying_app/core/utils/extension_utilities.dart';
import 'package:sportying_app/domain/models/complexes/complex.dart';
import 'package:sportying_app/domain/models/complexes/sport.dart';
import 'package:sportying_app/domain/models/courts/court.dart';
import 'package:sportying_app/domain/models/courts/court_status.dart';
import 'package:sportying_app/features/complexes/widgets/complex_card.dart';
import 'package:sportying_app/features/core/utils/widget_side.dart';
import 'package:sportying_app/features/core/utils/widget_status.dart';
import 'package:sportying_app/features/core/widgets/visuals/custom_dialog.dart';
import 'package:sportying_app/features/core/widgets/visuals/wavy_progress_indicator.dart';
import 'package:sportying_app/features/courts/widgets/court_card.dart';
import 'package:sportying_app/features/sports/widgets/sport_card.dart';

final _topPadding = 16.0;

class ReservationProcessScreen extends StatefulWidget {
  const ReservationProcessScreen({super.key});

  @override
  State<ReservationProcessScreen> createState() => _ReservationProcessScreenState();
}

class _ReservationProcessScreenState extends State<ReservationProcessScreen> with SingleTickerProviderStateMixin {
  final _pageController = PageController();
  final _scrollController = ScrollController();

  late AnimationController _headerAnimationController;

  int _currentPage = 0;
  int _displayPage = 0;
  double _slideProgress = 0.0; // -1.0 a 1.0

  double _expandedHeight = 168.0;

  Sport? _sport;
  Complex? _complex;
  Court? _court;
  DateTimeRange? _dateTimeRange;

  final List<String> _pages = ['Sport', 'Complex', 'Court', 'Date and time', 'Summary'];
  final List<String> _pagesDetails = [
    'Select a sport to book a court.',
    'Select a complex to book a court.',
    'Select a court to book.',
    'Select date and time to complete your reservation.',
    'Check your selection and confirm your reservation.',
  ];

  @override
  void initState() {
    super.initState();

    _headerAnimationController = AnimationController(vsync: this, duration: const Duration(milliseconds: 500));

    // Listener del PageController para sincronizar animaciones
    _pageController.addListener(_onPageScroll);

    // Calcular altura inicial después del primer frame
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _updateExpandedHeight();
    });
  }

  @override
  void dispose() {
    _pageController.removeListener(_onPageScroll);
    _pageController.dispose();
    _headerAnimationController.dispose();

    super.dispose();
  }

  void _updateExpandedHeight() {
    if (!mounted) return;

    final textTheme = Theme.of(context).textTheme;
    final screenWidth = MediaQuery.of(context).size.width;

    // Calcular el ancho disponible para el texto (considerando paddings)
    final availableWidth = screenWidth - 32.0; // 16.0 padding left + 16.0 padding right

    // Altura fija de los elementos
    const topPadding = 48.0;
    const bottomPadding = 16.0;
    const stepIndicatorHeight = 20.0; // Aproximado para bodyMedium
    const stepNameHeight = 28.0; // Aproximado para titleLarge
    const bottomHeight = 32.0;

    // Calcular altura del texto de descripción usando TextPainter
    final descriptionStyle = textTheme.bodyMedium?.copyWith(color: Theme.of(context).colorScheme.onSurfaceVariant);

    final textSpan = TextSpan(text: _pagesDetails[_displayPage], style: descriptionStyle);

    final textPainter = TextPainter(
      text: textSpan,
      textDirection: TextDirection.ltr,
      maxLines: null, // Sin límite de líneas
    );

    textPainter.layout(maxWidth: availableWidth);
    final descriptionHeight = textPainter.height;

    // Calcular altura total expandida
    final calculatedHeight =
        topPadding + stepIndicatorHeight + stepNameHeight + descriptionHeight + bottomPadding + bottomHeight;

    // Establecer altura mínima y máxima
    const minHeight = 168.0;
    const maxHeight = 300.0;

    setState(() {
      _expandedHeight = calculatedHeight.clamp(minHeight, maxHeight);
    });
  }

  void _onPageScroll() {
    if (!_pageController.hasClients) return;

    final page = _pageController.page ?? 0.0;
    final pageInt = page.round();
    final progress = page - pageInt; // -0.5 a 0.5

    setState(() {
      // Actualizar página actual
      if (_currentPage != pageInt) {
        _currentPage = pageInt;
      }

      // Determinar qué página mostrar en el header
      final previousDisplayPage = _displayPage;
      if (progress.abs() >= 0.5) {
        _displayPage = progress > 0 ? pageInt + 1 : pageInt - 1;
        _displayPage = _displayPage.clamp(0, _pages.length - 1);
      } else {
        _displayPage = pageInt;
      }

      // Si cambió la página mostrada, recalcular altura
      if (previousDisplayPage != _displayPage) {
        _updateExpandedHeight();

        // Resetear scroll
        if (_scrollController.hasClients) {
          _scrollController.animateTo(0, duration: const Duration(milliseconds: 200), curve: Curves.easeOut);
        }
      }

      // Calcular el progreso del slide (-1.0 a 1.0)
      if (progress >= 0) {
        if (progress < 0.5) {
          _slideProgress = progress * 2; // 0.0 a 1.0
        } else {
          _slideProgress = (progress - 1.0) * 2; // -1.0 a 0.0
        }
      } else {
        if (progress > -0.5) {
          _slideProgress = progress * 2; // 0.0 a -1.0
        } else {
          _slideProgress = (progress + 1.0) * 2; // 1.0 a 0.0
        }
      }
    });
  }

  bool _canContinue() {
    switch (_currentPage) {
      case 0:
        return _sport != null;
      case 1:
        return _complex != null;
      case 2:
        return _court != null;
      default:
        return true;
    }
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
    final brightness = Theme.brightnessOf(context);

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
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: NestedScrollView(
                controller: _scrollController,
                headerSliverBuilder: (context, innerBoxIsScrolled) {
                  return [_buildAppBar(context), ?_buildSearchControls(context)];
                },
                body: _buildPageView(context),
              ),
            ),
            _buildPageControls(context),
          ],
        ),
      ),
    );
  }

  Widget _buildAppBar(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return SliverAppBar(
      pinned: true,
      expandedHeight: _expandedHeight, // Original: 168.0
      collapsedHeight: 72.0,
      toolbarHeight: 48.0,
      backgroundColor: colorScheme.surface,
      surfaceTintColor: colorScheme.surface,
      leading: IconButton(onPressed: () => _cancelReservation(context), icon: const Icon(Icons.arrow_back_rounded)),
      title: Text('New reservation'),
      flexibleSpace: LayoutBuilder(
        builder: (context, constraints) {
          final isCollapsed = constraints.maxHeight <= 112.0; // collapsedHeight + bottomHeight (40.0)

          return FlexibleSpaceBar(
            centerTitle: false,
            titlePadding: EdgeInsets.zero,
            collapseMode: CollapseMode.parallax,
            title: isCollapsed
                ? Padding(
                    padding: const EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 32.0),
                    child: _buildCollapsedHeader(context, textTheme, colorScheme),
                  )
                : null,
            background: Container(
              padding: const EdgeInsets.fromLTRB(16.0, 48.0, 16.0, 16.0),
              color: colorScheme.surface,
              child: _buildExpandedHeader(context, textTheme, colorScheme),
            ),
          );
        },
      ),
      bottom: PreferredSize(preferredSize: const Size.fromHeight(32.0), child: _buildPagesIndicator(context)),
    );
  }

  Widget? _buildSearchControls(BuildContext context) {
    if (_currentPage == 3 || _currentPage == 4) return null;

    final colorScheme = Theme.of(context).colorScheme;

    return SliverAppBar(
      automaticallyImplyLeading: false,
      automaticallyImplyActions: false,
      floating: true,
      title: ConstrainedBox(
        constraints: BoxConstraints(maxWidth: 480.0),
        child: SearchAnchor.bar(
          barBackgroundColor: WidgetStatePropertyAll(
            Theme.brightnessOf(context) == Brightness.light
                ? colorScheme.surfaceContainerLowest
                : colorScheme.surfaceContainerHigh,
          ),
          barElevation: WidgetStatePropertyAll(0.0),
          suggestionsBuilder: (context, controller) => List.generate(
            Sport.values.length,
            (index) => ListTile(title: Text(Sport.values[index].name.toCapitalized())),
          ),
        ),
      ),
    );
  }

  Widget _buildCollapsedHeader(BuildContext context, TextTheme textTheme, ColorScheme colorScheme) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      spacing: 8.0,
      children: [
        Row(
          spacing: 4.0,
          children: [
            Text('STEP', style: textTheme.bodySmall?.copyWith(color: colorScheme.onSurfaceVariant)),
            ClipRect(
              child: Transform.translate(
                offset: Offset(_slideProgress * -15, 0),
                child: Opacity(
                  opacity: (1.0 - _slideProgress.abs()).clamp(0.0, 1.0),
                  child: Text(
                    '${_displayPage + 1}',
                    style: textTheme.bodySmall?.copyWith(color: colorScheme.onSurfaceVariant),
                  ),
                ),
              ),
            ),
            Text('/ ${_pages.length}', style: textTheme.bodySmall?.copyWith(color: colorScheme.onSurfaceVariant)),
          ],
        ),
        const Text('·'),
        Expanded(
          child: ClipRect(
            child: Transform.translate(
              offset: Offset(_slideProgress * -30, 0),
              child: Opacity(
                opacity: (1.0 - _slideProgress.abs()).clamp(0.0, 1.0),
                child: Text(
                  _pages[_displayPage],
                  style: textTheme.titleMedium?.copyWith(color: colorScheme.onSurface),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildExpandedHeader(BuildContext context, TextTheme textTheme, ColorScheme colorScheme) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: 8.0,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              spacing: 4.0,
              children: [
                Text('STEP', style: textTheme.bodyMedium?.copyWith(color: colorScheme.onSurfaceVariant)),
                ClipRect(
                  child: Transform.translate(
                    offset: Offset(_slideProgress * -15, 0),
                    child: Opacity(
                      opacity: (1.0 - _slideProgress.abs()).clamp(0.0, 1.0),
                      child: Text(
                        '${_displayPage + 1}',
                        style: textTheme.bodyMedium?.copyWith(color: colorScheme.onSurfaceVariant),
                      ),
                    ),
                  ),
                ),
                Text('/ ${_pages.length}', style: textTheme.bodyMedium?.copyWith(color: colorScheme.onSurfaceVariant)),
              ],
            ),
            ClipRect(
              child: Transform.translate(
                offset: Offset(_slideProgress * -30, 0),
                child: Opacity(
                  opacity: (1.0 - _slideProgress.abs()).clamp(0.0, 1.0),
                  child: Text(
                    _pages[_displayPage],
                    style: textTheme.titleLarge?.copyWith(color: colorScheme.onSurface),
                  ),
                ),
              ),
            ),
          ],
        ),
        ClipRect(
          child: Transform.translate(
            offset: Offset(_slideProgress * -20, 0), // Slide sutil de 20px
            child: Opacity(
              opacity: (1.0 - _slideProgress.abs() * 0.8).clamp(0.0, 1.0), // Fade más sutil
              child: Text(
                _pagesDetails[_displayPage],
                style: textTheme.bodyMedium?.copyWith(color: colorScheme.onSurfaceVariant),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildPagesIndicator(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
      padding: const EdgeInsets.symmetric(vertical: 16.0),
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
    return PageView(
      controller: _pageController,
      physics: const NeverScrollableScrollPhysics(),
      onPageChanged: (index) => setState(() => _currentPage = index),
      children: [
        _SportPage(initialSport: _sport, onSportSelected: (sport) => setState(() => _sport = sport)),
        _ComplexPage(initialComplex: _complex, onComplexSelected: (complex) => setState(() => _complex = complex)),
        _CourtPage(initialCourt: _court, onCourtSelected: (court) => setState(() => _court = court)),
        Center(child: Text('Content from page ${_pages[3]}')),
        Center(child: Text('Content from page ${_pages[4]}')),
      ],
    );
  }

  Widget _buildPageControls(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      child: Row(
        children: [
          AnimatedSwitcher(
            duration: const Duration(milliseconds: 300),
            switchInCurve: Curves.easeOut,
            switchOutCurve: Curves.easeIn,
            transitionBuilder: (child, animation) {
              return FadeTransition(
                opacity: animation,
                child: SizeTransition(sizeFactor: animation, axis: Axis.horizontal, child: child),
              );
            },
            child: _currentPage != 0
                ? SizedBox(
                    key: const ValueKey('buttonBack'),
                    width: 120.0,
                    child: FilledButton(
                      onPressed: _previousPage,
                      style: ButtonStyle(
                        backgroundColor: WidgetStatePropertyAll(
                          Theme.brightnessOf(context) == Brightness.light
                              ? colorScheme.surfaceContainerLowest
                              : colorScheme.surfaceContainerHigh,
                        ),
                        foregroundColor: WidgetStatePropertyAll(colorScheme.onSurface),
                      ),
                      child: const Text("Back"),
                    ),
                  )
                : const SizedBox(key: ValueKey('buttonEmpty'), width: 0.0),
          ),
          if (_currentPage != 0) const SizedBox(width: 8.0),
          Expanded(
            child: FilledButton(
              onPressed: _canContinue() ? _nextPage : null,
              child: Text(_currentPage != _pages.length - 1 ? 'Continue' : 'Confirm reservation'),
            ),
          ),
        ],
      ),
    );
  }
}

class _SportPage extends StatefulWidget {
  const _SportPage({required this.initialSport, required this.onSportSelected});

  final Sport? initialSport;
  final ValueChanged<Sport> onSportSelected;

  @override
  State<_SportPage> createState() => _SportPageState();
}

class _SportPageState extends State<_SportPage> {
  final ValueNotifier<int> _selectedSportIndex = ValueNotifier(-1);

  @override
  void initState() {
    super.initState();

    _selectedSportIndex.value = widget.initialSport != null ? Sport.values.indexOf(widget.initialSport!) : -1;
  }

  @override
  void didUpdateWidget(covariant _SportPage oldWidget) {
    super.didUpdateWidget(oldWidget);

    final newIndex = widget.initialSport != null ? Sport.values.indexOf(widget.initialSport!) : -1;
    if (newIndex != _selectedSportIndex.value) _selectedSportIndex.value = newIndex;
  }

  @override
  void dispose() {
    _selectedSportIndex.dispose();

    super.dispose();
  }

  static WidgetSide _calculateBorderRadius(int index) {
    if (Sport.values.length < 3) {
      if (index == 0) return WidgetSide.left;
      if (index == 1) return WidgetSide.right;
    }

    if (index == 0) return WidgetSide.topLeft;
    if (index == 1) return WidgetSide.topRight;

    if (index == Sport.values.length - 2 && Sport.values.length.isEven) return WidgetSide.bottomLeft;
    if (index == Sport.values.length - 1) {
      return Sport.values.length.isEven ? WidgetSide.bottomRight : WidgetSide.bottomLeft;
    }

    return WidgetSide.none;
  }

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      padding: EdgeInsets.fromLTRB(16.0, _topPadding, 16.0, 0.0),
      shrinkWrap: true,
      gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
        maxCrossAxisExtent: 250.0,
        mainAxisSpacing: 2.0,
        crossAxisSpacing: 2.0,
        childAspectRatio: 3 / 2,
      ),
      itemCount: Sport.values.length,
      itemBuilder: (context, index) {
        return SportCard(
          fullRadiusSide: _calculateBorderRadius(index),
          sport: Sport.values[index],
          onTap: () {
            setState(() => _selectedSportIndex.value = index);
            widget.onSportSelected(Sport.values[index]);
          },
          index: index,
          selectedIndex: _selectedSportIndex,
        );
      },
    );
  }
}

class _ComplexPage extends StatefulWidget {
  const _ComplexPage({required this.initialComplex, required this.onComplexSelected});

  final Complex? initialComplex;
  final ValueChanged<Complex> onComplexSelected;

  @override
  State<_ComplexPage> createState() => _ComplexPageState();
}

class _ComplexPageState extends State<_ComplexPage> {
  final ValueNotifier<int> _selectedComplexIndex = ValueNotifier(-1);

  @override
  void initState() {
    super.initState();

    _selectedComplexIndex.value = widget.initialComplex != null ? widget.initialComplex?.id ?? -1 : -1;
  }

  @override
  void didUpdateWidget(covariant _ComplexPage oldWidget) {
    super.didUpdateWidget(oldWidget);

    final newIndex = widget.initialComplex != null ? widget.initialComplex?.id ?? -1 : -1;
    if (newIndex != _selectedComplexIndex.value) _selectedComplexIndex.value = newIndex;
  }

  @override
  void dispose() {
    _selectedComplexIndex.dispose();

    super.dispose();
  }

  static WidgetSide _calculateBorderRadius(int index, int length) {
    if (index == 0) return length > 1 ? WidgetSide.top : WidgetSide.all;
    if (index == length - 1) return WidgetSide.bottom;

    return WidgetSide.none;
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: EdgeInsets.fromLTRB(16.0, _topPadding - 1.0, 16.0, 0.0),
      itemCount: 10,
      itemBuilder: (context, index) {
        Complex complex = Complex(
          id: index,
          name: 'Complex $index',
          timeIni: '09:00',
          timeEnd: '23:00',
          address: 'C/Principal, $index, Granada',
          locLongitude: 0,
          locLatitude: 0,
          sports: {Sport.tennis, Sport.football},
          createdAt: DateTime.now(),
          updatedAt: DateTime.now(),
        );

        return ComplexCard.tile(
          fullRadiusSide: _calculateBorderRadius(index, 10),
          complex: complex,
          rating: 4.5,
          index: index,
          selectedIndex: _selectedComplexIndex,
          onTap: () {
            setState(() => _selectedComplexIndex.value = index);
            widget.onComplexSelected(complex);
          },
        );
      },
    );
  }
}

class _CourtPage extends StatefulWidget {
  const _CourtPage({required this.initialCourt, required this.onCourtSelected});

  final Court? initialCourt;
  final ValueChanged<Court> onCourtSelected;

  @override
  State<_CourtPage> createState() => _CourtPageState();
}

class _CourtPageState extends State<_CourtPage> {
  final ValueNotifier<int> _selectedCourtIndex = ValueNotifier(-1);

  @override
  void initState() {
    super.initState();

    _selectedCourtIndex.value = widget.initialCourt != null ? widget.initialCourt?.id ?? -1 : -1;
  }

  @override
  void didUpdateWidget(covariant _CourtPage oldWidget) {
    super.didUpdateWidget(oldWidget);

    final newIndex = widget.initialCourt != null ? widget.initialCourt?.id ?? -1 : -1;
    if (newIndex != _selectedCourtIndex.value) _selectedCourtIndex.value = newIndex;
  }

  @override
  void dispose() {
    _selectedCourtIndex.dispose();

    super.dispose();
  }

  static WidgetSide _calculateBorderRadius(int index, int length) {
    if (index == 0) return length > 1 ? WidgetSide.top : WidgetSide.all;
    if (index == length - 1) return WidgetSide.bottom;

    return WidgetSide.none;
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: EdgeInsets.fromLTRB(16.0, _topPadding - 1.0, 16.0, 0.0),
      itemCount: 10,
      itemBuilder: (context, index) {
        Court court = Court(
          id: index,
          complex: Complex(
            id: index,
            name: 'Complex $index',
            timeIni: '09:00',
            timeEnd: '23:00',
            address: 'C/Principal, $index, Granada',
            locLongitude: 0,
            locLatitude: 0,
            sports: {Sport.tennis, Sport.football},
            createdAt: DateTime.now(),
            updatedAt: DateTime.now(),
          ),
          sport: Sport.tennis,
          name: 'Court $index',
          description: 'Court $index is a place where you can do some sport.',
          maxPeople: 4,
          status: CourtStatus.open,
          createdAt: DateTime.now(),
          updatedAt: DateTime.now(),
        );

        return CourtCard.tile(
          fullRadiusSide: _calculateBorderRadius(index, 10),
          court: court,
          index: index,
          selectedIndex: _selectedCourtIndex,
          onTap: () {
            setState(() => _selectedCourtIndex.value = index);
            widget.onCourtSelected(court);
          },
        );
      },
    );
  }
}

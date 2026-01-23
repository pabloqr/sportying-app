import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:material_symbols_icons/material_symbols_icons.dart';
import 'package:provider/provider.dart';
import 'package:sportying_app/core/utils/extension_utilities.dart';
import 'package:sportying_app/domain/models/complexes/complex.dart';
import 'package:sportying_app/domain/models/complexes/sport.dart';
import 'package:sportying_app/domain/models/courts/court.dart';
import 'package:sportying_app/features/complexes/widgets/complex_card.dart';
import 'package:sportying_app/features/core/utils/widget_palette.dart';
import 'package:sportying_app/features/core/utils/widget_status.dart';
import 'package:sportying_app/features/core/utils/widget_utilities.dart';
import 'package:sportying_app/features/core/widgets/scaffolds/custom_grid_view.dart';
import 'package:sportying_app/features/core/widgets/scaffolds/labeled_info_widget.dart';
import 'package:sportying_app/features/core/widgets/utils/marquee_widget.dart';
import 'package:sportying_app/features/core/widgets/visuals/custom_chip.dart';
import 'package:sportying_app/features/core/widgets/visuals/custom_dialog.dart';
import 'package:sportying_app/features/core/widgets/visuals/date_container.dart';
import 'package:sportying_app/features/core/widgets/visuals/error_indicator.dart';
import 'package:sportying_app/features/core/widgets/visuals/loading_indicator.dart';
import 'package:sportying_app/features/core/widgets/visuals/time_range_selector.dart';
import 'package:sportying_app/features/core/widgets/visuals/wavy_progress_indicator.dart';
import 'package:sportying_app/features/courts/widgets/court_card.dart';
import 'package:sportying_app/features/reservations/view_model/reservation_process_viewmodel.dart';
import 'package:sportying_app/features/sports/widgets/sport_card.dart';

//--------------------------------------------------------------------------------------------------------------------//
// CONSTANTS
//--------------------------------------------------------------------------------------------------------------------//

// Pages
const List<String> _pages = ['Sport', 'Complex', 'Court, date and time', 'Summary'];
const List<String> _pagesDetails = [
  'Select a sport to book a court.',
  'Select a complex to book a court.',
  'Select a court to book. And choose your preferred available date and time range.',
  'Review your selection and confirm your reservation.',
];

// Header heights
const double _kExpandedHeightMin = 168.0;
const double _kExpandedHeightMax = 300.0;
const double _kCollapsedHeight = 72.0;
const double _kToolbarHeight = 48.0;
const double _kCollapsedThreshold = 112.0; // collapsedHeight + bottomHeight

// Header padding calculations
const double _kHeaderTopPadding = 48.0;
const double _kHeaderBottomPadding = 16.0;
const double _kHeaderHorizontalPadding = 16.0;
const double _kStepIndicatorHeight = 20.0;
const double _kStepNameHeight = 28.0;
const double _kBottomHeight = 32.0;

// Animation values
const Duration _kAnimationDuration = Duration(milliseconds: 500);
const Duration _kQuickAnimationDuration = Duration(milliseconds: 300);
const Duration _kScrollAnimationDuration = Duration(milliseconds: 200);
const Curve _kAnimationCurve = Curves.easeInOut;

// Slide animation offsets
const double _kSlideOffsetSmall = 15.0;
const double _kSlideOffsetMedium = 20.0;
const double _kSlideOffsetLarge = 30.0;

// Page transition threshold
const double _kPageTransitionThreshold = 0.5;

// Opacity values
const double _kFadeIntensity = 0.8;

// Content padding
const double _kContentTopPadding = 16.0;
const double _kContentHorizontalPadding = 16.0;
const double _kContentBottomPadding = 0.0; // 128.0

// Button dimensions
const double _kButtonMinHeight = 56.0;
const double _kBackButtonWidth = 120.0;
const double _kButtonSpacing = 8.0;

// Dialog alpha values
const int _kButtonOverlayAlpha = 25;

// Progress indicator
const double _kProgressIndicatorVerticalPadding = 16.0;
const int _kProgressGlowAlpha = 100;
const double _kProgressGlowBlur = 8.0;
const double _kProgressGlowSpread = 3.0;

// Grid view
const double _kGridMaxCrossAxisExtent = 250.0;
const double _kGridChildAspectRatio = 3 / 2;

// Search bar
const double _kSearchBarMaxWidth = 480.0;

// Calendar
const double _kItemWidth = 65.0;
const double _kItemSpacing = 2.0;

//--------------------------------------------------------------------------------------------------------------------//
// HEADER CONTROLLER
//--------------------------------------------------------------------------------------------------------------------//

/// Controller for managing header animation state and calculations
class _ReservationHeaderController extends ChangeNotifier {
  int _currentPage = 0;
  int _displayPage = 0;
  double _slideProgress = 0.0;
  double _expandedHeight = _kExpandedHeightMin;

  int get currentPage => _currentPage;
  int get displayPage => _displayPage;
  double get slideProgress => _slideProgress;
  double get expandedHeight => _expandedHeight;

  /// Updates the controller state based on page scroll
  void updateFromPageScroll(double page, int pageCount) {
    final pageInt = page.round();
    final progress = page - pageInt;

    _currentPage = pageInt;

    // Determine which page to display in header
    final previousDisplayPage = _displayPage;
    if (progress.abs() >= _kPageTransitionThreshold) {
      _displayPage = progress > 0 ? pageInt + 1 : pageInt - 1;
      _displayPage = _displayPage.clamp(0, pageCount - 1);
    } else {
      _displayPage = pageInt;
    }

    // Calculate slide progress (-1.0 to 1.0)
    _slideProgress = _calculateSlideProgress(progress);

    // Notify if display page changed
    if (previousDisplayPage != _displayPage) {
      notifyListeners();
    }
  }

  /// Calculates slide progress from page progress
  double _calculateSlideProgress(double progress) {
    if (progress >= 0) {
      return progress < _kPageTransitionThreshold ? progress * 2 : (progress - 1.0) * 2;
    } else {
      return progress > -_kPageTransitionThreshold ? progress * 2 : (progress + 1.0) * 2;
    }
  }

  /// Updates the expanded height based on content
  void updateExpandedHeight(double height) {
    _expandedHeight = height.clamp(_kExpandedHeightMin, _kExpandedHeightMax);
    notifyListeners();
  }

  /// Calculates the required height for the current page description
  double calculateRequiredHeight(BuildContext context, String description) {
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;
    final screenWidth = MediaQuery.of(context).size.width;

    final availableWidth = screenWidth - (_kHeaderHorizontalPadding * 2);

    final descriptionStyle = textTheme.bodyMedium?.copyWith(color: colorScheme.onSurfaceVariant);

    final textPainter = TextPainter(
      text: TextSpan(text: description, style: descriptionStyle),
      textDirection: TextDirection.ltr,
      maxLines: null,
    );

    textPainter.layout(maxWidth: availableWidth);

    return _kHeaderTopPadding +
        _kStepIndicatorHeight +
        _kStepNameHeight +
        textPainter.height +
        _kHeaderBottomPadding +
        _kBottomHeight;
  }
}

//--------------------------------------------------------------------------------------------------------------------//
// MAIN SCREEN
//--------------------------------------------------------------------------------------------------------------------//

class ReservationProcessScreen extends StatefulWidget {
  const ReservationProcessScreen({super.key, required this.viewModel});

  final ReservationProcessViewModel viewModel;

  @override
  State<ReservationProcessScreen> createState() => _ReservationProcessScreenState();
}

class _ReservationProcessScreenState extends State<ReservationProcessScreen> with SingleTickerProviderStateMixin {
  late final PageController _pageController;
  late final ScrollController _scrollController;
  late final _ReservationHeaderController _headerController;

  PersistentBottomSheetController? _bottomSheetController;
  PersistentBottomSheetController? _priceSheetController;

  late final TimeRangeController _timeRangeController;

  late final PageController _dayCarouselPageController;
  late int _numDaysInPage;

  Sport? _sport;
  Complex? _complex;
  Court? _court;
  DateTimeRange? _dateTimeRange;

  late final ValueNotifier<DateTimeRange> _dateTimeRangeNotifier;

  @override
  void initState() {
    super.initState();

    final now = DateTime.now();
    _dateTimeRangeNotifier = ValueNotifier(DateTimeRange(start: now, end: now));
    _dateTimeRange = _dateTimeRangeNotifier.value;

    _pageController = PageController();
    _pageController.addListener(_onPageScroll);

    _scrollController = ScrollController();
    _headerController = _ReservationHeaderController();

    _timeRangeController = context.read<TimeRangeController>();
    _timeRangeController.addListener(_onTimeRangeChanged);

    _dayCarouselPageController = PageController();
    _numDaysInPage = 0;

    WidgetsBinding.instance.addPostFrameCallback((_) => _updateExpandedHeight());
  }

  @override
  void dispose() {
    _pageController.removeListener(_onPageScroll);
    _pageController.dispose();
    _scrollController.dispose();
    _headerController.dispose();

    _dateTimeRangeNotifier.dispose();

    super.dispose();
  }

  void _updateExpandedHeight() {
    if (!mounted) return;

    final requiredHeight = _headerController.calculateRequiredHeight(
      context,
      _pagesDetails[_headerController.displayPage],
    );

    _headerController.updateExpandedHeight(requiredHeight);
  }

  void _onPageScroll() {
    if (!_pageController.hasClients) return;

    final page = _pageController.page ?? 0.0;
    final previousDisplayPage = _headerController.displayPage;

    _headerController.updateFromPageScroll(page, _pages.length);

    // Actualizar la altura al cambiar de página
    if (previousDisplayPage != _headerController.displayPage) {
      _updateExpandedHeight();

      // Restablecer el scroll al inicio
      if (_scrollController.hasClients) {
        _scrollController.animateTo(0, duration: _kScrollAnimationDuration, curve: Curves.easeOut);
      }
    }

    // Actualización para la animación del indicador de progreso
    setState(() {});
  }

  void _onPageChanged(BuildContext context, int previousPage, int currentPage) {
    if (previousPage == currentPage) return;

    switch (currentPage) {
      case 2:
        // Si se sale de la página 4 (index == 4), ocultar el PriceSheet
        if (_priceSheetController != null) _closePriceSheet();

        // Actualizar la visibilidad del BottomSheet al cambiar de página
        if (_court != null && _bottomSheetController == null) {
          // Si se pasa a la página 3 (index == 2), mostrar el BottomSheet
          WidgetsBinding.instance.addPostFrameCallback((_) {
            if (mounted && _bottomSheetController == null) _showBottomSheet(context);
          });
        }
        break;
      case 3:
        // Si se sale de la página 3 (index == 2), ocultar el BottomSheet
        if (_bottomSheetController != null) _closeBottomSheet();

        // Actualizar la visibilidad del BottomSheet al cambiar de página
        if (_priceSheetController == null) {
          // Si se pasa a la página 3 (index == 2), mostrar el BottomSheet
          WidgetsBinding.instance.addPostFrameCallback((_) {
            if (mounted && _priceSheetController == null) _showPriceSheet(context);
          });
        }
        break;
      default:
        // Si se sale de la página 3 (index == 2), ocultar el BottomSheet
        if (_bottomSheetController != null) _closeBottomSheet();
        // Si se sale de la página 4 (index == 4), ocultar el PriceSheet
        if (_priceSheetController != null) _closePriceSheet();
    }
  }

  bool _canContinue() {
    switch (_headerController.currentPage) {
      case 0:
        return _sport != null;
      case 1:
        return _complex != null;
      case 2:
        return _court != null;
      case 3:
        return _dateTimeRange != null;
      default:
        return true;
    }
  }

  void _previousPage() {
    if (_headerController.currentPage > 0) {
      _pageController.previousPage(duration: _kAnimationDuration, curve: _kAnimationCurve);
    }
  }

  void _nextPage() {
    if (_canContinue() && _headerController.currentPage < _pages.length - 1) {
      _pageController.nextPage(duration: _kAnimationDuration, curve: _kAnimationCurve);
    }
  }

  int _daysOffsetFromToday(DateTime date) {
    final today = DateTime.now();
    final todayStart = DateTime(today.year, today.month, today.day);
    final dateStart = DateTime(date.year, date.month, date.day);

    return dateStart.difference(todayStart).inDays;
  }

  void _onDateChanged(DateTime date) {
    _dateTimeRangeNotifier.value = DateTimeRange(
      start: _dateTimeRange!.start.copyWith(year: date.year, month: date.month, day: date.day),
      end: _dateTimeRange!.end.copyWith(year: date.year, month: date.month, day: date.day),
    );
    _dateTimeRange = _dateTimeRangeNotifier.value;

    // Calcular el offset en días desde el actual hasta el seleccionado
    final offset = _daysOffsetFromToday(date);
    // Calcular la página a la que se debe desplazar el carousel
    final page = offset < 0 ? 0 : offset ~/ _numDaysInPage;
    // Aplicar el desplazamiento a la página calculada
    _dayCarouselPageController.animateToPage(
      page,
      duration: const Duration(milliseconds: 500),
      curve: Curves.fastLinearToSlowEaseIn,
    );
  }

  void _onTimeRangeChanged() {
    if (mounted) {
      final timeRange = _timeRangeController.currentRangeValues;
      _dateTimeRangeNotifier.value = DateTimeRange(
        start: _dateTimeRange!.start.copyWith(
          hour: timeRange.start.toDateTime().hour,
          minute: timeRange.start.toDateTime().minute,
        ),
        end: _dateTimeRange!.start.copyWith(
          hour: timeRange.end.toDateTime().hour,
          minute: timeRange.end.toDateTime().minute,
        ),
      );
      _dateTimeRange = _dateTimeRangeNotifier.value;
    }
  }

  void _loadCourtsIfNeeded() {
    if (_complex == null || _sport == null) return;

    // Limpiar selección anterior
    setState(() => _court = null);

    // Obtener las pistas para el complejo dado
    widget.viewModel.loadCourts.execute(_complex!, _sport!);
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      body: SafeArea(
        child: Builder(
          builder: (context) {
            return _ReservationProcessContent(
              viewModel: widget.viewModel,
              pageController: _pageController,
              scrollController: _scrollController,
              headerController: _headerController,
              onPageChanged: (previousPage, currentPage) => _onPageChanged(context, previousPage, currentPage),
              onCloseBottomSheets: () {
                _closeBottomSheet();
                _closePriceSheet();
              },
              sport: _sport,
              onSportSelected: (sport) {
                setState(() => _sport = sport);

                // Si ya hay un complejo seleccionado, recargar pistas para el nuevo deporte
                _loadCourtsIfNeeded();
              },
              complex: _complex,
              onComplexSelected: (complex) {
                // Guardar el complejo seleccionado en el estado local
                setState(() => _complex = complex);

                // Solicitar pistas para el complejo seleccionado
                _loadCourtsIfNeeded();
              },
              court: _court,
              onCourtSelected: (court) {
                setState(() => _court = court);
                _showBottomSheet(context);
              },
              summaryPage: _SummaryPage(_sport, _complex, _court, _dateTimeRange),
            );
          },
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        color: _bottomSheetController == null && _priceSheetController == null
            ? colorScheme.surface
            : colorScheme.surfaceContainerLow,
        child: _PageNavigationControls(
          currentPage: _headerController.currentPage,
          totalPages: _pages.length,
          canContinue: _canContinue(),
          onPrevious: _previousPage,
          onNext: _nextPage,
        ),
      ),
    );
  }

  void _showBottomSheet(BuildContext context) {
    // Verificar que no se ha abierto previamente un BottomSheet
    if (_bottomSheetController != null) return;

    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    final brightness = Theme.brightnessOf(context);

    _bottomSheetController = showBottomSheet(
      context: context,
      showDragHandle: true,
      builder: (context) {
        return DraggableScrollableSheet(
          expand: false,
          snap: true,
          snapSizes: [0.0, 0.4],
          initialChildSize: 0.4,
          minChildSize: 0.0,
          maxChildSize: 0.4,
          builder: (context, scrollController) => SingleChildScrollView(
            controller: scrollController,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 8.0),
                  child: Text('Select date and time', style: textTheme.titleLarge),
                ),
                Divider(),
                Padding(
                  padding: const EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    spacing: 8.0,
                    children: [
                      Text('Select date', style: textTheme.titleMedium),
                      Row(
                        spacing: 4.0,
                        children: [
                          FilledButton.icon(
                            style: ButtonStyle(
                              backgroundColor: WidgetStatePropertyAll(
                                brightness == Brightness.light
                                    ? colorScheme.surfaceContainerLowest
                                    : colorScheme.surfaceContainerHigh,
                              ),
                              foregroundColor: WidgetStatePropertyAll(colorScheme.onSurface),
                            ),
                            onPressed: () => _onDateChanged(DateTime.now()),
                            icon: const Icon(
                              Symbols.today_rounded,
                              size: 18,
                              fill: 0,
                              weight: 400,
                              grade: 0,
                              opticalSize: 18,
                            ),
                            label: const Text('Today'),
                          ),
                          IconButton.filled(
                            style: ButtonStyle(
                              backgroundColor: WidgetStatePropertyAll(
                                brightness == Brightness.light
                                    ? colorScheme.surfaceContainerLowest
                                    : colorScheme.surfaceContainerHigh,
                              ),
                              foregroundColor: WidgetStatePropertyAll(colorScheme.onSurface),
                            ),
                            onPressed: () => _showDatePicker(context),
                            icon: const Icon(
                              Symbols.calendar_month_rounded,
                              size: 24,
                              fill: 0,
                              weight: 400,
                              grade: 0,
                              opticalSize: 24,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.fromLTRB(15.0, 0.0, 15.0, 8.0),
                  height: 100.0,
                  child: ValueListenableBuilder<DateTimeRange>(
                    valueListenable: _dateTimeRangeNotifier,
                    builder: (context, dateTimeRange, _) => LayoutBuilder(
                      builder: (context, constraints) {
                        // Obtener el ancho disponible
                        final maxWidth = constraints.maxWidth;
                        // Calcular el entero que representa el número de elementos que caben dado el ancho mínimo
                        _numDaysInPage = maxWidth ~/ (_kItemWidth + _kItemSpacing);
                        // Calcular el ancho real de los elementos para que ocupen todo el ancho disponible
                        final itemWidth = (maxWidth - _kItemSpacing * _numDaysInPage) / _numDaysInPage;

                        return PageView.builder(
                          controller: _dayCarouselPageController,
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (context, index) {
                            return Row(
                              children: List.generate(_numDaysInPage, (i) {
                                final date = DateTime.now().add(Duration(days: index * _numDaysInPage + i));
                                final selected = dateTimeRange.start.isSameDay(date);

                                return DateContainer(
                                  width: itemWidth,
                                  margin: const EdgeInsets.symmetric(horizontal: 1.0),
                                  borderRadius: selected ? 12.0 : 4.0,
                                  color: selected ? colorScheme.primary : null,
                                  date: date,
                                  onTap: () => _onDateChanged(date),
                                );
                              }),
                            );
                          },
                        );
                      },
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    spacing: 8.0,
                    children: [
                      Text('Available times', style: textTheme.titleMedium),
                      Row(
                        spacing: 4.0,
                        children: [
                          FilledButton.icon(
                            style: ButtonStyle(
                              backgroundColor: WidgetStatePropertyAll(
                                brightness == Brightness.light
                                    ? colorScheme.surfaceContainerLowest
                                    : colorScheme.surfaceContainerHigh,
                              ),
                              foregroundColor: WidgetStatePropertyAll(colorScheme.onSurface),
                            ),
                            onPressed: _timeRangeController.reset,
                            icon: const Icon(
                              Symbols.history_2_rounded,
                              size: 18,
                              fill: 0,
                              weight: 400,
                              grade: 0,
                              opticalSize: 18,
                            ),
                            label: const Text('Reset'),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 8.0),
                  child: TimeRangeSelector(
                    schedule: RangeValues(
                      _complex?.timeIni.toDoubleTime0() ?? 8.0,
                      _complex?.timeEnd.toDoubleTime0() ?? 24.0,
                    ),
                    date: DateTime.now(),
                    availability: [],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );

    _bottomSheetController!.closed.then((_) {
      setState(() {
        _bottomSheetController = null;
      });
    });
  }

  void _closeBottomSheet() {
    if (_bottomSheetController != null) {
      _bottomSheetController!.close();
      setState(() => _bottomSheetController = null);
    }
  }

  void _showPriceSheet(BuildContext context) {
    if (_priceSheetController != null) return;

    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    _priceSheetController = showBottomSheet(
      context: context,
      enableDrag: false,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.zero),
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 0.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            spacing: 4.0,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                spacing: 8.0,
                children: [
                  Text('Court fee', style: textTheme.bodyMedium?.copyWith(color: colorScheme.onSurfaceVariant)),
                  Text('00,00€', style: textTheme.bodyMedium?.copyWith(color: colorScheme.onSurfaceVariant)),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                spacing: 8.0,
                children: [
                  Text('Service fee', style: textTheme.bodyMedium?.copyWith(color: colorScheme.onSurfaceVariant)),
                  Text('00,00€', style: textTheme.bodyMedium?.copyWith(color: colorScheme.onSurfaceVariant)),
                ],
              ),
              Divider(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                spacing: 8.0,
                children: [
                  Text('Total', style: textTheme.titleLarge),
                  Text('00,00€', style: textTheme.titleLarge),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  void _closePriceSheet() {
    if (_priceSheetController != null) {
      _priceSheetController!.close();
      setState(() => _priceSheetController = null);
    }
  }

  void _showDatePicker(BuildContext context) async {
    // Mostrar el calendario para seleccionar una fecha
    final date = await showDatePicker(
      context: context,
      initialDate: _dateTimeRange?.start,
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 365)),
    );

    // Actualizar la fecha a la seleccionada
    if (date != null) _onDateChanged(date);
  }
}

class _ReservationProcessContent extends StatefulWidget {
  const _ReservationProcessContent({
    required this.viewModel,
    required this.pageController,
    required this.scrollController,
    required this.headerController,
    required this.onPageChanged,
    required this.onCloseBottomSheets,
    required this.sport,
    required this.onSportSelected,
    required this.complex,
    required this.onComplexSelected,
    required this.court,
    required this.onCourtSelected,
    required this.summaryPage,
  });

  final ReservationProcessViewModel viewModel;

  final PageController pageController;
  final ScrollController scrollController;
  final _ReservationHeaderController headerController;

  final void Function(int previousPage, int currentPage) onPageChanged;

  final VoidCallback onCloseBottomSheets;

  final Sport? sport;
  final ValueChanged<Sport> onSportSelected;

  final Complex? complex;
  final ValueChanged<Complex> onComplexSelected;

  final Court? court;
  final ValueChanged<Court> onCourtSelected;

  final Widget summaryPage;

  @override
  State<_ReservationProcessContent> createState() => _ReservationProcessContentState();
}

class _ReservationProcessContentState extends State<_ReservationProcessContent> {
  int _previousPage = 0;

  @override
  void initState() {
    super.initState();

    widget.pageController.addListener(_onPageControllerChanged);
  }

  @override
  void dispose() {
    widget.pageController.removeListener(_onPageControllerChanged);

    super.dispose();
  }

  void _onPageControllerChanged() {
    final currentPage = widget.headerController.currentPage;
    if (_previousPage != currentPage) {
      // Llamar al callback al cambiar de página
      widget.onPageChanged(_previousPage, currentPage);
      _previousPage = currentPage;
    }
  }

  ButtonStyle _getDialogButtonStyle(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final brightness = Theme.brightnessOf(context);

    final overlayColor = brightness == Brightness.light ? colorScheme.onPrimary : colorScheme.primary;
    final foregroundColor = brightness == Brightness.light ? colorScheme.onPrimary : colorScheme.primary;

    return ButtonStyle(
      overlayColor: WidgetStatePropertyAll(overlayColor.withAlpha(_kButtonOverlayAlpha)),
      foregroundColor: WidgetStatePropertyAll(foregroundColor),
    );
  }

  void _cancelReservation() {
    showCustomAlertDialog(
      context,
      icon: WidgetStatus.alert.icon,
      headline: 'Leave reservation creation?',
      supportingText: 'You are about to exit the reservation creation process. All unsaved changes will be lost.',
      headerColor: WidgetStatus.alert.colorSurface(context),
      iconColor: WidgetStatus.alert.colorOnSurface(context),
      actions: [
        TextButton(style: _getDialogButtonStyle(context), onPressed: () => context.pop(), child: const Text('Stay')),
        TextButton(
          style: _getDialogButtonStyle(context),
          onPressed: () {
            widget.onCloseBottomSheets();

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
    return NestedScrollView(
      controller: widget.scrollController,
      headerSliverBuilder: (context, innerBoxIsScrolled) => [
        _buildAppBar(),
        if (_shouldShowSearchBar()) _buildSearchBar(),
      ],
      body: _buildPageView(),
    );
  }

  bool _shouldShowSearchBar() {
    return widget.headerController.currentPage < 3;
  }

  Widget _buildAppBar() {
    return ListenableBuilder(
      listenable: widget.headerController,
      builder: (context, _) {
        final colorScheme = Theme.of(context).colorScheme;

        return SliverAppBar(
          pinned: true,
          expandedHeight: widget.headerController.expandedHeight,
          collapsedHeight: _kCollapsedHeight,
          toolbarHeight: _kToolbarHeight,
          backgroundColor: colorScheme.surface,
          surfaceTintColor: colorScheme.surface,
          leading: IconButton(onPressed: _cancelReservation, icon: const Icon(Icons.arrow_back_rounded)),
          title: const Text('New reservation'),
          flexibleSpace: _buildFlexibleSpace(),
          bottom: PreferredSize(preferredSize: const Size.fromHeight(_kBottomHeight), child: _buildProgressIndicator()),
        );
      },
    );
  }

  Widget _buildFlexibleSpace() {
    return LayoutBuilder(
      builder: (context, constraints) {
        final colorScheme = Theme.of(context).colorScheme;

        final isCollapsed = constraints.maxHeight <= _kCollapsedThreshold;

        return FlexibleSpaceBar(
          centerTitle: false,
          titlePadding: EdgeInsets.zero,
          collapseMode: CollapseMode.parallax,
          title: isCollapsed
              ? Padding(
                  padding: const EdgeInsets.fromLTRB(
                    _kHeaderHorizontalPadding,
                    0.0,
                    _kHeaderHorizontalPadding,
                    _kBottomHeight,
                  ),
                  child: _CollapsedHeader(
                    currentStep: widget.headerController.displayPage + 1,
                    totalSteps: _pages.length,
                    stepName: _pages[widget.headerController.displayPage],
                    slideProgress: widget.headerController.slideProgress,
                  ),
                )
              : null,
          background: Container(
            padding: const EdgeInsets.fromLTRB(
              _kHeaderHorizontalPadding,
              _kHeaderTopPadding,
              _kHeaderHorizontalPadding,
              _kHeaderBottomPadding,
            ),
            color: colorScheme.surface,
            child: _ExpandedHeader(
              currentStep: widget.headerController.displayPage + 1,
              totalSteps: _pages.length,
              stepName: _pages[widget.headerController.displayPage],
              description: _pagesDetails[widget.headerController.displayPage],
              slideProgress: widget.headerController.slideProgress,
            ),
          ),
        );
      },
    );
  }

  Widget _buildProgressIndicator() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: _kProgressIndicatorVerticalPadding),
      child: AnimatedContainer(
        duration: _kQuickAnimationDuration,
        curve: _kAnimationCurve,
        decoration: BoxDecoration(
          boxShadow: widget.headerController.currentPage == _pages.length - 1
              ? [
                  BoxShadow(
                    color: Theme.of(context).colorScheme.primary.withAlpha(_kProgressGlowAlpha),
                    blurRadius: _kProgressGlowBlur,
                    spreadRadius: _kProgressGlowSpread,
                  ),
                ]
              : null,
        ),
        child: WavyProgressIndicator(
          value: (widget.headerController.currentPage + 1) / _pages.length,
          progressColor: Theme.of(context).colorScheme.primary,
          fillerColor: Theme.of(context).colorScheme.surfaceContainer,
        ),
      ),
    );
  }

  Widget _buildSearchBar() {
    final colorScheme = Theme.of(context).colorScheme;
    final brightness = Theme.brightnessOf(context);

    return SliverAppBar(
      automaticallyImplyLeading: false,
      automaticallyImplyActions: false,
      floating: true,
      title: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: _kSearchBarMaxWidth),
        child: SearchAnchor.bar(
          barBackgroundColor: WidgetStatePropertyAll(
            brightness == Brightness.light ? colorScheme.surfaceContainerLowest : colorScheme.surfaceContainerHigh,
          ),
          barElevation: const WidgetStatePropertyAll(0.0),
          barHintText: _getSearchHintText(),
          suggestionsBuilder: _buildSearchSuggestions,
        ),
      ),
    );
  }

  String _getSearchHintText() {
    switch (widget.headerController.currentPage) {
      case 0:
        return 'Search sports...';
      case 1:
        return 'Search complexes...';
      case 2:
        return 'Search courts...';
      default:
        return 'Search...';
    }
  }

  List<Widget> _buildSearchSuggestions(BuildContext context, SearchController controller) {
    final query = controller.text.toLowerCase();

    switch (widget.headerController.currentPage) {
      case 0:
        return Sport.values
            .where((sport) => sport.name.toLowerCase().contains(query))
            .map(
              (sport) => ListTile(
                title: Text(sport.name.toCapitalized()),
                onTap: () {
                  controller.closeView(sport.name.toCapitalized());
                  // TODO: Filter by selected sport
                },
              ),
            )
            .toList();
      case 1:
      case 2:
        // TODO: Implement search for complexes and courts when data is available
        return [ListTile(title: Text('Search functionality coming soon...'), enabled: false)];
      default:
        return [];
    }
  }

  Widget _buildPageView() {
    return PageView(
      controller: widget.pageController,
      physics: const NeverScrollableScrollPhysics(),
      children: [
        _SelectionPage<Sport>(
          items: Sport.values,
          selectedItem: widget.sport,
          itemBuilder: (context, sport, index, selectedIndex, crossAxisCount) {
            return SportCard(
              fullRadiusSide: WidgetUtilities.calculateBorderRadiusSide(
                Sport.values.length,
                index,
                crossAxisCount: crossAxisCount ?? 0,
              ),
              sport: sport,
              onTap: () => widget.onSportSelected(sport),
              index: index,
              selectedIndex: selectedIndex,
            );
          },
          useGridView: true,
        ),
        ListenableBuilder(
          listenable: widget.viewModel.loadComplexes,
          builder: (context, child) {
            if (widget.viewModel.loadComplexes.running) return const LoadingIndicator();

            if (widget.viewModel.loadComplexes.error) {
              return ErrorIndicator(
                title: 'Error while loading complexes',
                label: 'Try again',
                onPressed: () => widget.viewModel.loadComplexes.execute(),
              );
            }

            return child!;
          },
          child: ListenableBuilder(
            listenable: widget.viewModel,
            builder: (context, _) => _SelectionPage<Complex>(
              items: widget.viewModel.complexes,
              selectedItem: widget.complex,
              itemBuilder: (context, complex, index, selectedIndex, _) {
                return ComplexCard.tile(
                  fullRadiusSide: WidgetUtilities.calculateBorderRadiusSide(widget.viewModel.complexes.length, index),
                  complex: complex,
                  rating: 4.5,
                  index: index,
                  selectedIndex: selectedIndex,
                  onTap: () => widget.onComplexSelected(complex),
                );
              },
            ),
          ),
        ),
        ListenableBuilder(
          listenable: widget.viewModel.loadCourts,
          builder: (context, child) {
            if (widget.viewModel.loadCourts.running) return const LoadingIndicator();

            if (widget.viewModel.loadCourts.error) {
              return ErrorIndicator(
                title: 'Error while loading courts',
                label: 'Try again',
                onPressed: () {
                  if (widget.complex != null && widget.sport != null) {
                    widget.viewModel.loadCourts.execute(widget.complex!, widget.sport!);
                  }
                },
              );
            }

            return child!;
          },
          child: ListenableBuilder(
            listenable: widget.viewModel,
            builder: (context, child) => _SelectionPage<Court>(
              items: widget.viewModel.courts,
              selectedItem: widget.court,
              itemBuilder: (context, court, index, selectedIndex, _) {
                return CourtCard.tile(
                  fullRadiusSide: WidgetUtilities.calculateBorderRadiusSide(widget.viewModel.courts.length, index),
                  court: court,
                  nextAvailable: widget.viewModel.courtsAvailability[court.id]?.nextAvailable ?? DateTime.now(),
                  index: index,
                  selectedIndex: selectedIndex,
                  onTap: () => widget.onCourtSelected(court),
                );
              },
            ),
          ),
        ),
        widget.summaryPage,
      ],
    );
  }
}

//--------------------------------------------------------------------------------------------------------------------//
// HEADER WIDGETS
//--------------------------------------------------------------------------------------------------------------------//

/// Collapsed header content with step indicator and title
class _CollapsedHeader extends StatelessWidget {
  final int currentStep;
  final int totalSteps;
  final String stepName;
  final double slideProgress;

  const _CollapsedHeader({
    required this.currentStep,
    required this.totalSteps,
    required this.stepName,
    required this.slideProgress,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      spacing: 8.0,
      children: [
        _AnimatedStepIndicator(
          currentStep: currentStep,
          totalSteps: totalSteps,
          slideProgress: slideProgress,
          style: textTheme.bodySmall,
          color: colorScheme.onSurfaceVariant,
        ),
        const Text('·'),
        Expanded(
          child: _AnimatedText(
            text: stepName,
            slideProgress: slideProgress,
            offset: _kSlideOffsetLarge,
            style: textTheme.titleMedium?.copyWith(color: colorScheme.onSurface),
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }
}

/// Expanded header content with step indicator, title, and description
class _ExpandedHeader extends StatelessWidget {
  final int currentStep;
  final int totalSteps;
  final String stepName;
  final String description;
  final double slideProgress;

  const _ExpandedHeader({
    required this.currentStep,
    required this.totalSteps,
    required this.stepName,
    required this.description,
    required this.slideProgress,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: 8.0,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _AnimatedStepIndicator(
              currentStep: currentStep,
              totalSteps: totalSteps,
              slideProgress: slideProgress,
              style: textTheme.bodyMedium,
              color: colorScheme.onSurfaceVariant,
            ),
            _AnimatedText(
              text: stepName,
              slideProgress: slideProgress,
              offset: _kSlideOffsetLarge,
              style: textTheme.titleLarge?.copyWith(color: colorScheme.onSurface),
            ),
          ],
        ),
        _AnimatedText(
          text: description,
          slideProgress: slideProgress,
          offset: _kSlideOffsetMedium,
          fadeIntensity: _kFadeIntensity,
          style: textTheme.bodyMedium?.copyWith(color: colorScheme.onSurfaceVariant),
        ),
      ],
    );
  }
}

/// Animated step indicator
class _AnimatedStepIndicator extends StatelessWidget {
  final int currentStep;
  final int totalSteps;
  final double slideProgress;
  final TextStyle? style;
  final Color color;

  const _AnimatedStepIndicator({
    required this.currentStep,
    required this.totalSteps,
    required this.slideProgress,
    required this.style,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      spacing: 4.0,
      children: [
        Text('STEP', style: style?.copyWith(color: color)),
        _AnimatedText(
          text: '$currentStep',
          slideProgress: slideProgress,
          offset: _kSlideOffsetSmall,
          style: style?.copyWith(color: color),
        ),
        Text('/ $totalSteps', style: style?.copyWith(color: color)),
      ],
    );
  }
}

/// Animated text with slide and fade transitions
class _AnimatedText extends StatelessWidget {
  final String text;
  final double slideProgress;
  final double offset;
  final double fadeIntensity;
  final TextStyle? style;
  final TextOverflow? overflow;

  const _AnimatedText({
    required this.text,
    required this.slideProgress,
    required this.offset,
    this.fadeIntensity = 1.0,
    this.style,
    this.overflow,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRect(
      child: Transform.translate(
        offset: Offset(slideProgress * -offset, 0),
        child: Opacity(
          opacity: (1.0 - slideProgress.abs() * fadeIntensity).clamp(0.0, 1.0),
          child: Text(text, style: style, overflow: overflow, softWrap: overflow == null),
        ),
      ),
    );
  }
}

//--------------------------------------------------------------------------------------------------------------------//
// PAGE WIDGETS
//--------------------------------------------------------------------------------------------------------------------//

/// Generic selection page widget for Sport, Complex, and Court selection
class _SelectionPage<T> extends StatefulWidget {
  const _SelectionPage({
    required this.items,
    required this.selectedItem,
    required this.itemBuilder,
    this.useGridView = false,
  });

  final List<T> items;
  final T? selectedItem;

  final Widget Function(BuildContext context, T item, int index, ValueNotifier<int> selectedIndex, int? crossAxisCount)
  itemBuilder;

  final bool useGridView;

  @override
  State<_SelectionPage<T>> createState() => _SelectionPageState<T>();
}

class _SelectionPageState<T> extends State<_SelectionPage<T>> {
  late final ValueNotifier<int> _selectedIndex;

  @override
  void initState() {
    super.initState();
    _selectedIndex = ValueNotifier<int>(_getInitialIndex());
  }

  @override
  void didUpdateWidget(covariant _SelectionPage<T> oldWidget) {
    super.didUpdateWidget(oldWidget);

    final newIndex = _getInitialIndex();
    if (newIndex != _selectedIndex.value) {
      _selectedIndex.value = newIndex;
    }
  }

  @override
  void dispose() {
    _selectedIndex.dispose();
    super.dispose();
  }

  int _getInitialIndex() {
    if (widget.selectedItem == null) return -1;

    // Para la página de selección del deporte
    if (T == Sport) {
      return (widget.items as List<Sport>).indexOf(widget.selectedItem as Sport);
    }

    // Para las páginas de selección del complejo y pista
    if (widget.selectedItem is Complex) {
      return widget.items.indexWhere((item) => (item as Complex).id == (widget.selectedItem as Complex).id);
    }
    if (widget.selectedItem is Court) {
      return widget.items.indexWhere((item) => (item as Court).id == (widget.selectedItem as Court).id);
    }

    return -1;
  }

  void _onItemTap(int index) {
    _selectedIndex.value = index;
  }

  @override
  Widget build(BuildContext context) {
    return widget.useGridView ? _buildGridView() : _buildListView();
  }

  Widget _buildGridView() {
    return CustomGridView.expressive(
      padding: const EdgeInsets.fromLTRB(
        _kContentHorizontalPadding,
        _kContentTopPadding,
        _kContentHorizontalPadding,
        _kContentBottomPadding,
      ),
      maxCrossAxisExtent: _kGridMaxCrossAxisExtent,
      childAspectRatio: _kGridChildAspectRatio,
      itemCount: widget.items.length,
      itemBuilder: (context, index, crossAxisCount) {
        return GestureDetector(
          onTap: () => _onItemTap(index),
          child: widget.itemBuilder(context, widget.items[index], index, _selectedIndex, crossAxisCount),
        );
      },
    );
  }

  Widget _buildListView() {
    return ListView.builder(
      padding: const EdgeInsets.fromLTRB(
        _kContentHorizontalPadding,
        _kContentTopPadding - 1.0,
        _kContentHorizontalPadding,
        _kContentBottomPadding,
      ),
      itemCount: widget.items.length,
      itemBuilder: (context, index) {
        return widget.itemBuilder(context, widget.items[index], index, _selectedIndex, null);
      },
    );
  }
}

class _SummaryPage extends StatelessWidget {
  const _SummaryPage(this.sport, this.complex, this.court, this.dateTimeRange);

  final Sport? sport;
  final Complex? complex;
  final Court? court;
  final DateTimeRange? dateTimeRange;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        spacing: 2.0,
        children: [
          _buildComplexContainer(context),
          _buildDateTimeContainer(context),
          Row(
            spacing: 2.0,
            children: [
              Expanded(child: _buildSportContainer(context)),
              Expanded(child: _buildCapacityContainer(context)),
            ],
          ),
          _buildCourtContainer(context),
        ],
      ),
    );
  }

  Widget _buildComplexContainer(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    final brightness = Theme.brightnessOf(context);

    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: brightness == Brightness.light ? colorScheme.surfaceContainerLowest : colorScheme.surfaceContainerHigh,
        borderRadius: BorderRadius.vertical(top: Radius.circular(12.0), bottom: Radius.circular(4.0)),
      ),
      child: Row(
        spacing: 8.0,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(complex!.name, style: textTheme.titleMedium?.copyWith(color: colorScheme.onSurface)),
                Row(
                  spacing: 4.0,
                  children: [
                    Icon(
                      Symbols.location_on_rounded,
                      size: 18,
                      fill: 0,
                      weight: 400,
                      grade: 0,
                      opticalSize: 18,
                      color: colorScheme.onSurfaceVariant,
                    ),
                    Expanded(
                      child: MarqueeWidget(
                        child: Text(
                          complex!.address,
                          style: textTheme.bodyMedium?.copyWith(color: colorScheme.onSurfaceVariant),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          IconButton.filled(
            onPressed: () {},
            icon: Icon(
              Symbols.directions_rounded,
              size: 24,
              fill: 1,
              weight: 400,
              grade: 0,
              opticalSize: 24,
              color: colorScheme.onPrimary,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDateTimeContainer(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    final brightness = Theme.brightnessOf(context);

    // Calcular el tiempo restante y obtener la cadena de texto representativa
    final remaining = dateTimeRange!.end.difference(dateTimeRange!.start);
    final remainingText = remaining.inHours > 0 && remaining.inMinutes.remainder(60) > 0
        ? '${remaining.inHours}h ${remaining.inMinutes.remainder(60)}m'
        : remaining.inHours > 0
        ? '${remaining.inHours}h'
        : '${remaining.inMinutes}m';

    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: brightness == Brightness.light ? colorScheme.surfaceContainerLowest : colorScheme.surfaceContainerHigh,
        borderRadius: BorderRadius.all(Radius.circular(4.0)),
      ),
      child: Column(
        spacing: 8.0,
        children: [
          CustomChip.medium.neutral(palette: WidgetPalette.primary, label: dateTimeRange!.start.toFormattedDate2()),
          Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('START', style: textTheme.labelSmall?.copyWith(color: colorScheme.onSurfaceVariant)),
                  Text('END', style: textTheme.labelSmall?.copyWith(color: colorScheme.onSurfaceVariant)),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                spacing: 8.0,
                children: [
                  Text(dateTimeRange!.start.toFormattedTime0(), style: textTheme.titleMedium),
                  Expanded(
                    child: Stack(
                      alignment: AlignmentGeometry.center,
                      children: [
                        Divider(
                          height: 2.0,
                          thickness: 2.0,
                          color: colorScheme.primary,
                          radius: BorderRadius.circular(1000.0),
                        ),
                        CustomChip.medium.neutral(palette: WidgetPalette.primary, label: remainingText),
                      ],
                    ),
                  ),
                  Text(dateTimeRange!.end.toFormattedTime0(), style: textTheme.titleMedium),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSportContainer(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final brightness = Theme.brightnessOf(context);

    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: brightness == Brightness.light ? colorScheme.surfaceContainerLowest : colorScheme.surfaceContainerHigh,
        borderRadius: BorderRadius.all(Radius.circular(4.0)),
      ),
      child: LabeledInfoWidget(label: 'SPORT', text: sport!.name.toCapitalized()),
    );
  }

  Widget _buildCapacityContainer(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final brightness = Theme.brightnessOf(context);

    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: brightness == Brightness.light ? colorScheme.surfaceContainerLowest : colorScheme.surfaceContainerHigh,
        borderRadius: BorderRadius.all(Radius.circular(4.0)),
      ),
      child: LabeledInfoWidget(label: 'CAPACITY', text: court!.maxPeople.toString().padLeft(2, '0')),
    );
  }

  Widget _buildCourtContainer(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final brightness = Theme.brightnessOf(context);

    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: brightness == Brightness.light ? colorScheme.surfaceContainerLowest : colorScheme.surfaceContainerHigh,
        borderRadius: BorderRadius.vertical(top: Radius.circular(4.0), bottom: Radius.circular(12.0)),
      ),
      child: LabeledInfoWidget(label: 'FACILITY', text: '${court!.name} · Grass'),
    );
  }
}

//--------------------------------------------------------------------------------------------------------------------//
// CONTROL WIDGETS
//--------------------------------------------------------------------------------------------------------------------//

/// Navigation controls for moving between pages
class _PageNavigationControls extends StatelessWidget {
  const _PageNavigationControls({
    required this.currentPage,
    required this.totalPages,
    required this.canContinue,
    required this.onPrevious,
    required this.onNext,
  });

  final int currentPage;
  final int totalPages;
  final bool canContinue;
  final VoidCallback onPrevious;
  final VoidCallback onNext;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final brightness = Theme.brightnessOf(context);

    final filledButtonTheme = Theme.of(context).filledButtonTheme;

    final canGoBack = currentPage != 0;

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      spacing: _kButtonSpacing,
      children: [
        FilledButton(
          onPressed: canGoBack ? onPrevious : null,
          style: ButtonStyle(
            backgroundColor: WidgetStatePropertyAll(
              !canGoBack
                  ? filledButtonTheme.style?.backgroundColor?.resolve({WidgetState.disabled})
                  : brightness == Brightness.light
                  ? colorScheme.surfaceContainerLowest
                  : colorScheme.surfaceContainerHigh,
            ),
            foregroundColor: WidgetStatePropertyAll(
              !canGoBack
                  ? filledButtonTheme.style?.foregroundColor?.resolve({WidgetState.disabled})
                  : colorScheme.onSurface,
            ),
            minimumSize: WidgetStatePropertyAll(Size(_kBackButtonWidth, _kButtonMinHeight)),
          ),
          child: const Text("Back"),
        ),
        Expanded(
          child: FilledButton(
            style: ButtonStyle(minimumSize: WidgetStatePropertyAll(Size.fromHeight(_kButtonMinHeight))),
            onPressed: canContinue ? onNext : null,
            child: Text(currentPage != totalPages - 1 ? 'Continue' : 'Confirm reservation'),
          ),
        ),
      ],
    );
  }
}

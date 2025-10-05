import 'package:flutter/material.dart';

class MarqueeWidget extends StatefulWidget {
  final Widget child;
  final Axis direction;
  final double charactersPerSecond;
  final Duration pauseDuration;

  const MarqueeWidget({
    super.key,
    required this.child,
    this.direction = Axis.horizontal,
    this.charactersPerSecond = 4.0,
    this.pauseDuration = const Duration(milliseconds: 800),
  });

  @override
  State<MarqueeWidget> createState() => _MarqueeWidgetState();
}

class _MarqueeWidgetState extends State<MarqueeWidget> {
  late ScrollController _controller;
  bool _needsScrolling = false;
  Duration _calculatedDuration = const Duration(seconds: 2);

  @override
  void initState() {
    super.initState();

    _controller = ScrollController();
    _calculateAnimationDuration();
    WidgetsBinding.instance.addPostFrameCallback(_checkIfScrollingNeeded);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _calculateAnimationDuration() {
    String text = _extractTextFromWidget(widget.child);
    int characterCount = text.length;

    double durationInSeconds = characterCount / widget.charactersPerSecond;
    durationInSeconds = durationInSeconds < 1.0 ? 1.0 : durationInSeconds;

    _calculatedDuration = Duration(milliseconds: (durationInSeconds * 1000).round());
  }

  String _extractTextFromWidget(Widget widget) {
    if (widget is Text) {
      return widget.data ?? '';
    } else if (widget is RichText) {
      return widget.text.toPlainText();
    }
    return '';
  }

  void _checkIfScrollingNeeded(_) {
    if (!_controller.hasClients) return;

    if (_controller.position.maxScrollExtent > 0) {
      _calculateAnimationDuration();
      setState(() => _needsScrolling = true);
      _startScrolling();
    }
  }

  void _startScrolling() async {
    if (!mounted || !_controller.hasClients || !_needsScrolling) return;

    while (mounted && _controller.hasClients && _needsScrolling) {
      await Future.delayed(widget.pauseDuration);

      if (!mounted || !_controller.hasClients) break;

      await _controller.animateTo(
        _controller.position.maxScrollExtent,
        duration: _calculatedDuration,
        curve: Curves.easeInOut,
      );

      if (!mounted || !_controller.hasClients) break;

      await Future.delayed(widget.pauseDuration);

      if (!mounted || !_controller.hasClients) break;

      await _controller.animateTo(0.0, duration: _calculatedDuration, curve: Curves.easeInOut);
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      controller: _controller,
      scrollDirection: widget.direction,
      physics: const NeverScrollableScrollPhysics(),
      child: widget.child,
    );
  }
}

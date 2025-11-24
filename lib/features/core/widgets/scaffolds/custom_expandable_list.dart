import 'package:flutter/material.dart';

class CustomExpandableListTile extends StatelessWidget {
  const CustomExpandableListTile({super.key, required this.icon, required this.label, this.onTap});

  final IconData icon;
  final String label;

  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 16.0),
      leading: Icon(
        icon,
        size: 24,
        fill: 0,
        weight: 400,
        grade: 0,
        opticalSize: 24,
        color: colorScheme.onSurfaceVariant,
      ),
      title: Text(label, style: textTheme.bodyLarge?.copyWith(color: colorScheme.onSurfaceVariant)),
      onTap: onTap,
    );
  }
}

class CustomExpandableList extends StatefulWidget {
  const CustomExpandableList({
    super.key,
    this.leading,
    required this.title,
    required this.children,
    required this.backgroundColor,
    required this.textColor,
    required this.iconColor,
    required this.separatorColor,
    this.isExpanded = false,
    this.onExpansionChanged,
  });

  final IconData? leading;
  final String title;
  final List<CustomExpandableListTile> children;

  final Color backgroundColor;
  final Color textColor;
  final Color iconColor;
  final Color separatorColor;

  final bool isExpanded;
  final ValueChanged<bool>? onExpansionChanged;

  @override
  State<CustomExpandableList> createState() => _CustomExpandableListState();
}

class _CustomExpandableListState extends State<CustomExpandableList> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _iconTurns;
  late Animation<double> _heightFactor;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(duration: const Duration(milliseconds: 200), vsync: this);
    _iconTurns = Tween<double>(
      begin: 0.0,
      end: 0.5,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));
    _heightFactor = CurvedAnimation(parent: _controller, curve: Curves.easeInOut);

    if (widget.isExpanded) {
      _controller.value = 1.0;
    }
  }

  @override
  void didUpdateWidget(CustomExpandableList oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.isExpanded != oldWidget.isExpanded) {
      setState(() {
        if (widget.isExpanded) {
          _controller.forward();
        } else {
          _controller.reverse();
        }
      });
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _handleTap() {
    widget.onExpansionChanged?.call(!widget.isExpanded);
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return Material(
          borderRadius: BorderRadius.circular(28.0),
          clipBehavior: Clip.antiAlias,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ClipRRect(
                borderRadius: const BorderRadius.vertical(top: Radius.circular(28.0), bottom: Radius.circular(2.0)),
                child: Material(
                  color: widget.backgroundColor,
                  child: InkWell(
                    onTap: _handleTap,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
                      child: Row(
                        children: [
                          if (widget.leading != null) ...[
                            IconTheme(
                              data: IconThemeData(color: widget.iconColor),
                              child: Icon(
                                widget.leading!,
                                size: 24,
                                fill: 1,
                                weight: 400,
                                grade: 0,
                                opticalSize: 24,
                                color: colorScheme.onSurface,
                              ),
                            ),
                            const SizedBox(width: 16.0),
                          ],
                          Expanded(child: Text(widget.title, style: textTheme.titleMedium)),
                          RotationTransition(
                            turns: _iconTurns,
                            child: Icon(Icons.expand_more, color: widget.iconColor),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              ClipRect(
                child: Align(
                  alignment: Alignment.topCenter,
                  heightFactor: _heightFactor.value,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      for (int i = 0; i < widget.children.length; ++i) ...[
                        Container(height: 2.0, color: widget.separatorColor),
                        ClipRRect(
                          borderRadius: i == widget.children.length - 1
                              ? const BorderRadius.vertical(top: Radius.circular(2.0), bottom: Radius.circular(28.0))
                              : BorderRadius.circular(2.0),
                          child: Material(color: widget.backgroundColor, child: widget.children[i]),
                        ),
                      ],
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

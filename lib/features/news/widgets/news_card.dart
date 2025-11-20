import 'package:flutter/material.dart';
import 'package:sportying_app/features/core/utils/widget_palette.dart';
import 'package:sportying_app/features/core/widgets/visuals/custom_chip.dart';

class NewsCard extends StatelessWidget {
  final String title;
  final DateTime date;
  late final Duration _dateDifference;

  NewsCard({super.key, required this.title, required this.date}) {
    _dateDifference = DateTime.now().difference(date);
  }

  String _getCreationString() {
    if (_dateDifference.inDays > 0) {
      if (_dateDifference.inDays > 365) {
        return '${(_dateDifference.inDays / 365).floor()} years ago';
      } else if (_dateDifference.inDays > 30) {
        return '${(_dateDifference.inDays / 30).floor()} months ago';
      } else {
        return '${_dateDifference.inDays} days ago';
      }
    } else if (_dateDifference.inHours > 0) {
      return '${_dateDifference.inHours} hours ago';
    } else if (_dateDifference.inMinutes > 0) {
      return '${_dateDifference.inMinutes} minutes ago';
    } else {
      return 'Just now';
    }
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    final brightness = Theme.brightnessOf(context);

    return Card.filled(
      margin: EdgeInsets.zero,
      color: Colors.transparent,
      // shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(28.0)),
      clipBehavior: Clip.antiAlias,
      child: Container(
        decoration: BoxDecoration(
          image: const DecorationImage(image: AssetImage('assets/images/placeholders/news.jpg'), fit: BoxFit.cover),
        ),
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [Colors.black.withAlpha(100), Colors.black.withAlpha(210)],
              stops: const [0.6, 1.0],
            ),
          ),
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            spacing: 8.0,
            children: [
              if (_dateDifference.inDays <= 7) _RecencyChip(),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: 4.0,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      spacing: 16.0,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          spacing: 4.0,
                          children: [
                            Text(
                              'News title',
                              style: textTheme.titleLarge?.copyWith(
                                color: brightness == Brightness.light ? colorScheme.surface : colorScheme.onSurface,
                              ),
                            ),
                            CustomChip.small.translucent(palette: WidgetPalette.normal, label: _getCreationString()),
                          ],
                        ),
                        Text(
                          'Lorem ipsum dolor sit amet, consectetur adipiscing elit.',
                          style: textTheme.bodyMedium?.copyWith(
                            color: brightness == Brightness.light ? colorScheme.surface : colorScheme.onSurface,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      spacing: 4.0,
                      children: [
                        TextButton(
                          // style: ButtonStyle(
                          //   overlayColor: WidgetStatePropertyAll(
                          //     brightness == Brightness.light
                          //         ? colorScheme.secondaryContainer.withAlpha(25)
                          //         : colorScheme.secondary.withAlpha(25),
                          //   ),
                          //   foregroundColor: WidgetStatePropertyAll(
                          //     brightness == Brightness.light ? colorScheme.secondaryContainer : colorScheme.secondary,
                          //   ),
                          // ),
                          onPressed: () {},
                          child: const Text('Read more'),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _RecencyChip extends StatelessWidget {
  const _RecencyChip();

  @override
  Widget build(BuildContext context) {
    final palette = Theme.brightnessOf(context) == Brightness.light ? WidgetPalette.inverse : WidgetPalette.normal;

    return CustomChip.medium.alert(palette: palette, label: 'NEW');
  }
}

import 'package:flutter/material.dart';
import 'package:sportying_app/features/core/widgets/small_chip.dart';

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

    return Card.filled(
      margin: EdgeInsetsGeometry.zero,
      clipBehavior: Clip.antiAlias,
      child: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          final imageHeight = constraints.maxHeight * 0.5;

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(12.0),
                child: Image.asset(
                  'assets/images/placeholders/news.jpg',
                  width: double.infinity,
                  height: imageHeight,
                  fit: BoxFit.cover,
                ),
              ),
              Padding(
                padding: EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: 16.0,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      spacing: 8.0,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          spacing: 4.0,
                          children: [
                            Text('News title', style: textTheme.titleLarge),
                            Text(_getCreationString(), style: textTheme.labelSmall),
                          ],
                        ),
                        if (_dateDifference.inDays <= 7) SmallChip.alert(label: 'NEW'),
                      ],
                    ),
                    Text('Lorem ipsum dolor sit amet, consectetur adipiscing elit.', style: textTheme.bodyMedium),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      spacing: 4.0,
                      children: [
                        TextButton(
                          style: ButtonStyle(foregroundColor: WidgetStatePropertyAll(colorScheme.onPrimary)),
                          onPressed: () {},
                          child: const Text('Read more'),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

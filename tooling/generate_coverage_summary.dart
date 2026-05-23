import 'dart:io';

void main() {
  final input = File('coverage/lcov.info');
  if (!input.existsSync()) {
    stderr.writeln('Missing coverage/lcov.info. Run flutter test --coverage first.');
    exitCode = 1;
    return;
  }

  final rows = <({String file, int found, int hit})>[];
  String? file;
  var found = 0;
  var hit = 0;

  for (final line in input.readAsLinesSync()) {
    if (line.startsWith('SF:')) {
      file = line.substring(3);
      found = 0;
      hit = 0;
    } else if (line.startsWith('LF:')) {
      found = int.parse(line.substring(3));
    } else if (line.startsWith('LH:')) {
      hit = int.parse(line.substring(3));
    } else if (line == 'end_of_record' &&
        file != null &&
        found > 0 &&
        !file.endsWith('.g.dart') &&
        !file.endsWith('.freezed.dart')) {
      rows.add((file: file, found: found, hit: hit));
    }
  }

  rows.sort((a, b) => a.file.compareTo(b.file));
  final foundTotal = rows.fold(0, (total, row) => total + row.found);
  final hitTotal = rows.fold(0, (total, row) => total + row.hit);
  final coverage = foundTotal == 0 ? 0 : hitTotal * 100 / foundTotal;

  final summary = StringBuffer()
    ..writeln('## Test coverage')
    ..writeln()
    ..writeln('Generated from `flutter test --coverage test/unit/ test/widget/`.')
    ..writeln()
    ..writeln('| File | Covered lines | Coverage |')
    ..writeln('| --- | ---: | ---: |');

  for (final row in rows) {
    summary.writeln(
      '| `${row.file}` | ${row.hit}/${row.found} | '
      '${(row.hit * 100 / row.found).toStringAsFixed(1)}% |',
    );
  }

  summary
    ..writeln()
    ..writeln(
      '**Total excluding generated files: $hitTotal/$foundTotal lines '
      'covered (${coverage.toStringAsFixed(1)}%).**',
    );

  File('coverage/summary.md').writeAsStringSync(summary.toString());
  stdout.writeln('Coverage summary: $hitTotal/$foundTotal (${coverage.toStringAsFixed(1)}%).');
}

import 'package:flutter_test/flutter_test.dart';
import 'package:material_symbols_icons/material_symbols_icons.dart';
import 'package:sportying_app/features/core/utils/widget_status.dart';

void main() {
  test('each widget status exposes its identifying icon', () {
    expect(WidgetStatus.normal.icon, equals(Symbols.info_rounded));
    expect(WidgetStatus.neutral.icon, equals(Symbols.info_rounded));
    expect(WidgetStatus.translucent.icon, equals(Symbols.info_rounded));
    expect(WidgetStatus.alert.icon, equals(Symbols.warning_rounded));
    expect(WidgetStatus.success.icon, equals(Symbols.check_circle_rounded));
    expect(WidgetStatus.error.icon, equals(Symbols.error_outline_rounded));
  });
}

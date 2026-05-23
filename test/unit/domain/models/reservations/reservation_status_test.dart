import 'package:flutter_test/flutter_test.dart';
import 'package:material_symbols_icons/material_symbols_icons.dart';
import 'package:sportying_app/domain/models/reservations/reservation_status.dart';

void main() {
  test('only pending reservation statuses are active', () {
    expect(ReservationStatus.scheduled.isActive, isTrue);
    expect(ReservationStatus.weather.isActive, isTrue);
    expect(ReservationStatus.completed.isActive, isFalse);
    expect(ReservationStatus.cancelled.isActive, isFalse);
  });

  test('each reservation status exposes its identifying icon', () {
    expect(ReservationStatus.scheduled.icon, equals(Symbols.hourglass_rounded));
    expect(ReservationStatus.weather.icon, equals(Symbols.cloud_rounded));
    expect(ReservationStatus.completed.icon, equals(Symbols.check_rounded));
    expect(ReservationStatus.cancelled.icon, equals(Symbols.close_rounded));
  });
}

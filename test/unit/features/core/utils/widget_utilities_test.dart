import 'package:flutter_test/flutter_test.dart';
import 'package:geocoding/geocoding.dart';
import 'package:sportying_app/features/core/utils/widget_side.dart';
import 'package:sportying_app/features/core/utils/widget_utilities.dart';

class FakeGeocodingPlatform extends GeocodingPlatform {
  List<Placemark> placemarks = const [];

  @override
  Future<List<Placemark>> placemarkFromCoordinates(double latitude, double longitude) async => placemarks;
}

void main() {
  late FakeGeocodingPlatform geocoding;

  setUp(() {
    geocoding = FakeGeocodingPlatform();
    GeocodingPlatform.instance = geocoding;
  });

  group('WidgetUtilities.getAddressFromLatLng', () {
    test('joins non-empty address parts from geocoding results', () async {
      geocoding.placemarks = const [Placemark(street: 'Gran Via 1', name: '', locality: 'Madrid')];

      final address = await WidgetUtilities.getAddressFromLatLng(40.4, -3.7);

      expect(address, equals('Gran Via 1, Madrid'));
    });

    test('returns its fallback for an empty placemark', () async {
      geocoding.placemarks = const [Placemark(street: '', name: '', locality: '')];

      final address = await WidgetUtilities.getAddressFromLatLng(40.4, -3.7);

      expect(address, equals('No address provided'));
    });
  });

  group('WidgetUtilities.calculateBorderRadiusSide', () {
    test('marks ends for a single-column list', () {
      expect(WidgetUtilities.calculateBorderRadiusSide(3, 0), equals(WidgetSide.top));
      expect(WidgetUtilities.calculateBorderRadiusSide(3, 1), equals(WidgetSide.none));
      expect(WidgetUtilities.calculateBorderRadiusSide(3, 2), equals(WidgetSide.bottom));
    });

    test('marks the four corners of a complete grid', () {
      expect(WidgetUtilities.calculateBorderRadiusSide(6, 0, crossAxisCount: 3), equals(WidgetSide.topLeft));
      expect(WidgetUtilities.calculateBorderRadiusSide(6, 2, crossAxisCount: 3), equals(WidgetSide.topRight));
      expect(WidgetUtilities.calculateBorderRadiusSide(6, 3, crossAxisCount: 3), equals(WidgetSide.bottomLeft));
      expect(WidgetUtilities.calculateBorderRadiusSide(6, 5, crossAxisCount: 3), equals(WidgetSide.bottomRight));
    });

    test('handles empty and single-element collections', () {
      expect(WidgetUtilities.calculateBorderRadiusSide(0, 0), equals(WidgetSide.none));
      expect(WidgetUtilities.calculateBorderRadiusSide(2, 0, crossAxisCount: 0), equals(WidgetSide.none));
      expect(WidgetUtilities.calculateBorderRadiusSide(1, 0), equals(WidgetSide.all));
      expect(WidgetUtilities.calculateBorderRadiusSide(1, 0, crossAxisCount: 3), equals(WidgetSide.left));
    });

    test('marks ends for a single row and ignores non-corner grid cells', () {
      expect(WidgetUtilities.calculateBorderRadiusSide(3, 0, crossAxisCount: 3), equals(WidgetSide.left));
      expect(WidgetUtilities.calculateBorderRadiusSide(3, 1, crossAxisCount: 3), equals(WidgetSide.none));
      expect(WidgetUtilities.calculateBorderRadiusSide(3, 2, crossAxisCount: 3), equals(WidgetSide.right));
      expect(WidgetUtilities.calculateBorderRadiusSide(9, 4, crossAxisCount: 3), equals(WidgetSide.none));
      expect(WidgetUtilities.calculateBorderRadiusSide(8, 7, crossAxisCount: 3), equals(WidgetSide.none));
    });
  });
}

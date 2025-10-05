import 'package:geocoding/geocoding.dart';

class WidgetUtilities {
  static Future<String> getAddressFromLatLng(double lat, double lng) async {
    try {
      List<Placemark> placemarks = await placemarkFromCoordinates(lat, lng);
      Placemark place = placemarks.first;

      final parts = [place.street, place.name, place.locality];
      final address = parts.where((p) => p != null && p.trim().isNotEmpty).join(", ");

      return address.isNotEmpty ? address : 'C/XXXXXXXX XXXXXXXX, 00';
    } catch (e) {
      return 'C/XXXXXXXX XXXXXXXX, 00';
    }
  }
}

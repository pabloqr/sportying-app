import 'package:geocoding/geocoding.dart';
import 'package:sportying_app/features/core/utils/widget_side.dart';

class WidgetUtilities {
  static Future<String> getAddressFromLatLng(double lat, double lng) async {
    try {
      final placemarks = await placemarkFromCoordinates(lat, lng);
      final place = placemarks.first;

      final parts = [place.street, place.name, place.locality];
      final address = parts.where((p) => p != null && p.trim().isNotEmpty).join(', ');

      return address.isNotEmpty ? address : 'No address provided';
    } catch (e) {
      return 'No address provided';
    }
  }

  static WidgetSide calculateBorderRadiusSide(int length, int index, {int crossAxisCount = 1}) {
    // Casos base: un solo elemento, o datos inválidos
    if (length == 0 || crossAxisCount == 0) return WidgetSide.none;
    if (length == 1) return crossAxisCount == 1 ? WidgetSide.all : WidgetSide.left;

    // Calcular posiciones en el grid
    final col = index % crossAxisCount;
    final row = index ~/ crossAxisCount;
    final lastRow = (length - 1) ~/ crossAxisCount;

    // Caso extremo: una columna
    if (crossAxisCount == 1) {
      if (index == 0) return WidgetSide.top;
      if (index == length - 1) return WidgetSide.bottom;
      return WidgetSide.none;
    }

    // Caso extremo: una fila
    if (length <= crossAxisCount) {
      if (index == 0) return WidgetSide.left;
      if (index == crossAxisCount - 1) return WidgetSide.right;
      return WidgetSide.none;
    }

    // Calcular los valores para las flags de esquinas
    final isFirstRow = row == 0;
    final isLastRow = row == lastRow;
    final isFirstCol = col == 0;
    final isLastCol = col == crossAxisCount - 1;

    // Caso frecuente: no está en ningún borde
    if ((!isFirstRow && !isLastRow) || (!isFirstCol && !isLastCol)) return WidgetSide.none;

    // Los casos restante son esquinas, calcular la correspondiente
    if (isFirstRow && isFirstCol) return WidgetSide.topLeft;
    if (isFirstRow && isLastCol) return WidgetSide.topRight;
    if (isLastRow && isFirstCol) return WidgetSide.bottomLeft;
    if (isLastRow && isLastCol) return WidgetSide.bottomRight;

    return WidgetSide.none;
  }
}

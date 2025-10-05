class NetworkUtilities {
  static String? validateQueryValue({required Type type, required dynamic value}) {
    if (type == String) {
      if (value is String) return value;
    } else if (type == int) {
      if (value is int) {
        return value.toString();
      } else if (value is String && int.tryParse(value) != null) {
        return value;
      }
    } else if (type == double) {
      if (value is double) {
        return value.toString();
      } else if (value is int) {
        return value.toDouble().toString();
      } else if (value is String && double.tryParse(value) != null) {
        return value;
      }
    } else if (type == DateTime) {
      if (value is DateTime) {
        return value.toIso8601String();
      } else if (value is String && DateTime.tryParse(value) != null) {
        return value;
      }
    }
    return null;
  }
}
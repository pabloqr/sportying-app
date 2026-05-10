import 'package:sportying_app/core/utils/result.dart';

class ResultUtils {
  static T unwrapOrThrow<T>(Result<T> result) => switch (result) {
    Ok(:final value) => value,
    Error(:final error) => throw error,
  };
}

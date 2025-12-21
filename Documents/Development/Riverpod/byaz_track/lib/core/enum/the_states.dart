import 'package:byaz_track/core/extension/extensions.dart';

enum TheStates { initial, success, error, loading }

extension TheStatesExtension on TheStates {
  T? whenOrNull<T>({
    T Function()? initial,
    T Function()? success,
    T Function()? error,
    T Function()? loading,
  }) {
    switch (this) {
      case TheStates.initial:
        return initial?.call();
      case TheStates.success:
        return success?.call();
      case TheStates.error:
        return error?.call();
      case TheStates.loading:
        return loading?.call();
    }
  }

  Widget showWidget({
    Widget Function()? initial,
    Widget Function()? success,
    Widget Function()? error,
    Widget Function()? loading,
    Widget Function()? orElse, // Fallback function
  }) {
    switch (this) {
      case TheStates.initial:
        return initial?.call() ?? orElse?.call() ?? const SizedBox();
      case TheStates.success:
        return success?.call() ?? orElse?.call() ?? const SizedBox();
      case TheStates.error:
        return error?.call() ?? orElse?.call() ?? const SizedBox();
      case TheStates.loading:
        return loading?.call() ?? orElse?.call() ?? const SizedBox();
    }
  }
}

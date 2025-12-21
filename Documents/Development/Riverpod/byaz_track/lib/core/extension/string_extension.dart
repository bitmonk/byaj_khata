extension StringExtension on String? {
  String removeTime() {
    return this?.substring(0, 10) ?? '';
  }

  bool isNullOrEmpty() {
    return this == null || this!.isEmpty;
  }

  String routePath() {
    return '/$this';
  }
}

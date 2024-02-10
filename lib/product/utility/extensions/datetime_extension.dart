extension DateTimeExt on int {
  String get convertToTimeWithZero {
    if (this < 10) {
      return '0$this';
    } else {
      return '$this';
    }
  }
}

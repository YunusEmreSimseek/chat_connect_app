enum FontSizeEnum {
  low(value: 12),
  lowMid(value: 16),
  medium(value: 20),
  midHigh(value: 24),
  high(value: 28),
  veryHigh(value: 32),
  ;

  final double value;

  const FontSizeEnum({required this.value});
}

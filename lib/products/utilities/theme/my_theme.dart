import 'package:flutter/material.dart';

@immutable
final class MyTheme {
  const MyTheme._();

  static dark() {
    return ThemeData.dark().copyWith(appBarTheme: const AppBarTheme(centerTitle: true));
  }

  static light() {
    ThemeData.light().copyWith();
  }
}

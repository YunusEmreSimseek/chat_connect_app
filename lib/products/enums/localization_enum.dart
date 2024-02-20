import 'package:chat_connect_app/products/init/language/locale_keys.g.dart';
import 'package:flutter/material.dart';

enum LocalizationEnum {
  en('en', 'US', LocaleKeys.general_languge_english),
  tr('tr', 'TR', LocaleKeys.general_languge_turkish);

  final String langugeKey;
  final String country;
  final String languge;

  const LocalizationEnum(this.langugeKey, this.country, this.languge);

  String get path => 'assets/translations';
  Locale get toLocale => Locale(langugeKey, country);

  static final List<Locale> supportedLocales = [
    LocalizationEnum.en.toLocale,
    LocalizationEnum.tr.toLocale,
  ];
}

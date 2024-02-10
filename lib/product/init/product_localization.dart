import 'package:chat_connect_app/product/enums/localization_enum.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

@immutable

/// Product Localization Manager
final class ProductLocalization extends EasyLocalization {
  ProductLocalization({super.key, required super.child})
      : super(supportedLocales: _supportedItems, path: _translationPath, fallbackLocale: _fallbackLocale);

  static final List<Locale> _supportedItems = [
    LocalizationEnum.en.toLocale,
    LocalizationEnum.tr.toLocale,
  ];

  static const String _translationPath = 'assets/translations';

  static final Locale _fallbackLocale = LocalizationEnum.en.toLocale;

  static Future<void> updateLanguge({required BuildContext context, required LocalizationEnum value}) =>
      context.setLocale(value.toLocale);
}

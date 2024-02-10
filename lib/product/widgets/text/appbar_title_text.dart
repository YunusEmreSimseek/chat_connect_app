import 'package:chat_connect_app/product/enums/font_size_enum.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';

class AppBarTitleText extends StatelessWidget {
  const AppBarTitleText(this.text, {super.key});
  final String text;

  @override
  Widget build(BuildContext context) {
    return Text(
      text.tr(),
      textAlign: TextAlign.center,
      style: context.general.textTheme.titleLarge
          ?.copyWith(fontSize: FontSizeEnum.veryHigh.value, fontWeight: FontWeight.bold),
    );
  }
}

import 'package:chat_connect_app/product/enums/font_size_enum.dart';
import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';

class CustomText extends StatelessWidget {
  const CustomText(this.text,
      {super.key, this.textAlign = TextAlign.center, this.size = FontSizeEnum.medium, this.isBold = false});
  final String text;
  final TextAlign textAlign;
  final FontSizeEnum size;
  final bool isBold;
  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: textAlign,
      style: context.general.textTheme.titleLarge
          ?.copyWith(fontSize: size.value, fontWeight: isBold ? FontWeight.bold : FontWeight.normal),
    );
  }
}

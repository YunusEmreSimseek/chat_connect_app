import 'package:chat_connect_app/products/enums/font_size_enum.dart';
import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';

class UnderlineTextButton extends StatelessWidget {
  const UnderlineTextButton({super.key, required this.text, this.onPressed});
  final String text;
  final void Function()? onPressed;
  @override
  Widget build(BuildContext context) {
    return TextButton(
        onPressed: onPressed,
        child: Text(
          text,
          style: context.general.textTheme.titleMedium
              ?.copyWith(decoration: TextDecoration.underline, fontSize: FontSizeEnum.low.value),
          //style: const TextStyle(decoration: TextDecoration.underline),
        ));
  }
}

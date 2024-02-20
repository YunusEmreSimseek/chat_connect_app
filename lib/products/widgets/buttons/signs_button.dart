import 'package:chat_connect_app/products/widgets/text/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';

class SignsButton extends StatelessWidget {
  const SignsButton({super.key, required this.text, required this.onPressed});
  final String text;
  final void Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      child: Padding(
        padding: context.padding.normal,
        child: CustomText(text),
      ),
    );
  }
}

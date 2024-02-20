import 'package:chat_connect_app/products/enums/image_enum.dart';
import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';

class CoreImage extends StatelessWidget {
  const CoreImage({super.key});

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      ImageEnum.appIcon.toPng,
      height: context.sized.dynamicHeight(.25),
      fit: BoxFit.cover,
    );
  }
}

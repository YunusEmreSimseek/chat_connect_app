import 'package:flutter/material.dart';

enum ImageEnum {
  appIcon(value: 'app_icon'),
  defaultUserIcon(
      value:
          'https://firebasestorage.googleapis.com/v0/b/chatconnectapp-bf24d.appspot.com/o/ic_default_user_image.png?alt=media&token=5b94ec4f-777f-494d-93ef-ecf8922ba2f8');

  final String value;
  const ImageEnum({required this.value});

  String get toPng => 'assets/icons/ic_$value.png';
  Image get toImage => Image.asset(toPng);
}

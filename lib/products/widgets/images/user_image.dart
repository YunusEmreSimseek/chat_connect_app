import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';

class UserImage extends StatelessWidget {
  const UserImage({super.key, required this.imageUrl, this.fit = BoxFit.contain, this.height = .065, this.width = .2});
  final String imageUrl;
  final BoxFit fit;
  final double height;
  final double width;
  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: context.border.normalBorderRadius,
      child: Image.network(
        imageUrl,
        filterQuality: FilterQuality.high,
        fit: fit,
        height: context.sized.dynamicHeight(height),
        width: context.sized.dynamicWidth(width),
        alignment: Alignment.center,
      ),
    );
  }
}

import 'package:chat_connect_app/product/enums/font_size_enum.dart';
import 'package:chat_connect_app/product/enums/icon_size_enum.dart';
import 'package:chat_connect_app/product/widgets/images/user_image.dart';
import 'package:chat_connect_app/product/widgets/text/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';

class CustomListTile extends StatelessWidget {
  const CustomListTile({super.key, this.imageUrl, required this.title, this.subtitle});
  final String? imageUrl;
  final String title;
  final String? subtitle;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: context.sized.dynamicHeight(.1),
      width: context.sized.dynamicWidth(.75),
      child: Row(mainAxisAlignment: MainAxisAlignment.start, crossAxisAlignment: CrossAxisAlignment.center, children: [
        imageUrl == null
            ? const SizedBox.shrink()
            : UserImage(
                imageUrl: imageUrl!,
                fit: BoxFit.cover,
              ),
        imageUrl != null ? context.sized.emptySizedWidthBoxNormal : const SizedBox.shrink(),
        subtitle == null
            ? CustomText(title)
            : Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomText(title),
                  CustomText(subtitle ?? '', size: FontSizeEnum.low),
                ],
              ),
        const Spacer(),
        Icon(
          Icons.chevron_right_rounded,
          size: IconSizeEnum.high.value,
        )
      ]),
    );
  }
}

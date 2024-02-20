import 'package:chat_connect_app/products/widgets/listtile/custom_list_tile.dart';
import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';

class SettingsCard extends StatelessWidget {
  const SettingsCard({super.key, required this.titleText, this.subtitleText, this.imageUrl, this.onTap});
  final String titleText;
  final String? subtitleText;
  final String? imageUrl;
  final void Function()? onTap;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: SizedBox(
        height: context.sized.dynamicHeight(.11),
        child: Card(
          shape: RoundedRectangleBorder(borderRadius: context.border.normalBorderRadius),
          child: Center(
            child: CustomListTile(
              imageUrl: imageUrl,
              title: titleText,
              subtitle: subtitleText,
            ),
          ),
        ),
      ),
    );
  }
}

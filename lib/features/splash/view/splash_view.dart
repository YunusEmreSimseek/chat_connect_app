import 'package:chat_connect_app/features/login/view/login_view.dart';
import 'package:chat_connect_app/product/enums/font_size_enum.dart';
import 'package:chat_connect_app/product/enums/image_enum.dart';
import 'package:chat_connect_app/product/init/language/locale_keys.g.dart';
import 'package:chat_connect_app/product/widgets/text/custom_text.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Padding(
          padding: context.padding.normal,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              context.sized.emptySizedHeightBoxNormal,
              CustomText(
                LocaleKeys.splash_welcome.tr(),
                size: FontSizeEnum.high,
              ),
              context.sized.emptySizedHeightBoxNormal,
              InkWell(
                onTap: () => context.route.navigateToPage(const LoginView()),
                child: Image.asset(
                  ImageEnum.appIcon.toPng,
                  height: context.sized.dynamicHeight(.3),
                  fit: BoxFit.cover,
                ),
              ),
              context.sized.emptySizedHeightBoxNormal,
              CustomText(LocaleKeys.splash_title.tr()),
              context.sized.emptySizedHeightBoxLow,
              CustomText(LocaleKeys.splash_subtitle.tr(), size: FontSizeEnum.lowMid),
            ],
          ),
        ),
      ),
    );
  }
}

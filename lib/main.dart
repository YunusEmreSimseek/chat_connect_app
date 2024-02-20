import 'package:chat_connect_app/features/splash/view/splash_view.dart';
import 'package:chat_connect_app/products/init/app_initialize.dart';
import 'package:chat_connect_app/products/init/bloc_init.dart';
import 'package:chat_connect_app/products/init/language/locale_keys.g.dart';
import 'package:chat_connect_app/products/init/product_localization.dart';
import 'package:chat_connect_app/products/utilities/theme/my_theme.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

void main() async {
  // initialize
  await AppInitialize.init();
  runApp(
    // if you edit the easy localization
    // you can that inside of ProductLocalization
    ProductLocalization(child: const MyApp()),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // if you want to add a provider in multiblockprovider
    // please go to BlockInit and add in there
    return BlocInit(
      child: MaterialApp(
        localizationsDelegates: context.localizationDelegates,
        supportedLocales: context.supportedLocales,
        locale: context.locale,
        theme: MyTheme.dark(),
        title: LocaleKeys.general_appName.tr(),
        home: const SplashView(),
      ),
    );
  }
}

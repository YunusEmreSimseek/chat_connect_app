import 'dart:async';

import 'package:chat_connect_app/firebase_options.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:easy_logger/easy_logger.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';
import 'package:logger/logger.dart';

@immutable
final class AppInitialize {
  const AppInitialize._();

  static Future<void> init() async {
    WidgetsFlutterBinding.ensureInitialized();
    await runZonedGuarded<Future<void>>(_init, (error, stack) {
      Logger().e(error);
      Logger().e(stack);
    });
  }

  static Future<void> _init() async {
    await EasyLocalization.ensureInitialized();
    EasyLocalization.logger.enableLevels = [LevelMessages.error];
    await DeviceUtility.instance.initPackageInfo();
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
    FlutterError.onError = (details) {
      Logger().e(details.exceptionAsString());
    };
  }
}

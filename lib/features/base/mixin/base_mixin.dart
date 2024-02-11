import 'package:chat_connect_app/features/base/view/base_scaffold.dart';
import 'package:chat_connect_app/features/chat/view/chat_view.dart';
import 'package:chat_connect_app/features/home/view/home_view.dart';
import 'package:chat_connect_app/features/settings/view/settings_view.dart';
import 'package:flutter/material.dart';

mixin BaseMixin on State<BaseScaffold> {
  Widget changeBodyPage(int currentIndex) {
    switch (currentIndex) {
      case 0:
        return const HomeView();
      case 1:
        return const ChatView();
      case 2:
        return const SettingsView();
      default:
        return const ChatView();
    }
  }
}

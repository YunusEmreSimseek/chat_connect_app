part of '../view/base_scaffold.dart';

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

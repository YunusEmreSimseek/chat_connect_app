part of '../view/settings_view.dart';

mixin SettingsMixin on State<SettingsView> {
  Future<void> navigateToPage(Widget page) async {
    await context.route.navigateToPage(page);
  }

  Future<void> signOut() async {
    await FirebaseAuth.instance.signOut();
    if (!mounted) return;
    context.read<BaseCubit>().dispose();
    context.read<ChatCubit>().dispose();
    context.read<SettingsCubit>().dispose();
    context.read<ChatDetailCubit>().dispose();
    context.read<HomeCubit>().dispose();
    context.read<LoadingCubit>().dispose();

    Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => const LoginView(),
        ));
  }
}

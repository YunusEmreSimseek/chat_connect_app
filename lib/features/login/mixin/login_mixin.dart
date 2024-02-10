import 'package:chat_connect_app/features/base/cubit/base_cubit.dart';
import 'package:chat_connect_app/features/base/view/base_scaffold.dart';
import 'package:chat_connect_app/features/login/cubit/login_cubit.dart';
import 'package:chat_connect_app/features/login/view/login_view.dart';
import 'package:chat_connect_app/features/register/view/register_view.dart';
import 'package:chat_connect_app/product/init/language/locale_keys.g.dart';
import 'package:chat_connect_app/product/widgets/dialogs/general_show_dialog.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kartal/kartal.dart';

mixin LoginMixin on State<LoginView> {
  late final TextEditingController emailController;
  late final TextEditingController passwordController;
  late final ScrollController scrollController;
  late final GlobalKey<FormState> formKey;
  final User? user = FirebaseAuth.instance.currentUser;

  Future<void> chechUser() async {
    context.read<BaseCubit>().changeLoading();
    final response = context.read<LoginCubit>().isLoggedIn(FirebaseAuth.instance.currentUser);
    if (response) {
      await setInformationsToStates();
      if (!mounted) return;
      context.read<BaseCubit>().changeLoading();
      navigateToChatView();
      return;
    }
    if (!mounted) return;
    context.read<BaseCubit>().changeLoading();
  }

  void initControllers() {
    emailController = TextEditingController();
    passwordController = TextEditingController();
    scrollController = ScrollController();
    formKey = GlobalKey();
  }

  void disposeControllers() {
    emailController.dispose();
    passwordController.dispose();
    scrollController.dispose();
  }

  void navigateToRegisterView() {
    context.route.navigateToPage(const RegisterView());
  }

  void navigateToChatView() {
    context.route.navigateToPage(const BaseScaffold());
  }

  Future<void> login() async {
    context.read<BaseCubit>().changeLoading();
    final response = await context.read<LoginCubit>().signIn(emailController.text, passwordController.text);
    if (response) {
      await setInformationsToStates();
      if (!mounted) return;
      context.read<BaseCubit>().changeLoading();
      navigateToChatView();
      return;
    }
    if (!response) {
      if (!mounted) return;
      context.read<BaseCubit>().changeLoading();
      if (!mounted) return;
      GeneralShowDialog.dialog(
          context: context,
          title: LocaleKeys.dialog_login_unsuccessful_title.tr(),
          subtitle: LocaleKeys.dialog_login_unsuccessful_content.tr());
    }
  }

  void scrollToBottomOnKeyboardOpen() {
    scrollController.animateTo(
      scrollController.position.maxScrollExtent,
      duration: const Duration(milliseconds: 100),
      curve: Curves.easeOut,
    );
  }

  Future<void> setInformationsToStates() async {
    await context.read<BaseCubit>().initialize(FirebaseAuth.instance.currentUser!.email!, context);
    if (!mounted) return;
    context.read<BaseCubit>().sendSignedInUserToStates(context);
    context.read<BaseCubit>().sendChatsToStates(context);
    context.read<BaseCubit>().sendChattedUsersToChatState(context);
    context.read<BaseCubit>().sendPostedUsersToHomeState(context);
  }
}

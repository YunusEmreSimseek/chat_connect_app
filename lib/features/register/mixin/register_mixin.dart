import 'package:chat_connect_app/features/base/view/base_scaffold.dart';
import 'package:chat_connect_app/features/login/view/login_view.dart';
import 'package:chat_connect_app/features/register/cubit/register_cubit.dart';
import 'package:chat_connect_app/features/register/view/register_view.dart';
import 'package:chat_connect_app/product/enums/image_enum.dart';
import 'package:chat_connect_app/product/init/language/locale_keys.g.dart';
import 'package:chat_connect_app/product/models/user_model.dart';
import 'package:chat_connect_app/product/widgets/dialogs/general_show_dialog.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kartal/kartal.dart';

mixin RegisterMixin on State<RegisterView> {
  late final TextEditingController emailController;
  late final TextEditingController passwordController;
  late final TextEditingController passwordConfirmController;
  late final TextEditingController nameController;
  late final ScrollController scrollController;
  late final GlobalKey<FormState> formKey;

  void initControllers() {
    emailController = TextEditingController();
    passwordController = TextEditingController();
    passwordConfirmController = TextEditingController();
    nameController = TextEditingController();
    scrollController = ScrollController();
    formKey = GlobalKey();
  }

  void disposeControllers() {
    emailController.dispose();
    passwordController.dispose();
    passwordConfirmController.dispose();
    nameController.dispose();
    scrollController.dispose();
  }

  void navigateToLoginView() {
    context.route.navigateToPage(const LoginView());
  }

  Future<void> register() async {
    if (formKey.currentState!.validate() && passwordController.text == passwordConfirmController.text) {
      UserModel user = UserModel(
        email: emailController.text,
        name: nameController.text,
        password: passwordController.text,
        imageUrl: ImageEnum.defaultUserIcon.value,
        phoneNo: '',
      );
      //final response = await context.read<RegisterCubit>().registerUser(user);
      final response = await context.read<RegisterCubit>().signUp(user);
      if (response) {
        if (mounted) {
          //await context.read<RegisterCubit>().firstUpdateForId();
          if (FirebaseAuth.instance.currentUser != null) {
            await context.read<RegisterCubit>().addIdIntoUser(FirebaseAuth.instance.currentUser!.email!);
          }
          if (!mounted) return;
          GeneralShowDialog.dialog(
              context: context,
              title: LocaleKeys.dialog_register_succes_title,
              subtitle: LocaleKeys.dialog_register_succes_content);
          Future.delayed(const Duration(seconds: 2), () => context.route.pop());
          Future.delayed(
              const Duration(seconds: 2, milliseconds: 500), () => context.route.navigateToPage(const BaseScaffold()));
        }
      }
    }
  }

  void scrollToBottomOnKeyboardOpen() {
    scrollController.animateTo(
      scrollController.position.maxScrollExtent,
      duration: const Duration(milliseconds: 100),
      curve: Curves.easeOut,
    );
  }
}

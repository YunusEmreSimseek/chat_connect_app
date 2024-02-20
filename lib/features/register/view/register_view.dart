import 'package:chat_connect_app/features/base/view/base_scaffold.dart';
import 'package:chat_connect_app/features/login/view/login_view.dart';
import 'package:chat_connect_app/features/register/cubit/register_cubit.dart';
import 'package:chat_connect_app/products/index.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kartal/kartal.dart';

part '../mixin/register_mixin.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({super.key});

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> with BaseViewMixin, RegisterMixin {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RegisterCubit, RegisterState>(
      builder: (context, state) {
        if (context.general.isKeyBoardOpen) {
          scrollToBottomOnKeyboardOpen();
        }
        return Scaffold(
          appBar: AppBar(title: const AppBarTitleText(LocaleKeys.register_title), actions: const [LoadingWidget()]),
          body: Form(
            key: formKey,
            child: Padding(
              padding: context.padding.normal + context.padding.horizontalLow,
              child: Center(
                child: SingleChildScrollView(
                  controller: scrollController,
                  child: Column(children: [
                    const CoreImage(),
                    context.sized.emptySizedHeightBoxLow,
                    CustomTextFormField(controller: nameController, type: TextFieldTypeEnum.name),
                    context.sized.emptySizedHeightBoxLow,
                    CustomTextFormField(controller: emailController, type: TextFieldTypeEnum.email),
                    context.sized.emptySizedHeightBoxLow,
                    CustomTextFormField(controller: passwordController, type: TextFieldTypeEnum.password),
                    context.sized.emptySizedHeightBoxLow,
                    CustomTextFormField(controller: passwordConfirmController, type: TextFieldTypeEnum.confirmPassword),
                    context.sized.emptySizedHeightBoxLow3x,
                    SignsButton(text: LocaleKeys.general_button_signUp.tr(), onPressed: register),
                    UnderlineTextButton(
                        text: LocaleKeys.register_alreadyHaveAccount.tr(), onPressed: navigateToLoginView)
                  ]),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

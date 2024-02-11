import 'package:chat_connect_app/features/register/cubit/register_cubit.dart';
import 'package:chat_connect_app/features/register/mixin/register_mixin.dart';
import 'package:chat_connect_app/product/enums/text_field_type_enum.dart';
import 'package:chat_connect_app/product/init/language/locale_keys.g.dart';
import 'package:chat_connect_app/product/widgets/buttons/signs_button.dart';
import 'package:chat_connect_app/product/widgets/buttons/underline_text_button.dart';
import 'package:chat_connect_app/product/widgets/field/custom_text_form_field.dart';
import 'package:chat_connect_app/product/widgets/images/core_image.dart';
import 'package:chat_connect_app/product/widgets/text/appbar_title_text.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kartal/kartal.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({super.key});

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> with RegisterMixin {
  @override
  void initState() {
    super.initState();
    initControllers();
  }

  @override
  void dispose() {
    super.dispose();
    disposeControllers();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RegisterCubit, RegisterState>(
      builder: (context, state) {
        if (context.general.isKeyBoardOpen) {
          scrollToBottomOnKeyboardOpen();
        }
        return Scaffold(
          appBar: AppBar(title: const AppBarTitleText(LocaleKeys.register_title), actions: [
            Center(
              child: state.isLoading ? const CircularProgressIndicator() : null,
            )
          ]),
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

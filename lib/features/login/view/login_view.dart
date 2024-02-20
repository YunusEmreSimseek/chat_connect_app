import 'package:chat_connect_app/features/base/cubit/base_cubit.dart';
import 'package:chat_connect_app/features/base/view/base_scaffold.dart';
import 'package:chat_connect_app/features/login/cubit/login_cubit.dart';
import 'package:chat_connect_app/features/register/view/register_view.dart';
import 'package:chat_connect_app/products/index.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kartal/kartal.dart';

part '../mixin/login_mixin.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> with BaseViewMixin, LoginMixin {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginCubit, LoginState>(
      builder: (context, state) {
        if (context.general.isKeyBoardOpen) {
          scrollToBottomOnKeyboardOpen();
        }

        return Scaffold(
          appBar: AppBar(
              leading: const SizedBox.shrink(),
              title: const AppBarTitleText(LocaleKeys.login_title),
              actions: const [LoadingWidget()]),
          body: Center(
            child: SingleChildScrollView(
              controller: scrollController,
              child: Form(
                key: formKey,
                child: Padding(
                  padding: context.padding.normal + context.padding.horizontalLow,
                  child: Column(children: [
                    const CoreImage(),
                    context.sized.emptySizedHeightBoxLow,
                    CustomTextFormField(controller: emailController, type: TextFieldTypeEnum.email, isLogin: true),
                    context.sized.emptySizedHeightBoxLow,
                    CustomTextFormField(
                      controller: passwordController,
                      type: TextFieldTypeEnum.password,
                      isLogin: true,
                    ),
                    context.sized.emptySizedHeightBoxLow,
                    _rememberMeRow(),
                    context.sized.emptySizedHeightBoxLow3x,
                    SignsButton(text: LocaleKeys.general_button_signIn.tr(), onPressed: () async => await login()),
                    context.sized.emptySizedHeightBoxLow,
                    UnderlineTextButton(
                        text: LocaleKeys.login_dontHaveAccount.tr(), onPressed: () => navigateToRegisterView()),
                  ]),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Row _rememberMeRow() {
    return Row(
      children: [
        Checkbox(value: false, onChanged: (value) {}, side: BorderSide(color: ProjectColors.instance.white, width: 20)),
        CustomText(
          LocaleKeys.login_rememberMe.tr(),
          size: FontSizeEnum.lowMid,
        )
      ],
    );
  }
}

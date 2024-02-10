import 'package:chat_connect_app/features/login/cubit/login_cubit.dart';
import 'package:chat_connect_app/features/login/mixin/login_mixin.dart';
import 'package:chat_connect_app/product/constants/project_colors.dart';
import 'package:chat_connect_app/product/enums/font_size_enum.dart';
import 'package:chat_connect_app/product/enums/text_field_type_enum.dart';
import 'package:chat_connect_app/product/init/language/locale_keys.g.dart';
import 'package:chat_connect_app/product/widgets/buttons/signs_button.dart';
import 'package:chat_connect_app/product/widgets/buttons/underline_text_button.dart';
import 'package:chat_connect_app/product/widgets/field/custom_text_form_field.dart';
import 'package:chat_connect_app/product/widgets/images/core_image.dart';
import 'package:chat_connect_app/product/widgets/loadings/loading_widget.dart';
import 'package:chat_connect_app/product/widgets/text/appbar_title_text.dart';
import 'package:chat_connect_app/product/widgets/text/custom_text.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kartal/kartal.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> with LoginMixin {
  @override
  void initState() {
    super.initState();
    Future.microtask(() => chechUser());
    initControllers();
  }

  @override
  void dispose() {
    disposeControllers();
    super.dispose();
  }

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

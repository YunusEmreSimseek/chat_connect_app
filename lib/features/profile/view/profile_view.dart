import 'package:chat_connect_app/features/profile/mixin/profile_mixin.dart';
import 'package:chat_connect_app/features/settings/cubit/settings_cubit.dart';
import 'package:chat_connect_app/product/enums/font_size_enum.dart';
import 'package:chat_connect_app/product/enums/text_field_type_enum.dart';
import 'package:chat_connect_app/product/init/language/locale_keys.g.dart';
import 'package:chat_connect_app/product/widgets/buttons/signs_button.dart';
import 'package:chat_connect_app/product/widgets/loadings/loading_widget.dart';
import 'package:chat_connect_app/product/widgets/field/custom_text_form_field.dart';
import 'package:chat_connect_app/product/widgets/images/user_image.dart';
import 'package:chat_connect_app/product/widgets/text/custom_text.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kartal/kartal.dart';

class ProfileView extends StatefulWidget {
  const ProfileView({super.key});

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> with ProfileMixin {
  @override
  void dispose() {
    super.dispose();
    disposeControllers();
  }

  @override
  void initState() {
    super.initState();
    initControllers();
    setControllersText();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SettingsCubit, SettingsState>(
      builder: (context, state) {
        if (context.general.isKeyBoardOpen) {
          scrollToBottomOnKeyboardOpen();
        }
        return Scaffold(
          appBar: AppBar(
            actions: const [LoadingWidget()],
            title: CustomText(
              LocaleKeys.general_page_profile.tr(),
              size: FontSizeEnum.veryHigh,
              isBold: true,
            ),
          ),
          body: SingleChildScrollView(
            controller: scrollController,
            child: Form(
              key: formKey,
              onChanged: () => compareUserDetailsWithState(),
              child: Padding(
                padding: context.padding.normal + context.padding.horizontalLow,
                child: Column(children: [
                  context.sized.emptySizedHeightBoxNormal,
                  UserImage(
                    imageUrl: state.loggedInUser?.imageUrl ?? '',
                    width: .4,
                    height: .2,
                    fit: BoxFit.cover,
                  ),
                  context.sized.emptySizedHeightBoxLow,
                  InkWell(
                    onTap: () => changeProfilePicture(),
                    child: CustomText(
                      LocaleKeys.profile_title_changePicture.tr(),
                      size: FontSizeEnum.lowMid,
                    ),
                  ),
                  context.sized.emptySizedHeightBoxLow3x,
                  CustomTextFormField(controller: nameController, type: TextFieldTypeEnum.name),
                  context.sized.emptySizedHeightBoxLow,
                  CustomTextFormField(controller: phoneNumberController, type: TextFieldTypeEnum.phone),
                  context.sized.emptySizedHeightBoxLow,
                  CustomTextFormField(controller: emailController, type: TextFieldTypeEnum.email),
                  context.sized.emptySizedHeightBoxLow,
                  CustomTextFormField(controller: passwordController, type: TextFieldTypeEnum.password),
                  context.sized.emptySizedHeightBoxLow3x,
                  state.isProfileChanged
                      ? SignsButton(
                          text: LocaleKeys.profile_button_saveChanges.tr(),
                          onPressed: saveChanges,
                        )
                      : const SizedBox.shrink()
                ]),
              ),
            ),
          ),
        );
      },
    );
  }
}

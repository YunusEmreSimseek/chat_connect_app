part of '../profile_view.dart';

class ProfileViewColumn extends StatelessWidget {
  const ProfileViewColumn({super.key, required this.onTap, required this.controllers, required this.onPressed});
  final void Function() onTap;
  final void Function() onPressed;
  final List<TextEditingController> controllers;
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SettingsCubit, SettingsState>(
      builder: (context, state) {
        return Column(children: [
          context.sized.emptySizedHeightBoxNormal,
          UserImage(
            imageUrl: state.loggedInUser?.imageUrl ?? '',
            width: .4,
            height: .2,
            fit: BoxFit.cover,
          ),
          context.sized.emptySizedHeightBoxLow,
          InkWell(
            onTap: onTap,
            child: CustomText(
              LocaleKeys.profile_title_changePicture.tr(),
              size: FontSizeEnum.lowMid,
            ),
          ),
          context.sized.emptySizedHeightBoxLow3x,
          CustomTextFormField(controller: controllers[0], type: TextFieldTypeEnum.name),
          context.sized.emptySizedHeightBoxLow,
          CustomTextFormField(controller: controllers[1], type: TextFieldTypeEnum.phone),
          context.sized.emptySizedHeightBoxLow,
          CustomTextFormField(controller: controllers[2], type: TextFieldTypeEnum.email),
          context.sized.emptySizedHeightBoxLow,
          CustomTextFormField(controller: controllers[3], type: TextFieldTypeEnum.password),
          context.sized.emptySizedHeightBoxLow3x,
          state.isProfileChanged
              ? SignsButton(
                  text: LocaleKeys.profile_button_saveChanges.tr(),
                  onPressed: onPressed,
                )
              : const SizedBox.shrink()
        ]);
      },
    );
  }
}

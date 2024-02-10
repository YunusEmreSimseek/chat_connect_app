import 'package:chat_connect_app/features/profile/view/profile_view.dart';
import 'package:chat_connect_app/features/settings/cubit/settings_cubit.dart';
import 'package:chat_connect_app/features/settings/mixin/settings_mixin.dart';
import 'package:chat_connect_app/product/enums/image_enum.dart';
import 'package:chat_connect_app/product/init/language/locale_keys.g.dart';
import 'package:chat_connect_app/product/widgets/buttons/signs_button.dart';
import 'package:chat_connect_app/product/widgets/cards/settings_card.dart';
import 'package:chat_connect_app/product/widgets/dialogs/general_show_dialog.dart';
import 'package:chat_connect_app/product/widgets/text/appbar_title_text.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kartal/kartal.dart';

class SettingsView extends StatefulWidget {
  const SettingsView({super.key});
  @override
  State<SettingsView> createState() => _SettingsViewState();
}

class _SettingsViewState extends State<SettingsView> with SettingsMixin {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const SizedBox.shrink(),
        title: const AppBarTitleText(LocaleKeys.general_page_settings),
      ),
      body: Padding(
        padding: context.padding.normal,
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          BlocBuilder<SettingsCubit, SettingsState>(
            builder: (context, state) {
              return SettingsCard(
                titleText: LocaleKeys.general_page_profile.tr(),
                subtitleText: LocaleKeys.settings_title_editProfile.tr(),
                imageUrl: state.loggedInUser?.imageUrl ?? ImageEnum.defaultUserIcon.value,
                onTap: () => navigateToPage(const ProfileView()),
              );
            },
          ),
          context.sized.emptySizedHeightBoxLow3x,
          SettingsCard(
              titleText: LocaleKeys.settings_title_languge.tr(),
              onTap: () => GeneralShowDialog.dropdownLangugeDialog(context: context)),
          SettingsCard(titleText: LocaleKeys.settings_title_notifications.tr()),
          SettingsCard(titleText: LocaleKeys.settings_title_appSettings.tr()),
          SettingsCard(titleText: LocaleKeys.settings_title_support.tr()),
          context.sized.emptySizedHeightBoxLow3x,
          SignsButton(
            text: LocaleKeys.general_button_signOut.tr(),
            onPressed: () async => await signOut(),
          )
        ]),
      ),
    );
  }
}

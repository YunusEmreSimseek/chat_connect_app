import 'dart:io';

import 'package:chat_connect_app/features/base/cubit/base_cubit.dart';
import 'package:chat_connect_app/features/settings/cubit/settings_cubit.dart';
import 'package:chat_connect_app/products/index.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:kartal/kartal.dart';

part '../mixin/profile_mixin.dart';
part 'sub_view/profile_view_column.dart';

class ProfileView extends StatefulWidget {
  const ProfileView({super.key});

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> with BaseViewMixin, ProfileMixin {
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
            title: const AppBarTitleText(LocaleKeys.general_page_profile),
          ),
          body: SingleChildScrollView(
            controller: scrollController,
            child: Form(
                key: formKey,
                onChanged: () => compareUserDetailsWithState(),
                child: Padding(
                  padding: context.padding.normal + context.padding.horizontalLow,
                  child: ProfileViewColumn(
                    onTap: () => changeProfilePicture(),
                    onPressed: () => saveChanges(),
                    controllers: controllers,
                  ),
                )),
          ),
        );
      },
    );
  }
}

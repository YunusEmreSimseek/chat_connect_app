import 'package:chat_connect_app/features/settings/service/settings_service.dart';
import 'package:chat_connect_app/product/models/user_model.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'settings_state.dart';

final class SettingsCubit extends Cubit<SettingsState> {
  SettingsCubit() : super(const SettingsState());

  final ISettingsService _settingsService = SettingsService();

  Future<void> updateUser(UserModel user) async {
    await _settingsService.updateUser(user);
  }

  Future<void> updateUserImage(String imageUrl) async {
    await _settingsService.updateUserImage(imageUrl, state.loggedInUser!.id!);
  }

  void changeProfileChanged(bool value) {
    emit(state.copyWith(isProfileChanged: value));
  }

  void dispose() {
    emit(const SettingsState());
  }
}

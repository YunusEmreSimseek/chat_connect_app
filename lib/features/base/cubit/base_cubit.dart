import 'package:chat_connect_app/features/base/service/base_service.dart';
import 'package:chat_connect_app/features/chat/cubit/chat_cubit.dart';
import 'package:chat_connect_app/features/chat/view/chat_view.dart';
import 'package:chat_connect_app/features/chat_detail/cubit/chat_detail_cubit.dart';
import 'package:chat_connect_app/features/home/cubit/home_cubit.dart';
import 'package:chat_connect_app/features/home/view/home_view.dart';
import 'package:chat_connect_app/features/login/view/login_view.dart';
import 'package:chat_connect_app/features/settings/cubit/settings_cubit.dart';
import 'package:chat_connect_app/features/settings/view/settings_view.dart';
import 'package:chat_connect_app/products/models/chat_model.dart';
import 'package:chat_connect_app/products/models/message_model.dart';
import 'package:chat_connect_app/products/models/user_model.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'base_state.dart';

final class BaseCubit extends Cubit<BaseState> {
  BaseCubit() : super(const BaseState());

  final IBaseService _baseService = BaseService();

  Future<UserModel?> fetchSignedInUserDetails({String? email}) async {
    if (state.loggedInUser != null) email = state.loggedInUser!.email;
    final user = await _baseService.fetchSignedInUserDetails(email!);
    if (user == null) return null;
    emit(state.copyWith(loggedInUser: user));
    return user;
  }

  Future<void> fetchChats() async {
    if (state.loggedInUser == null || state.loggedInUser!.id == null) return;
    final chats = await _baseService.fetchChats(state.loggedInUser!.id!);
    if (chats == null) return;
    emit(state.copyWith(chats: chats));
  }

  Future<List<UserModel>?> fetchChattedUsers() async {
    if (state.chats == null || state.loggedInUser?.id == null) return null;
    final responseChattedUsers = await _baseService.fetchChattedUsers(state.chats!, state.loggedInUser!.id!);
    if (responseChattedUsers?.isEmpty ?? true) return null;
    List<UserModel> postedUsers = [];
    postedUsers = postedUsers + responseChattedUsers!;
    postedUsers.add(state.loggedInUser!);
    emit(state.copyWith(chattedUsers: responseChattedUsers, postedUsers: postedUsers));
    return null;
  }

  Future<void> initialize(String email, BuildContext context) async {
    await context.read<BaseCubit>().fetchSignedInUserDetails(email: email);
    if (!context.mounted) return;
    await context.read<BaseCubit>().fetchChats();
    if (!context.mounted) return;
    await context.read<BaseCubit>().fetchChattedUsers();
  }

  void sendSignedInUserToStates(BuildContext context) {
    if (state.loggedInUser == null) return;
    final user = state.loggedInUser!;
    context.read<HomeCubit>().emit(context.read<HomeCubit>().state.copyWith(loggedInUser: user));
    context.read<ChatCubit>().emit(context.read<ChatCubit>().state.copyWith(loggedInUser: user));
    context.read<SettingsCubit>().emit(context.read<SettingsCubit>().state.copyWith(loggedInUser: user));
    context.read<ChatDetailCubit>().emit(context.read<ChatDetailCubit>().state.copyWith(loggedInUser: user));
  }

  void sendChatsToStates(BuildContext context) {
    if (state.chats?.isEmpty ?? true) return;
    final chats = state.chats!;
    context.read<ChatCubit>().emit(context.read<ChatCubit>().state.copyWith(chats: chats));
  }

  void sendChattedUsersToChatState(BuildContext context) {
    if (state.chattedUsers?.isEmpty ?? true) return;
    final chattedUsers = state.chattedUsers!;
    context.read<ChatCubit>().emit(context.read<ChatCubit>().state.copyWith(chattedUsers: chattedUsers));
  }

  void sendPostedUsersToHomeState(BuildContext context) {
    if (state.postedUsers?.isEmpty ?? true) return;
    List<UserModel> postedUsers = state.postedUsers!;
    context.read<HomeCubit>().emit(context.read<HomeCubit>().state.copyWith(postedUsers: postedUsers));
  }

  Future<void> fetchMessages(UserModel chattingUser, BuildContext context) async {
    if (state.chats?.isEmpty ?? true) return;
    final chats = state.chats!;
    final ChatModel chat = chats.firstWhere((element) => element.users!.contains(chattingUser.id));
    context.read<ChatDetailCubit>().emit(
        context.read<ChatDetailCubit>().state.copyWith(currentChat: chat, messages: chat.chats!.reversed.toList()));
  }

  void changeCurrentIndex(int value) {
    emit(state.copyWith(currentIndex: value));
  }

  Widget decisionBody() {
    switch (state.currentIndex) {
      case 0:
        return const HomeView();
      case 1:
        return const ChatView();
      case 2:
        return const SettingsView();
    }
    return const LoginView();
  }

  void updateLocalUpdated() {
    emit(state.copyWith(isLocalUpdated: !state.isLocalUpdated));
  }

  void dispose() {
    emit(const BaseState());
  }
}

import 'dart:async';

import 'package:chat_connect_app/features/base/cubit/base_cubit.dart';
import 'package:chat_connect_app/features/chat/cubit/chat_cubit.dart';
import 'package:chat_connect_app/features/chat/view/chat_view.dart';
import 'package:chat_connect_app/product/firebase/firebase_collections.dart';
import 'package:chat_connect_app/product/init/language/locale_keys.g.dart';
import 'package:chat_connect_app/product/widgets/dialogs/general_show_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

mixin ChatMixin on State<ChatView> {
  Stream<QuerySnapshot>? stream;
  late final TextEditingController phoneNumberController;
  StreamSubscription? streamSubscription;

  void initAndListenStream() {
    if (!mounted) return;
    if (context.read<ChatCubit>().state.loggedInUser != null) {
      stream = FirebaseCollections.chat.reference
          .where("users", arrayContains: context.read<ChatCubit>().state.loggedInUser!.id)
          .snapshots();
    }
    if (stream != null) {
      streamSubscription = stream!.listen((snapshot) async {
        await context.read<BaseCubit>().fetchChats();
        if (!mounted) return;
        context.read<BaseCubit>().sendChatsToStates(context);
        await context.read<BaseCubit>().fetchChattedUsers();
        if (!mounted) return;
        context.read<BaseCubit>().sendChattedUsersToChatState(context);
        context.read<BaseCubit>().sendPostedUsersToHomeState(context);
      });
    }
  }

  void initController() {
    phoneNumberController = TextEditingController();
  }

  void disposeController() {
    phoneNumberController.dispose();
  }

  void disposeStreams() {
    if (streamSubscription != null) {
      streamSubscription!.cancel();
    }
  }

  void addChat() {
    Future<void> onPressed({required TextEditingController controller}) async {
      if (controller.text.length == 10) {
        context.read<BaseCubit>().changeLoading();
        final response = await context.read<ChatCubit>().addChat(controller.text);
        if (!mounted) return;
        context.read<BaseCubit>().changeLoading();
        if (response) {
          if (!mounted) return;
          phoneNumberController.clear();
          Navigator.pop(context);

          GeneralShowDialog.dialog(
              context: context,
              title: LocaleKeys.dialog_chat_adding_successful_title.tr(),
              subtitle: LocaleKeys.dialog_chat_adding_successful_content.tr());
          return;
        }
        if (!response) {
          if (!mounted) return;
          GeneralShowDialog.dialog(
              context: context,
              title: LocaleKeys.dialog_chat_adding_unsuccessful_title.tr(),
              subtitle: LocaleKeys.dialog_chat_adding_unsuccessful_content.tr());
        }
      }
    }

    GeneralShowDialog.addChatDialog(
        context: context,
        controller: phoneNumberController,
        onPressed: () => onPressed(controller: phoneNumberController));
  }
}

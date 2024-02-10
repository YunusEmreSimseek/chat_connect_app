import 'dart:async';

import 'package:chat_connect_app/features/base/cubit/base_cubit.dart';
import 'package:chat_connect_app/features/home/cubit/home_cubit.dart';
import 'package:chat_connect_app/features/home/view/home_view.dart';
import 'package:chat_connect_app/product/firebase/firebase_collections.dart';
import 'package:chat_connect_app/product/init/language/locale_keys.g.dart';
import 'package:chat_connect_app/product/models/user_model.dart';
import 'package:chat_connect_app/product/widgets/dialogs/general_show_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

mixin HomeMixin on State<HomeView> {
  late final TextEditingController postController;
  Stream<QuerySnapshot>? stream;
  StreamSubscription? streamSubscription;

  void initController() {
    postController = TextEditingController();
  }

  void initAndListenStream() {
    stream = FirebaseCollections.post.reference
        .where("userId", whereIn: context.read<HomeCubit>().state.postedUsers?.map((e) => e.id).toList())
        .snapshots();
    if (stream != null) {
      streamSubscription = stream!.listen((snapshot) async {
        await context.read<HomeCubit>().fetchPosts();
      });
    }
  }

  void disposeStream() {
    if (streamSubscription != null) {
      streamSubscription!.cancel();
    }
  }

  void disposeController() {
    postController.dispose();
  }

  UserModel? getPostedUser(String userId) {
    final chattedUsers = context.read<HomeCubit>().state.postedUsers;
    if (chattedUsers == null) return null;
    final postedUser = chattedUsers.firstWhere((element) => element.id == userId);
    return postedUser;
  }

  void addPostOnPressed() {
    GeneralShowDialog.addPostDialog(
      context: context,
      controller: postController,
      onPressed: () => addPost(),
    );
  }

  Future<void> addPost() async {
    context.read<BaseCubit>().changeLoading();
    if (postController.text.isEmpty) return;
    final response = await context.read<HomeCubit>().addPost(postController.text);
    if (!mounted) return;
    context.read<BaseCubit>().changeLoading();
    if (response) {
      if (!mounted) return;
      postController.clear();
      Navigator.pop(context);
      if (!mounted) return;
      GeneralShowDialog.dialog(
          context: context,
          title: LocaleKeys.dialog_home_addPost_successful_title.tr(),
          subtitle: LocaleKeys.dialog_home_addPost_successful_content.tr());
      return;
    }
    if (!response) {
      if (!mounted) return;
      GeneralShowDialog.dialog(
          context: context,
          title: LocaleKeys.dialog_home_addPost_unsuccessful_title.tr(),
          subtitle: LocaleKeys.dialog_home_addPost_unsuccessful_content.tr());
    }
  }
}

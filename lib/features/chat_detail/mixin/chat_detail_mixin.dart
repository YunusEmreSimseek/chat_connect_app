import 'dart:async';

import 'package:chat_connect_app/features/base/cubit/base_cubit.dart';
import 'package:chat_connect_app/features/chat_detail/cubit/chat_detail_cubit.dart';
import 'package:chat_connect_app/features/chat_detail/view/chat_detail_view.dart';
import 'package:chat_connect_app/product/firebase/firebase_collections.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

mixin ChatDetailMixin on State<ChatDetailView> {
  Stream<DocumentSnapshot>? stream;
  late final TextEditingController controller;
  late final ScrollController scrollController;
  StreamSubscription? streamSubscription;

  void initAndListenStream() {
    stream = FirebaseCollections.chat.reference.doc(context.read<ChatDetailCubit>().state.currentChat!.id).snapshots();
    if (stream != null) {
      streamSubscription = stream!.listen((event) async {
        if (event.exists) {
          await context.read<BaseCubit>().fetchChats();
          if (!mounted) return;
          context.read<BaseCubit>().sendChatsToStates(context);
          await context.read<ChatDetailCubit>().getMessages(context);
        }
      });
    }
  }

  void initControllers() {
    controller = TextEditingController();
    scrollController = ScrollController();
  }

  void disposeControllers() {
    controller.dispose();
    scrollController.dispose();
  }

  void disposeStream() {
    if (streamSubscription != null) {
      streamSubscription!.cancel();
    }
  }

  Future<void> initMessages() async {
    context.read<BaseCubit>().changeLoading();
    await context.read<ChatDetailCubit>().getMessages(context);
    if (!mounted) return;
    context.read<BaseCubit>().changeLoading();
  }

  void scrollToBottomOnKeyboardOpen(ScrollController controller) {
    controller.animateTo(
      0.0,
      duration: const Duration(milliseconds: 100),
      curve: Curves.easeOut,
    );
  }
}

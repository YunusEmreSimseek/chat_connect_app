import 'dart:async';

import 'package:chat_connect_app/features/base/cubit/base_cubit.dart';
import 'package:chat_connect_app/features/chat/cubit/chat_cubit.dart';
import 'package:chat_connect_app/features/chat_detail/cubit/chat_detail_cubit.dart';
import 'package:chat_connect_app/features/chat_detail/view/chat_detail_view.dart';
import 'package:chat_connect_app/products/index.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kartal/kartal.dart';

part '../mixin/chat_mixin.dart';
part 'sub_view/chatted_user_list_view.dart';

class ChatView extends StatefulWidget {
  const ChatView({super.key});

  @override
  State<ChatView> createState() => _ChatViewState();
}

class _ChatViewState extends State<ChatView> with BaseViewMixin, ChatMixin {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ChatCubit, ChatState>(
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            leading: const SizedBox.shrink(),
            title: const AppBarTitleText(LocaleKeys.general_page_chats),
            actions: [LoadingOrButtonWidget(onPressed: addChat)],
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: ProjectPadding.allNormal(context),
              child: const Column(children: [ChattedUserListView()]),
            ),
          ),
        );
      },
    );
  }
}

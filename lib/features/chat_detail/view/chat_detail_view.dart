import 'dart:async';

import 'package:chat_connect_app/features/base/cubit/base_cubit.dart';
import 'package:chat_connect_app/features/chat_detail/cubit/chat_detail_cubit.dart';
import 'package:chat_connect_app/products/index.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kartal/kartal.dart';

part '../mixin/chat_detail_mixin.dart';
part 'sub_view/animated_bottom_navgiation_bar.dart';
part 'sub_view/app_bar_title.dart';
part 'sub_view/messages_list_view.dart';

class ChatDetailView extends StatefulWidget {
  const ChatDetailView({
    super.key,
  });

  @override
  State<ChatDetailView> createState() => _ChatDetailViewState();
}

class _ChatDetailViewState extends State<ChatDetailView> with BaseViewMixin, ChatDetailMixin {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const AppBarTitle(),
        actions: [SizedBox(width: context.sized.dynamicWidth(.1))],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: context.padding.normal,
          child: Column(children: [
            context.sized.emptySizedHeightBoxLow,
            MessagesListView(
              scrollController: scrollController,
              func: (controller) {
                scrollToBottomOnKeyboardOpen(controller);
              },
            ),
          ]),
        ),
      ),
      bottomNavigationBar: AnimatedBottomNavigationBar(controller: controller),
    );
  }
}

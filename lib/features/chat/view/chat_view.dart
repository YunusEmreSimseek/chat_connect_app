import 'package:chat_connect_app/features/chat/cubit/chat_cubit.dart';
import 'package:chat_connect_app/features/chat/mixin/chat_mixin.dart';
import 'package:chat_connect_app/features/chat_detail/cubit/chat_detail_cubit.dart';
import 'package:chat_connect_app/features/chat_detail/view/chat_detail_view.dart';
import 'package:chat_connect_app/product/enums/font_size_enum.dart';
import 'package:chat_connect_app/product/init/language/locale_keys.g.dart';
import 'package:chat_connect_app/product/utility/extensions/datetime_extension.dart';
import 'package:chat_connect_app/product/widgets/images/user_image.dart';
import 'package:chat_connect_app/product/widgets/loadings/loading_or_button_widget.dart';
import 'package:chat_connect_app/product/widgets/text/appbar_title_text.dart';
import 'package:chat_connect_app/product/widgets/text/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kartal/kartal.dart';

part 'sub_view/chatted_user_list_view.dart';

class ChatView extends StatefulWidget {
  const ChatView({super.key});

  @override
  State<ChatView> createState() => _ChatViewState();
}

class _ChatViewState extends State<ChatView> with ChatMixin {
  @override
  void initState() {
    super.initState();
    initAndListenStream();
    initController();
  }

  @override
  void dispose() {
    super.dispose();
    disposeController();
    disposeStreams();
  }

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
              padding: context.padding.normal,
              child: const Column(children: [ChattedUserListView()]),
            ),
          ),
        );
      },
    );
  }
}

import 'package:chat_connect_app/features/chat_detail/cubit/chat_detail_cubit.dart';
import 'package:chat_connect_app/features/chat_detail/mixin/chat_detail_mixin.dart';
import 'package:chat_connect_app/product/constants/project_colors.dart';
import 'package:chat_connect_app/product/enums/font_size_enum.dart';
import 'package:chat_connect_app/product/enums/icon_size_enum.dart';
import 'package:chat_connect_app/product/models/message_model.dart';
import 'package:chat_connect_app/product/utility/extensions/datetime_extension.dart';
import 'package:chat_connect_app/product/widgets/images/user_image.dart';
import 'package:chat_connect_app/product/widgets/text/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kartal/kartal.dart';

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

class _ChatDetailViewState extends State<ChatDetailView> with ChatDetailMixin {
  @override
  void initState() {
    super.initState();
    initControllers();
    initMessages();
    initAndListenStream();
  }

  @override
  void dispose() {
    super.dispose();
    disposeControllers();
    disposeStream();
  }

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

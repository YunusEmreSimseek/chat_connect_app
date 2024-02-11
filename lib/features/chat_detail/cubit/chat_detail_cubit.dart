import 'package:chat_connect_app/features/base/cubit/base_cubit.dart';
import 'package:chat_connect_app/features/chat_detail/service/chat_detail_service.dart';
import 'package:chat_connect_app/product/models/chat_model.dart';
import 'package:chat_connect_app/product/models/message_model.dart';
import 'package:chat_connect_app/product/models/user_model.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'chat_detail_state.dart';

final class ChatDetailCubit extends Cubit<ChatDetailState> {
  ChatDetailCubit() : super(const ChatDetailState());

  final IChatDetailService _chatDetailService = ChatDetailService();

  Future<void> sendMessage(String content) async {
    await _chatDetailService.sendMessage(content, state.currentChat!, state.chattingUser!.id!, state.loggedInUser!.id!);
  }

  Future<void> getMessages(BuildContext context) async {
    if (state.chattingUser != null) {
      await context.read<BaseCubit>().fetchMessages(state.chattingUser!, context);
    }
  }

  void updateChattingUserMessagesAndChat({
    required UserModel chattingUser,
    required ChatModel currentChat,
  }) {
    emit(state.copyWith(chattingUser: chattingUser, currentChat: currentChat));
  }

  void dispose() {
    emit(const ChatDetailState());
  }
}

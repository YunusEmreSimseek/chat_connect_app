import 'package:chat_connect_app/features/chat/service/chat_service.dart';
import 'package:chat_connect_app/products/models/chat_model.dart';
import 'package:chat_connect_app/products/models/user_model.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'chat_state.dart';

final class ChatCubit extends Cubit<ChatState> {
  ChatCubit() : super(const ChatState());

  final IChatService _chatService = ChatService();

  Future<bool> addChat(String phoneNumber) async {
    final response = await _chatService.addChat(phoneNumber, state.chattedUsers ?? [], state.loggedInUser!.id!);
    return response;
  }

  void dispose() {
    emit(const ChatState());
  }
}

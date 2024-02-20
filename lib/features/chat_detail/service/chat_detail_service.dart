import 'package:chat_connect_app/products/firebase/firebase_collections.dart';
import 'package:chat_connect_app/products/models/chat_model.dart';
import 'package:chat_connect_app/products/models/message_model.dart';
import 'package:flutter/material.dart';

abstract class IChatDetailService {
  Future<void> sendMessage(String content, ChatModel currentChat, String chattingUserId, String loggedInUserId);
}

@immutable
final class ChatDetailService extends IChatDetailService {
  @override
  Future<void> sendMessage(String content, ChatModel currentChat, String chattingUserId, String loggedInUserId) async {
    if (content.isEmpty) return;
    ChatModel chat = currentChat;

    final message = MessageModel(
      time: DateTime.now(),
      content: content,
      fromId: loggedInUserId,
      toId: chattingUserId,
    );
    if (chat.chats == null || chat.chats!.isEmpty) {
      final List<MessageModel?> messages = [message];
      List<Map<String, dynamic>> chatsMapList = messages.map((msg) => msg!.toJson()).toList();
      await FirebaseCollections.chat.reference.doc(currentChat.id).update({
        "lastTime": message.time,
        "users": chat.users,
        "chats": chatsMapList,
      });
      return;
    }
    if (chat.chats != null && chat.chats!.isNotEmpty) {
      chat.chats!.add(message);
      List<Map<String, dynamic>> chatsMapList = chat.chats!.map((msg) => msg!.toJson()).toList();
      await FirebaseCollections.chat.reference.doc(currentChat.id).update({
        "lastTime": message.time,
        "users": chat.users,
        "chats": chatsMapList,
      });
      return;
    }
  }
}

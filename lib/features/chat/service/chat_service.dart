import 'package:chat_connect_app/products/firebase/firebase_collections.dart';
import 'package:chat_connect_app/products/models/chat_model.dart';
import 'package:chat_connect_app/products/models/message_model.dart';
import 'package:chat_connect_app/products/models/user_model.dart';
import 'package:flutter/material.dart';

abstract class IChatService {
  Future<bool> addChat(String phoneNumber, List<UserModel> chattedUsers, String loggedInUserId);
}

@immutable
final class ChatService extends IChatService {
  @override
  Future<bool> addChat(String phoneNumber, List<UserModel> chattedUsers, String loggedInUserId) async {
    final userCollectionReference = FirebaseCollections.user.reference;
    final response = await userCollectionReference
        .where("phoneNo", isEqualTo: phoneNumber)
        .withConverter(
          fromFirestore: (snapshot, options) => UserModel().fromFirebase(snapshot),
          toFirestore: (value, options) {
            return value.toJson();
          },
        )
        .get();
    if (response.docs.isEmpty) {
      return false;
    }
    if (response.docs.isNotEmpty) {
      final addedUser = response.docs.map((e) => e.data()).first;
      if (chattedUsers.isNotEmpty) {
        final bool isContain = chattedUsers.contains(addedUser);
        if (isContain) {
          return false;
        }
      }
      ChatModel newChat = ChatModel(
        users: [loggedInUserId, addedUser.id!],
        lastTime: DateTime.now(),
        chats: <MessageModel>[],
      );
      await FirebaseCollections.chat.reference.add(newChat.toJson());
    }
    return true;
  }
}

import 'package:chat_connect_app/product/firebase/firebase_collections.dart';
import 'package:chat_connect_app/product/models/chat_model.dart';
import 'package:chat_connect_app/product/models/user_model.dart';

abstract class IBaseService {
  Future<UserModel?> fetchSignedInUserDetails(String email);
  Future<List<ChatModel>?> fetchChats(String signedInUserId);
  Future<List<UserModel>?> fetchChattedUsers(List<ChatModel> chats, String loggedInUserId);
}

final class BaseService extends IBaseService {
  @override
  Future<List<ChatModel>?> fetchChats(String signedInUserId) async {
    final chatsCollectionReference = FirebaseCollections.chat.reference;
    final response = await chatsCollectionReference
        .where("users", arrayContains: signedInUserId)
        .withConverter(
          fromFirestore: (snapshot, options) => ChatModel().fromFirebase(snapshot),
          toFirestore: (value, options) {
            return value.toJson();
          },
        )
        .get();

    if (response.docs.isNotEmpty) {
      List<ChatModel> chats = response.docs.map((e) => e.data()).toList();
      chats.sort((a, b) => (a.lastTime ?? DateTime(0)).compareTo(b.lastTime ?? DateTime(0)));
      chats = chats.reversed.toList();
      return chats;
    }
    if (response.docs.isEmpty) {
      return null;
    }
    return null;
  }

  @override
  Future<List<UserModel>?> fetchChattedUsers(List<ChatModel> chats, String loggedInUserId) async {
    if (chats.isEmpty || loggedInUserId.isEmpty) return null;

    final currentUserId = loggedInUserId;
    List<String> chattedUsersId = [];
    List<UserModel> chattedUsers = [];
    for (var index = 0; index < chats.length; index++) {
      chattedUsersId = chattedUsersId + chats[index].users!;
      chattedUsersId.remove(currentUserId);
    }

    final userCollectionReference = FirebaseCollections.user.reference;
    for (var index = 0; index < chattedUsersId.length; index++) {
      final response = await userCollectionReference
          .where("id", isEqualTo: chattedUsersId[index])
          .withConverter(
            fromFirestore: (snapshot, options) => UserModel().fromFirebase(snapshot),
            toFirestore: (value, options) {
              return value.toJson();
            },
          )
          .get();
      if (response.docs.isNotEmpty) {
        final chattedUser = response.docs.map((e) => e.data()).first;
        chattedUsers.add(chattedUser);
      }
    }
    if (chattedUsers.isEmpty) {
      return null;
    }
    if (chattedUsers.isNotEmpty) {
      return chattedUsers;
    }

    return chattedUsers;
  }

  @override
  Future<UserModel?> fetchSignedInUserDetails(String email) async {
    final userCollectionReference = FirebaseCollections.user.reference;
    final response = await userCollectionReference
        .where("email", isEqualTo: email)
        .withConverter(
          fromFirestore: (snapshot, options) => UserModel().fromFirebase(snapshot),
          toFirestore: (value, options) {
            return value.toJson();
          },
        )
        .get();
    if (response.docs.isNotEmpty) {
      final user = response.docs.map((e) => e.data()).first;
      return user;
    }
    if (response.docs.isEmpty) {
      return null;
    }
    return null;
  }
}

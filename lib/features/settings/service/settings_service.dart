import 'package:chat_connect_app/product/firebase/firebase_collections.dart';
import 'package:chat_connect_app/product/models/user_model.dart';
import 'package:flutter/material.dart';

abstract class ISettingsService {
  Future<void> updateUser(UserModel user);
  Future<void> updateUserImage(String imageUrl, String loggedInUserId);
}

@immutable
final class SettingsService extends ISettingsService {
  @override
  Future<void> updateUser(UserModel user) async {
    await FirebaseCollections.user.reference.doc(user.id).update({
      "name": user.name,
      "email": user.email,
      "phoneNo": user.phoneNo,
      "password": user.password,
    });
  }

  @override
  Future<void> updateUserImage(String imageUrl, String loggedInUserId) async {
    await FirebaseCollections.user.reference.doc(loggedInUserId).update({
      "imageUrl": imageUrl,
    });
  }
}

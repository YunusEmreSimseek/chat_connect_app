import 'package:chat_connect_app/products/models/message_model.dart';
import 'package:chat_connect_app/products/utilities/base/base_firebase_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class ChatModel with EquatableMixin, IdModel, BaseFirebaseModel<ChatModel> {
  final List<String>? users;
  final List<MessageModel?>? chats;
  final DateTime? lastTime;
  @override
  final String? id;
  ChatModel({
    this.users,
    this.chats,
    this.lastTime,
    this.id,
  });

  @override
  List<Object?> get props => [users, chats, lastTime, id];

  ChatModel copyWith({
    List<MessageModel?>? chats,
    List<String>? users,
    DateTime? lastTime,
    String? id,
  }) {
    return ChatModel(
      chats: chats ?? this.chats,
      users: users ?? this.users,
      lastTime: lastTime ?? this.lastTime,
      id: id ?? this.id,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'chats': chats,
      'users': users,
      'lastTime': lastTime,
      'id': id,
    };
  }

  @override
  ChatModel fromJson(Map<String, dynamic> json) {
    return ChatModel(
      chats: (json['chats'] as List<dynamic>?)?.map((e) => MessageModel().fromJson(e as Map<String, dynamic>)).toList(),
      id: json['id'] as String?,
      users: (json['users'] as List<dynamic>?)?.map((e) => e as String).toList(),
      lastTime: (json['lastTime'] as Timestamp?)?.toDate(),
    );
  }
}

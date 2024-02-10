import 'package:chat_connect_app/product/utility/base/base_firebase_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class MessageModel with EquatableMixin, IdModel, BaseFirebaseModel<MessageModel> {
  final String? fromId;
  final String? toId;
  final String? content;
  final DateTime? time;
  @override
  final String? id;
  MessageModel({
    this.fromId,
    this.toId,
    this.content,
    this.time,
    this.id,
  });

  @override
  List<Object?> get props => [fromId, toId, content, time, id];

  MessageModel copyWith({
    String? fromId,
    String? toId,
    String? content,
    DateTime? time,
    String? id,
  }) {
    return MessageModel(
      fromId: fromId ?? this.fromId,
      toId: toId ?? this.toId,
      content: content ?? this.content,
      time: time ?? this.time,
      id: id ?? this.id,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'fromId': fromId,
      'toId': toId,
      'content': content,
      'time': time,
      'id': id,
    };
  }

  @override
  MessageModel fromJson(Map<String, dynamic> json) {
    return MessageModel(
      fromId: json['fromId'] as String?,
      toId: json['toId'] as String?,
      content: json['content'] as String?,
      id: json['id'] as String?,
      time: (json['time'] as Timestamp?)?.toDate(),
    );
  }
}

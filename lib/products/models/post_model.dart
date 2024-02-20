import 'package:chat_connect_app/products/utilities/base/base_firebase_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class PostModel with EquatableMixin, IdModel, BaseFirebaseModel<PostModel> {
  final String? userId;
  final String? content;
  final String? imageUrl;
  final DateTime? postedAt;
  @override
  final String? id;
  PostModel({
    this.userId,
    this.content,
    this.imageUrl,
    this.postedAt,
    this.id,
  });

  @override
  List<Object?> get props => [userId, content, id, imageUrl, postedAt];

  PostModel copyWith({
    String? userId,
    String? content,
    String? imageUrl,
    DateTime? postedAt,
    String? id,
  }) {
    return PostModel(
      userId: userId ?? this.userId,
      content: content ?? this.content,
      imageUrl: imageUrl ?? this.imageUrl,
      postedAt: postedAt ?? this.postedAt,
      id: id ?? this.id,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'userId': userId,
      'content': content,
      'imageUrl': imageUrl,
      'postedAt': postedAt,
      'id': id,
    };
  }

  @override
  PostModel fromJson(Map<String, dynamic> json) {
    return PostModel(
      userId: json['userId'] as String?,
      content: json['content'] as String?,
      imageUrl: json['imageUrl'] as String?,
      postedAt: (json['postedAt'] as Timestamp?)?.toDate(),
      id: json['id'] as String?,
    );
  }
}

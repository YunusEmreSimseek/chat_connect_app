part of 'chat_cubit.dart';

final class ChatState extends Equatable {
  const ChatState({
    this.loggedInUser,
    this.chattedUsers,
    this.chats,
  });

  final UserModel? loggedInUser;
  final List<UserModel>? chattedUsers;
  final List<ChatModel>? chats;

  ChatState copyWith({
    UserModel? loggedInUser,
    List<UserModel>? chattedUsers,
    List<ChatModel>? chats,
  }) {
    return ChatState(
      loggedInUser: loggedInUser ?? this.loggedInUser,
      chattedUsers: chattedUsers ?? this.chattedUsers,
      chats: chats ?? this.chats,
    );
  }

  @override
  List<Object?> get props => [loggedInUser, chattedUsers, chats];
}

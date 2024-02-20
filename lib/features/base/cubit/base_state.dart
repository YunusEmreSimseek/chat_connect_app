part of 'base_cubit.dart';

@immutable
final class BaseState extends Equatable {
  const BaseState({
    this.currentIndex = 1,
    this.isLocalUpdated = false,
    this.loggedInUser,
    this.chats,
    this.chattedUsers,
    this.postedUsers,
    this.messages,
  });
  final UserModel? loggedInUser;
  final int currentIndex;
  final bool isLocalUpdated;
  final List<UserModel>? chattedUsers;
  final List<UserModel>? postedUsers;
  final List<ChatModel>? chats;
  final List<MessageModel?>? messages;
  BaseState copyWith({
    UserModel? loggedInUser,
    int? currentIndex,
    bool? isLocalUpdated,
    List<UserModel>? chattedUsers,
    List<UserModel>? postedUsers,
    List<ChatModel>? chats,
    List<MessageModel?>? messages,
  }) {
    return BaseState(
      loggedInUser: loggedInUser ?? this.loggedInUser,
      currentIndex: currentIndex ?? this.currentIndex,
      isLocalUpdated: isLocalUpdated ?? this.isLocalUpdated,
      chattedUsers: chattedUsers ?? this.chattedUsers,
      postedUsers: postedUsers ?? this.postedUsers,
      chats: chats ?? this.chats,
      messages: messages ?? this.messages,
    );
  }

  @override
  List<Object?> get props => [currentIndex, isLocalUpdated, loggedInUser, chattedUsers, postedUsers, chats, messages];
}

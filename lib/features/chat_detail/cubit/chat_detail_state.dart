part of 'chat_detail_cubit.dart';

@immutable
final class ChatDetailState extends Equatable {
  final UserModel? loggedInUser;
  final UserModel? chattingUser;
  final ChatModel? currentChat;
  final List<MessageModel?>? messages;

  const ChatDetailState({
    this.loggedInUser,
    this.chattingUser,
    this.currentChat,
    this.messages,
  });

  ChatDetailState copyWith({
    UserModel? loggedInUser,
    UserModel? chattingUser,
    ChatModel? currentChat,
    List<MessageModel?>? messages,
  }) {
    return ChatDetailState(
      chattingUser: chattingUser ?? this.chattingUser,
      loggedInUser: loggedInUser ?? this.loggedInUser,
      currentChat: currentChat ?? this.currentChat,
      messages: messages ?? this.messages,
    );
  }

  @override
  List<Object?> get props => [loggedInUser, chattingUser, currentChat, messages];
}

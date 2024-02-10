// import 'package:chat_connect_app/features/base/cubit/base_cubit.dart';
// import 'package:chat_connect_app/product/firebase/firebase_collections.dart';
// import 'package:chat_connect_app/product/models/chat_model.dart';
// import 'package:chat_connect_app/product/models/message_model.dart';
// import 'package:chat_connect_app/product/models/user_model.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';

// final class ChatDetailCubit extends Cubit<ChatDetailState> {
//   ChatDetailCubit() : super(ChatDetailState());

//   Future<void> getMessages(BuildContext context) async {
//     if (state.chattingUser != null) {
//       await context.read<BaseCubit>().fetchMessages(state.chattingUser!, context);
//     }
//   }

//   Future<void> sendMessage({required TextEditingController controller}) async {
//     if (controller.text.isEmpty) return;
//     changeLoading();
//     ChatModel chat = state.currentChat!;

//     final message = MessageModel(
//       time: DateTime.now(),
//       content: controller.text,
//       fromId: state.loggedInUser!.id!,
//       toId: state.chattingUser!.id,
//     );
//     if (chat.chats == null || chat.chats!.isEmpty) {
//       final List<MessageModel?> messages = [message];
//       List<Map<String, dynamic>> chatsMapList = messages.map((msg) => msg!.toJson()).toList();
//       await FirebaseCollections.chat.reference.doc(state.currentChat!.id).update({
//         "lastTime": message.time,
//         "users": chat.users,
//         "chats": chatsMapList,
//       });
//       controller.clear();
//       changeLoading();
//       return;
//     }
//     if (chat.chats != null && chat.chats!.isNotEmpty) {
//       chat.chats!.add(message);
//       List<Map<String, dynamic>> chatsMapList = chat.chats!.map((msg) => msg!.toJson()).toList();
//       await FirebaseCollections.chat.reference.doc(state.currentChat!.id).update({
//         "lastTime": message.time,
//         "users": chat.users,
//         "chats": chatsMapList,
//       });
//       controller.clear();
//       changeLoading();
//       return;
//     }
//   }

//   void updateChattingUserMessagesAndChat({
//     required UserModel chattingUser,
//     required ChatModel currentChat,
//   }) {
//     emit(state.copyWith(chattingUser: chattingUser, currentChat: currentChat));
//   }

//   void changeLoading() {
//     emit(state.copyWith(isLoading: !state.isLoading));
//   }

//   void dispose() {
//     emit(ChatDetailState());
//   }
// }

// final class ChatDetailState {
//   final UserModel? loggedInUser;
//   final UserModel? chattingUser;
//   final ChatModel? currentChat;
//   final List<MessageModel?>? messages;
//   final bool isLoading;

//   ChatDetailState({this.loggedInUser, this.chattingUser, this.currentChat, this.messages, this.isLoading = false});

//   ChatDetailState copyWith({
//     UserModel? loggedInUser,
//     UserModel? chattingUser,
//     ChatModel? currentChat,
//     List<MessageModel?>? messages,
//     bool? isLoading,
//   }) {
//     return ChatDetailState(
//       chattingUser: chattingUser ?? this.chattingUser,
//       loggedInUser: loggedInUser ?? this.loggedInUser,
//       currentChat: currentChat ?? this.currentChat,
//       messages: messages ?? this.messages,
//       isLoading: isLoading ?? this.isLoading,
//     );
//   }
// }

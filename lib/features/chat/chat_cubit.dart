// import 'dart:async';

// import 'package:chat_connect_app/product/firebase/firebase_collections.dart';
// import 'package:chat_connect_app/product/models/chat_model.dart';
// import 'package:chat_connect_app/product/models/message_model.dart';
// import 'package:chat_connect_app/product/models/user_model.dart';
// import 'package:equatable/equatable.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';

// class ChatCubit extends Cubit<ChatState> {
//   ChatCubit() : super(const ChatState());

//   Future<bool> addChat(String phoneNumber) async {
//     changeLoading();

//     final userCollectionReference = FirebaseCollections.user.reference;
//     final response = await userCollectionReference
//         .where("phoneNo", isEqualTo: phoneNumber)
//         .withConverter(
//           fromFirestore: (snapshot, options) => UserModel().fromFirebase(snapshot),
//           toFirestore: (value, options) {
//             return value.toJson();
//           },
//         )
//         .get();
//     if (response.docs.isEmpty) {
//       changeLoading();
//       return false;
//     }
//     if (response.docs.isNotEmpty) {
//       final addedUser = response.docs.map((e) => e.data()).first;
//       if (state.chattedUsers != null) {
//         final bool isContain = state.chattedUsers!.contains(addedUser);
//         if (isContain) {
//           changeLoading();
//           return false;
//         }
//       }
//       ChatModel newChat = ChatModel(
//         users: [state.loggedInUser!.id!, addedUser.id!],
//         lastTime: DateTime.now(),
//         chats: <MessageModel>[],
//       );
//       await FirebaseCollections.chat.reference.add(newChat.toJson());
//     }

//     changeLoading();
//     return true;
//   }

//   void changeLoading() {
//     emit(state.copyWith(isLoading: !state.isLoading));
//   }

//   void dispose() {
//     emit(const ChatState());
//   }
// }

// final class ChatState extends Equatable {
//   const ChatState({
//     this.loggedInUser,
//     this.chattedUsers,
//     this.chats,
//     this.isLoading = false,
//   });

//   final UserModel? loggedInUser;
//   final List<UserModel>? chattedUsers;
//   final List<ChatModel>? chats;
//   final bool isLoading;

//   ChatState copyWith({
//     UserModel? loggedInUser,
//     List<UserModel>? chattedUsers,
//     List<ChatModel>? chats,
//     bool? isLoading,
//   }) {
//     return ChatState(
//       loggedInUser: loggedInUser ?? this.loggedInUser,
//       chattedUsers: chattedUsers ?? this.chattedUsers,
//       chats: chats ?? this.chats,
//       isLoading: isLoading ?? this.isLoading,
//     );
//   }

//   @override
//   List<Object?> get props => [loggedInUser, chattedUsers, chats, isLoading];
// }

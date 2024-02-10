// import 'package:chat_connect_app/features/chat/chat_cubit.dart';
// import 'package:chat_connect_app/features/chat/chat_view.dart';
// import 'package:chat_connect_app/features/chat_detail/chat_detail_cubit.dart';
// import 'package:chat_connect_app/features/home/home_cubit.dart';
// import 'package:chat_connect_app/features/home/home_view.dart';
// import 'package:chat_connect_app/features/login/view/login_view.dart';
// import 'package:chat_connect_app/features/settings/settings_cubit.dart';
// import 'package:chat_connect_app/features/settings/settings_view.dart';
// import 'package:chat_connect_app/product/enums/current_index_enum.dart';
// import 'package:chat_connect_app/product/firebase/firebase_collections.dart';
// import 'package:chat_connect_app/product/models/chat_model.dart';
// import 'package:chat_connect_app/product/models/message_model.dart';
// import 'package:chat_connect_app/product/models/user_model.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';

// final class BaseCubit extends Cubit<BaseState> {
//   BaseCubit() : super(BaseState(currentIndex: 1));

//   void changeCurrentIndex(int value) {
//     emit(state.copyWith(currentIndex: value));
//   }

//   Widget decisionBody() {
//     switch (state.currentIndex) {
//       case 0:
//         return const HomeView();
//       case 1:
//         return const ChatView();
//       case 2:
//         return const SettingsView();
//     }
//     return const LoginView();
//   }

//   void updateLocalUpdated() {
//     emit(state.copyWith(isLocalUpdated: !state.isLocalUpdated));
//   }

//   void dispose() {
//     emit(BaseState(currentIndex: CurrentIndexEnum.chats.value));
//   }

//   Future<UserModel?> fetchLoggedInUserDetail(User user) async {
//     final userCollectionReference = FirebaseCollections.user.reference;
//     final response = await userCollectionReference
//         .where("email", isEqualTo: user.email)
//         .withConverter(
//           fromFirestore: (snapshot, options) => UserModel().fromFirebase(snapshot),
//           toFirestore: (value, options) {
//             return value.toJson();
//           },
//         )
//         .get();
//     if (response.docs.isNotEmpty) {
//       final user = response.docs.map((e) => e.data()).first;
//       emit(state.copyWith(loggedInUser: user));
//       return user;
//     }
//     if (response.docs.isEmpty) {
//       return null;
//     }
//     return null;
//   }

//   Future<void> fetchAndSetLoggedInUserToStates(BuildContext context) async {
//     final user = await context.read<BaseCubit>().fetchLoggedInUserDetail(FirebaseAuth.instance.currentUser!);
//     if (user != null) {
//       if (context.mounted) {
//         context.read<HomeCubit>().emit(context.read<HomeCubit>().state.copyWith(loggedInUser: user));
//         context.read<ChatCubit>().emit(context.read<ChatCubit>().state.copyWith(loggedInUser: user));
//         context.read<SettingsCubit>().emit(context.read<SettingsCubit>().state.copyWith(loggedInUser: user));
//         context.read<ChatDetailCubit>().emit(context.read<ChatDetailCubit>().state.copyWith(loggedInUser: user));
//       }
//     }
//   }

//   Future<List<ChatModel>?> fetchChats() async {
//     final chatsCollectionReference = FirebaseCollections.chat.reference;
//     final response = await chatsCollectionReference
//         .where("users", arrayContains: state.loggedInUser?.id)
//         .withConverter(
//           fromFirestore: (snapshot, options) => ChatModel().fromFirebase(snapshot),
//           toFirestore: (value, options) {
//             return value.toJson();
//           },
//         )
//         .get();

//     if (response.docs.isNotEmpty) {
//       List<ChatModel> chats = response.docs.map((e) => e.data()).toList();
//       chats.sort((a, b) => (a.lastTime ?? DateTime(0)).compareTo(b.lastTime ?? DateTime(0)));
//       chats = chats.reversed.toList();
//       emit(state.copyWith(chats: chats));
//       return chats;
//     }
//     if (response.docs.isEmpty) {
//       return null;
//     }
//     return null;
//   }

//   Future<List<UserModel>?> fetchChattedUsers() async {
//     if (state.chats == null) {
//       return null;
//     }
//     if (state.loggedInUser == null) {
//       return null;
//     }
//     final currentUserId = state.loggedInUser!.id;
//     List<String> chattedUsersId = [];
//     List<UserModel> chattedUsers = [];
//     for (var index = 0; index < state.chats!.length; index++) {
//       chattedUsersId = chattedUsersId + state.chats![index].users!;
//       chattedUsersId.remove(currentUserId);
//     }

//     final userCollectionReference = FirebaseCollections.user.reference;
//     for (var index = 0; index < chattedUsersId.length; index++) {
//       final response = await userCollectionReference
//           .where("id", isEqualTo: chattedUsersId[index])
//           .withConverter(
//             fromFirestore: (snapshot, options) => UserModel().fromFirebase(snapshot),
//             toFirestore: (value, options) {
//               return value.toJson();
//             },
//           )
//           .get();
//       if (response.docs.isNotEmpty) {
//         final chattedUser = response.docs.map((e) => e.data()).first;
//         chattedUsers.add(chattedUser);
//       }
//     }
//     if (chattedUsers.isEmpty) {
//       return null;
//     }
//     if (chattedUsers.isNotEmpty) {
//       emit(state.copyWith(chattedUsers: chattedUsers));
//       return chattedUsers;
//     }

//     return chattedUsers;
//   }

//   Future<void> fetchChatsAndSetToStates(BuildContext context) async {
//     final chats = await context.read<BaseCubit>().fetchChats();
//     if (chats != null) {
//       if (context.mounted) {
//         context.read<ChatCubit>().emit(context.read<ChatCubit>().state.copyWith(chats: chats));
//       }
//     }
//   }

//   Future<void> fetchChattedUsersAndSetToChatState(BuildContext context) async {
//     List<UserModel>? chattedUsers = await context.read<BaseCubit>().fetchChattedUsers();
//     if (chattedUsers != null) {
//       if (!context.mounted) return;
//       context.read<ChatCubit>().emit(context.read<ChatCubit>().state.copyWith(chattedUsers: state.chattedUsers));
//       // if (!context.mounted) return;
//       // chattedUsers.add(state.loggedInUser!);
//       // context.read<HomeCubit>().emit(context.read<HomeCubit>().state.copyWith(postedUsers: chattedUsers));
//     }
//   }

//   Future<void> fetchChattedUsersAndSetToHomeState(BuildContext context) async {
//     List<UserModel>? chattedUsers = await context.read<BaseCubit>().fetchChattedUsers();
//     if (chattedUsers != null) {
//       if (!context.mounted) return;
//       chattedUsers.add(state.loggedInUser!);
//       context.read<HomeCubit>().emit(context.read<HomeCubit>().state.copyWith(postedUsers: chattedUsers));
//     }
//   }

//   Future<void> fetchMessages({required UserModel chattingUser, required BuildContext context}) async {
//     final List<ChatModel> chats = state.chats ?? [];
//     if (chats.isNotEmpty) {
//       final ChatModel chat = chats.firstWhere((element) => element.users!.contains(chattingUser.id));
//       context.read<ChatDetailCubit>().emit(
//           context.read<ChatDetailCubit>().state.copyWith(currentChat: chat, messages: chat.chats!.reversed.toList()));
//     }
//   }
// }

// final class BaseState {
//   BaseState(
//       {required this.currentIndex,
//       this.isLocalUpdated = false,
//       this.loggedInUser,
//       this.chats,
//       this.chattedUsers,
//       this.messages});
//   final UserModel? loggedInUser;
//   final int currentIndex;
//   final bool isLocalUpdated;
//   final List<UserModel>? chattedUsers;
//   final List<ChatModel>? chats;
//   final List<MessageModel?>? messages;
//   BaseState copyWith({
//     UserModel? loggedInUser,
//     int? currentIndex,
//     bool? isLocalUpdated,
//     List<UserModel>? chattedUsers,
//     List<ChatModel>? chats,
//     List<MessageModel?>? messages,
//   }) {
//     return BaseState(
//       loggedInUser: loggedInUser ?? this.loggedInUser,
//       currentIndex: currentIndex ?? this.currentIndex,
//       isLocalUpdated: isLocalUpdated ?? this.isLocalUpdated,
//       chattedUsers: chattedUsers ?? this.chattedUsers,
//       chats: chats ?? this.chats,
//       messages: messages ?? this.messages,
//     );
//   }
// }

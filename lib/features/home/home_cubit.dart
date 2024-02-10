// import 'package:chat_connect_app/product/firebase/firebase_collections.dart';
// import 'package:chat_connect_app/product/models/post_model.dart';
// import 'package:chat_connect_app/product/models/user_model.dart';
// import 'package:equatable/equatable.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';

// final class HomeCubit extends Cubit<HomeState> {
//   HomeCubit() : super(const HomeState());

//   void changeLoading() {
//     emit(state.copyWith(isLoading: !state.isLoading));
//   }

//   List<String>? getChattedUsersId() {
//     List<String> postedUserIds = [];
//     for (var user in state.postedUsers!) {
//       postedUserIds.add(user.id!);
//     }
//     return postedUserIds;
//   }

//   Future<void> fetchPosts() async {
//     changeLoading();
//     final chattedUsersId = getChattedUsersId();
//     final postCollectionReference = FirebaseCollections.post.reference;
//     final response = await postCollectionReference
//         .where("userId", whereIn: chattedUsersId)
//         .withConverter(
//           fromFirestore: (snapshot, options) => PostModel().fromFirebase(snapshot),
//           toFirestore: (value, options) {
//             return value.toJson();
//           },
//         )
//         .get();
//     if (response.docs.isEmpty) {
//       changeLoading();
//       return;
//     }
//     if (response.docs.isNotEmpty) {
//       List<PostModel> posts = response.docs.map((e) => e.data()).toList();
//       posts.sort((a, b) => b.postedAt!.compareTo(a.postedAt!));
//       //posts = posts.reversed.toList();
//       emit(state.copyWith(posts: posts));
//     }
//     changeLoading();
//   }

//   // Future<UserModel?> fetchPostedUserDetail(String userId) async {
//   //   changeLoading();
//   //   final userCollectionReference = FirebaseCollections.user.reference;
//   //   final response = await userCollectionReference
//   //       .where("id", isEqualTo: userId)
//   //       .withConverter(
//   //         fromFirestore: (snapshot, options) => UserModel().fromFirebase(snapshot),
//   //         toFirestore: (value, options) {
//   //           return value.toJson();
//   //         },
//   //       )
//   //       .get();
//   //   if (response.docs.isNotEmpty) {
//   //     final user = response.docs.map((e) => e.data()).first;
//   //     changeLoading();
//   //     return user;
//   //   }
//   //   changeLoading();
//   //   return null;
//   // }

//   Future<bool> addPost(String content) async {
//     changeLoading();

//     PostModel newPost = PostModel(
//       userId: state.loggedInUser!.id,
//       content: content,
//       postedAt: DateTime.now(),
//     );
//     await FirebaseCollections.post.reference.add(newPost.toJson());

//     changeLoading();
//     return true;
//   }
// }

// final class HomeState extends Equatable {
//   final UserModel? loggedInUser;
//   final bool isLoading;
//   final List<UserModel>? postedUsers;
//   final List<PostModel>? posts;
//   const HomeState({this.isLoading = false, this.postedUsers, this.posts, this.loggedInUser});

//   HomeState copyWith({
//     UserModel? loggedInUser,
//     bool? isLoading,
//     List<UserModel>? postedUsers,
//     List<PostModel>? posts,
//   }) {
//     return HomeState(
//       loggedInUser: loggedInUser ?? this.loggedInUser,
//       isLoading: isLoading ?? this.isLoading,
//       postedUsers: postedUsers ?? this.postedUsers,
//       posts: posts ?? this.posts,
//     );
//   }

//   @override
//   List<Object?> get props => [loggedInUser, isLoading, postedUsers, posts];
// }

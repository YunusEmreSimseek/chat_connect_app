// import 'package:chat_connect_app/product/firebase/firebase_collections.dart';
// import 'package:chat_connect_app/product/models/user_model.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';

// final class RegisterCubit extends Cubit<RegisterState> {
//   RegisterCubit() : super(RegisterState());

//   void changeObscureText() {
//     emit(state.copyWith(obscureText: !state.obscureText));
//   }

//   Future<bool> registerUser(UserModel user) async {
//     changeLoading();
//     if (user.email == null || user.password == null) return false;
//     final responseAuth =
//         await FirebaseAuth.instance.createUserWithEmailAndPassword(email: user.email!, password: user.password!);
//     if (responseAuth.user == null) return false;
//     final response = await FirebaseCollections.user.reference.add(user.toJson());
//     if (response.id.isEmpty) {
//       return false;
//     }
//     changeLoading();
//     return true;
//   }

//   Future<void> firstUpdateForId() async {
//     final userCollectionReference = FirebaseCollections.user.reference;
//     final response = await userCollectionReference
//         .where("email", isEqualTo: FirebaseAuth.instance.currentUser?.email)
//         .withConverter(
//           fromFirestore: (snapshot, options) => UserModel().fromFirebase(snapshot),
//           toFirestore: (value, options) {
//             return value.toJson();
//           },
//         )
//         .get();
//     if (response.docs.isNotEmpty) {
//       final user = response.docs.map((e) => e.data()).first;
//       await userCollectionReference.doc(user.id).update(user.toJson());
//     }
//   }

//   void changeLoading() {
//     emit(state.copyWith(isLoading: !state.isLoading));
//   }

//   void dispose() {
//     emit(RegisterState());
//   }
// }

// final class RegisterState {
//   final bool obscureText;
//   final bool isLoading;
//   final bool isRedirect;

//   RegisterState({this.obscureText = true, this.isLoading = false, this.isRedirect = false});

//   RegisterState copyWith({
//     bool? obscureText,
//     bool? isLoading,
//     bool? isRedirect,
//   }) {
//     return RegisterState(
//         obscureText: obscureText ?? this.obscureText,
//         isLoading: isLoading ?? this.isLoading,
//         isRedirect: isRedirect ?? this.isRedirect);
//   }
// }

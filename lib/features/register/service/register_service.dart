import 'package:chat_connect_app/products/firebase/firebase_collections.dart';
import 'package:chat_connect_app/products/models/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';

abstract class IRegisterService {
  Future<bool> signUp(UserModel user);
  Future<void> addIdIntoUser(String email);
}

final class RegisterService extends IRegisterService {
  @override
  Future<void> addIdIntoUser(String email) async {
    final userCollectionReference = FirebaseCollections.user.reference;
    final response = await userCollectionReference
        .where("email", isEqualTo: email)
        .withConverter(
          fromFirestore: (snapshot, options) => UserModel().fromFirebase(snapshot),
          toFirestore: (value, options) {
            return value.toJson();
          },
        )
        .get();
    if (response.docs.isNotEmpty) {
      final user = response.docs.map((e) => e.data()).first;
      await userCollectionReference.doc(user.id).update(user.toJson());
    }
  }

  @override
  Future<bool> signUp(UserModel user) async {
    if (user.email == null || user.password == null) return false;
    final responseAuth =
        await FirebaseAuth.instance.createUserWithEmailAndPassword(email: user.email!, password: user.password!);
    if (responseAuth.user == null) return false;
    final response = await FirebaseCollections.user.reference.add(user.toJson());
    if (response.id.isEmpty) {
      return false;
    }
    return true;
  }
}

import 'package:cloud_firestore/cloud_firestore.dart';

enum FirebaseCollections {
  user,
  chat,
  post,
  ;

  CollectionReference get reference => FirebaseFirestore.instance.collection(name);
}

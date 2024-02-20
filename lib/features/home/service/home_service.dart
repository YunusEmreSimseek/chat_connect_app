import 'package:chat_connect_app/products/firebase/firebase_collections.dart';
import 'package:chat_connect_app/products/models/post_model.dart';

abstract class IHomeService {
  Future<List<PostModel>?> fetchPosts(List<String> postedUsersIds);
  Future<bool> addPost(String content, String signedInUserId);
}

final class HomeService extends IHomeService {
  @override
  Future<bool> addPost(String content, String signedInUserId) async {
    PostModel newPost = PostModel(
      userId: signedInUserId,
      content: content,
      postedAt: DateTime.now(),
    );
    await FirebaseCollections.post.reference.add(newPost.toJson());
    return true;
  }

  @override
  Future<List<PostModel>?> fetchPosts(List<String> postedUsersIds) async {
    final postCollectionReference = FirebaseCollections.post.reference;
    final response = await postCollectionReference
        .where("userId", whereIn: postedUsersIds)
        .withConverter(
          fromFirestore: (snapshot, options) => PostModel().fromFirebase(snapshot),
          toFirestore: (value, options) {
            return value.toJson();
          },
        )
        .get();
    if (response.docs.isEmpty) {
      return null;
    }
    if (response.docs.isNotEmpty) {
      final List<PostModel> posts = response.docs.map((e) => e.data()).toList();
      posts.sort((a, b) => b.postedAt!.compareTo(a.postedAt!));
      return posts;
    }
    return null;
  }
}

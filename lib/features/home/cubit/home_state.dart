part of 'home_cubit.dart';

@immutable
final class HomeState extends Equatable {
  final UserModel? loggedInUser;
  final List<UserModel>? postedUsers;
  final List<PostModel>? posts;
  const HomeState({this.postedUsers, this.posts, this.loggedInUser});

  HomeState copyWith({
    UserModel? loggedInUser,
    List<UserModel>? postedUsers,
    List<PostModel>? posts,
  }) {
    return HomeState(
      loggedInUser: loggedInUser ?? this.loggedInUser,
      postedUsers: postedUsers ?? this.postedUsers,
      posts: posts ?? this.posts,
    );
  }

  @override
  List<Object?> get props => [loggedInUser, postedUsers, posts];
}

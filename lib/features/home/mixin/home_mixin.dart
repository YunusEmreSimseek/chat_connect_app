part of '../view/home_view.dart';

mixin HomeMixin on State<HomeView>, BaseViewMixin<HomeView> {
  late final TextEditingController postController;
  Stream<QuerySnapshot>? stream;
  StreamSubscription? streamSubscription;

  @override
  void initState() {
    super.initState();
    initController();
    initAndListenStream();
  }

  @override
  void dispose() {
    super.dispose();
    disposeStream();
  }

  void initController() {
    postController = TextEditingController();
  }

  void initAndListenStream() {
    stream = FirebaseCollections.post.reference
        .where("userId", whereIn: context.read<HomeCubit>().state.postedUsers?.map((e) => e.id).toList())
        .snapshots();
    if (stream != null) {
      streamSubscription = stream!.listen((snapshot) async {
        safeOperation(() async => await context.read<HomeCubit>().fetchPosts());
      });
    }
  }

  void disposeStream() {
    if (streamSubscription != null) {
      streamSubscription!.cancel();
    }
  }

  void disposeController() {
    postController.dispose();
  }

  UserModel? getPostedUser(String userId) {
    final chattedUsers = context.read<HomeCubit>().state.postedUsers;
    if (chattedUsers == null) return null;
    final postedUser = chattedUsers.firstWhere((element) => element.id == userId);
    return postedUser;
  }

  void addPostOnPressed() {
    GeneralShowDialog.addPostDialog(
      context: context,
      controller: postController,
      onPressed: () => addPost(),
    );
  }

  Future<void> addPost() async {
    changeLoading();
    if (postController.text.isEmpty) return;
    final response = await context.read<HomeCubit>().addPost(postController.text);
    changeLoading();
    if (response) {
      postController.clear();
      directSafeOperarion(() {
        Navigator.pop(context);
        GeneralShowDialog.dialog(
            context: context,
            title: LocaleKeys.dialog_home_addPost_successful_title.tr(),
            subtitle: LocaleKeys.dialog_home_addPost_successful_content.tr());
      });
      return;
    }
    if (!response) {
      directSafeOperarion(() {
        GeneralShowDialog.dialog(
            context: context,
            title: LocaleKeys.dialog_home_addPost_unsuccessful_title.tr(),
            subtitle: LocaleKeys.dialog_home_addPost_unsuccessful_content.tr());
      });
    }
  }
}

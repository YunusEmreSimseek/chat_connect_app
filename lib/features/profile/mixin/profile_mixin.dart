part of '../view/profile_view.dart';

mixin ProfileMixin on State<ProfileView>, BaseViewMixin<ProfileView> {
  late final TextEditingController emailController;
  late final GlobalKey<FormState> formKey;
  late final TextEditingController nameController;
  late final TextEditingController passwordController;
  late final TextEditingController phoneNumberController;
  late final ScrollController scrollController;
  late final List<TextEditingController> controllers;

  @override
  void dispose() {
    super.dispose();
    disposeControllers();
  }

  @override
  void initState() {
    super.initState();
    initControllers();
    setControllersText();
    controllers = [
      nameController,
      phoneNumberController,
      emailController,
      passwordController,
    ];
  }

  void initControllers() {
    emailController = TextEditingController();
    passwordController = TextEditingController();
    phoneNumberController = TextEditingController();
    nameController = TextEditingController();
    scrollController = ScrollController();

    formKey = GlobalKey();
  }

  void setControllersText() {
    final user = context.read<SettingsCubit>().state.loggedInUser;
    if (user == null) return;

    emailController.text = user.email!;
    nameController.text = user.name!;
    phoneNumberController.text = user.phoneNo!;
    passwordController.text = user.password!;
  }

  void disposeControllers() {
    emailController.dispose();
    passwordController.dispose();
    phoneNumberController.dispose();
    scrollController.dispose();
    nameController.dispose();
  }

  void compareUserDetailsWithState() {
    final user = context.read<SettingsCubit>().state.loggedInUser;
    if (user == null) return;

    if (user.email != emailController.text ||
        user.name != nameController.text ||
        user.phoneNo != phoneNumberController.text ||
        user.password != passwordController.text) {
      context.read<SettingsCubit>().changeProfileChanged(true);
      return;
    }
    if (user.email == emailController.text &&
        user.name == nameController.text &&
        user.phoneNo == phoneNumberController.text &&
        user.password == passwordController.text) {
      context.read<SettingsCubit>().changeProfileChanged(false);
      return;
    }
  }

  Future<void> saveChanges() async {
    if (formKey.currentState!.validate()) {
      UserModel user = UserModel(
          email: emailController.text,
          name: nameController.text,
          password: passwordController.text,
          imageUrl: ImageEnum.defaultUserIcon.value,
          phoneNo: phoneNumberController.text,
          id: context.read<SettingsCubit>().state.loggedInUser!.id);
      changeLoading();
      safeOperation(() async => await context.read<SettingsCubit>().updateUser(user));
      safeOperation(() async => await context.read<BaseCubit>().fetchSignedInUserDetails());
      context.read<BaseCubit>().sendSignedInUserToStates(context);
      safeOperation(() async => await context.read<BaseCubit>().fetchChattedUsers());
      context.read<BaseCubit>().sendPostedUsersToHomeState(context);
      changeLoading();
      GeneralShowDialog.dialog(
          context: context,
          title: LocaleKeys.dialog_profile_changes_successful_title.tr(),
          subtitle: LocaleKeys.dialog_profile_changes_successful_content.tr());
    }
  }

  void scrollToBottomOnKeyboardOpen() {
    scrollController.animateTo(
      scrollController.position.maxScrollExtent,
      duration: const Duration(milliseconds: 100),
      curve: Curves.easeOut,
    );
  }

  Future<void> changeProfilePicture() async {
    final IPickManager pickManager = PickManager();
    final model = await pickManager.fetchMediaImage();
    if (model!.file != null) {
      final XFile image = model.file!;
      final File file = File(image.path);
      changeLoading();
      await uploadImage(file);
      changeLoading();
    }
  }

  Future<void> uploadImage(File file) async {
    final FirebaseStorage storage = FirebaseStorage.instance;
    //String fileName = Path.basename(file.path);
    final metadata = SettableMetadata(
      contentType: 'image/jpeg',
      // contentType: 'image/png',
      customMetadata: {'picked-file-path': file.path},
    );
    Reference storageReference =
        storage.ref().child('images/${context.read<SettingsCubit>().state.loggedInUser!.name}');
    UploadTask uploadTask = storageReference.putData(await file.readAsBytes(), metadata);
    //UploadTask uploadTask = storageReference.putFile(file);
    TaskSnapshot taskSnapshot = await uploadTask;
    String downloadUrl = await taskSnapshot.ref.getDownloadURL();
    await updateAndFetchUserImage(downloadUrl);
  }

  Future<void> updateAndFetchUserImage(String downloadUrl) async {
    safeOperation(() async => await context.read<SettingsCubit>().updateUserImage(downloadUrl));
    safeOperation(() async => await context.read<BaseCubit>().fetchSignedInUserDetails());
    context.read<BaseCubit>().sendSignedInUserToStates(context);
  }
}

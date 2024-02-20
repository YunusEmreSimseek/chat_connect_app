part of '../view/register_view.dart';

mixin RegisterMixin on State<RegisterView>, BaseViewMixin<RegisterView> {
  late final TextEditingController emailController;
  late final TextEditingController passwordController;
  late final TextEditingController passwordConfirmController;
  late final TextEditingController nameController;
  late final ScrollController scrollController;
  late final GlobalKey<FormState> formKey;

  @override
  void initState() {
    super.initState();
    initControllers();
  }

  @override
  void dispose() {
    super.dispose();
    disposeControllers();
  }

  void initControllers() {
    emailController = TextEditingController();
    passwordController = TextEditingController();
    passwordConfirmController = TextEditingController();
    nameController = TextEditingController();
    scrollController = ScrollController();
    formKey = GlobalKey();
  }

  void disposeControllers() {
    emailController.dispose();
    passwordController.dispose();
    passwordConfirmController.dispose();
    nameController.dispose();
    scrollController.dispose();
  }

  void navigateToLoginView() {
    context.route.navigateToPage(const LoginView());
  }

  Future<void> register() async {
    changeLoading();
    if (formKey.currentState!.validate() && passwordController.text == passwordConfirmController.text) {
      UserModel user = UserModel(
        email: emailController.text,
        name: nameController.text,
        password: passwordController.text,
        imageUrl: ImageEnum.defaultUserIcon.value,
        phoneNo: '',
      );
      //final response = await context.read<RegisterCubit>().registerUser(user);
      final response = await context.read<RegisterCubit>().signUp(user);
      if (response) {
        await safeOperation(() async {
          if (FirebaseAuth.instance.currentUser != null) {
            await context.read<RegisterCubit>().addIdIntoUser(FirebaseAuth.instance.currentUser!.email!);
          }
        });

        await safeOperation(() async {
          GeneralShowDialog.dialog(
              context: context,
              title: LocaleKeys.dialog_register_succes_title,
              subtitle: LocaleKeys.dialog_register_succes_content);
          Future.delayed(const Duration(seconds: 2), () => context.route.pop());
          Future.delayed(
              const Duration(seconds: 2, milliseconds: 500), () => context.route.navigateToPage(const BaseScaffold()));
        });
      }
    }
    changeLoading();
  }

  void scrollToBottomOnKeyboardOpen() {
    scrollController.animateTo(
      scrollController.position.maxScrollExtent,
      duration: const Duration(milliseconds: 100),
      curve: Curves.easeOut,
    );
  }
}

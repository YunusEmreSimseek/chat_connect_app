part of '../view/login_view.dart';

mixin LoginMixin on State<LoginView>, BaseViewMixin<LoginView> {
  late final TextEditingController emailController;
  late final TextEditingController passwordController;
  late final ScrollController scrollController;
  late final GlobalKey<FormState> formKey;
  final User? user = FirebaseAuth.instance.currentUser;

  @override
  void initState() {
    super.initState();
    Future.microtask(() => chechUser());
    initControllers();
  }

  @override
  void dispose() {
    disposeControllers();
    super.dispose();
  }

  Future<void> chechUser() async {
    changeLoading();
    final response = context.read<LoginCubit>().isLoggedIn(FirebaseAuth.instance.currentUser);
    if (response) {
      await setInformationsToStates();
      changeLoading();
      navigateToChatView();
      return;
    }
    changeLoading();
  }

  void initControllers() {
    emailController = TextEditingController();
    passwordController = TextEditingController();
    scrollController = ScrollController();
    formKey = GlobalKey();
  }

  void disposeControllers() {
    emailController.dispose();
    passwordController.dispose();
    scrollController.dispose();
  }

  void navigateToRegisterView() {
    context.route.navigateToPage(const RegisterView());
  }

  void navigateToChatView() {
    context.route.navigateToPage(const BaseScaffold());
  }

  Future<void> login() async {
    changeLoading();
    final response = await context.read<LoginCubit>().signIn(emailController.text, passwordController.text);
    if (response) {
      changeLoading();
      navigateToChatView();
      return;
    }
    if (!response) {
      changeLoading();
      safeOperation(() => GeneralShowDialog.dialog(
          context: context,
          title: LocaleKeys.dialog_login_unsuccessful_title.tr(),
          subtitle: LocaleKeys.dialog_login_unsuccessful_content.tr()));
    }
  }

  void scrollToBottomOnKeyboardOpen() {
    scrollController.animateTo(
      scrollController.position.maxScrollExtent,
      duration: const Duration(milliseconds: 100),
      curve: Curves.easeOut,
    );
  }

  Future<void> setInformationsToStates() async {
    await context.read<BaseCubit>().initialize(FirebaseAuth.instance.currentUser!.email!, context);
    safeOperation(() async {
      context.read<BaseCubit>().sendSignedInUserToStates(context);
      context.read<BaseCubit>().sendChatsToStates(context);
      context.read<BaseCubit>().sendChattedUsersToChatState(context);
      context.read<BaseCubit>().sendPostedUsersToHomeState(context);
    });
  }
}

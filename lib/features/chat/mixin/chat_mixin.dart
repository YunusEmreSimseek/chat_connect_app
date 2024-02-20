part of '../view/chat_view.dart';

mixin ChatMixin on State<ChatView>, BaseViewMixin<ChatView> {
  Stream<QuerySnapshot>? stream;
  late final TextEditingController phoneNumberController;
  StreamSubscription? streamSubscription;

  @override
  void initState() {
    super.initState();
    initAndListenStream();
    initController();
  }

  @override
  void dispose() {
    super.dispose();
    disposeController();
    disposeStreams();
  }

  void initAndListenStream() {
    if (!mounted) return;
    if (context.read<ChatCubit>().state.loggedInUser != null) {
      stream = FirebaseCollections.chat.reference
          .where("users", arrayContains: context.read<ChatCubit>().state.loggedInUser!.id)
          .snapshots();
    }
    if (stream != null) {
      streamSubscription = stream!.listen((snapshot) async {
        await context.read<BaseCubit>().fetchChats();
        safeOperation(() async {
          context.read<BaseCubit>().sendChatsToStates(context);
          await context.read<BaseCubit>().fetchChattedUsers();
        });
        safeOperation(() async {
          context.read<BaseCubit>().sendChattedUsersToChatState(context);
          context.read<BaseCubit>().sendPostedUsersToHomeState(context);
        });
      });
    }
  }

  void initController() {
    phoneNumberController = TextEditingController();
  }

  void disposeController() {
    phoneNumberController.dispose();
  }

  void disposeStreams() {
    if (streamSubscription != null) {
      streamSubscription!.cancel();
    }
  }

  void addChat() {
    Future<void> onPressed({required TextEditingController controller}) async {
      if (controller.text.length == 10) {
        changeLoading();
        final response = await context.read<ChatCubit>().addChat(controller.text);
        changeLoading();
        if (response) {
          phoneNumberController.clear();
          safeOperation(() async {
            Navigator.pop(context);

            GeneralShowDialog.dialog(
                context: context,
                title: LocaleKeys.dialog_chat_adding_successful_title.tr(),
                subtitle: LocaleKeys.dialog_chat_adding_successful_content.tr());
          });
          return;
        }
        if (!response) {
          safeOperation(() async {
            GeneralShowDialog.dialog(
                context: context,
                title: LocaleKeys.dialog_chat_adding_unsuccessful_title.tr(),
                subtitle: LocaleKeys.dialog_chat_adding_unsuccessful_content.tr());
          });
        }
      }
    }

    GeneralShowDialog.addChatDialog(
        context: context,
        controller: phoneNumberController,
        onPressed: () => onPressed(controller: phoneNumberController));
  }
}

part of '../view/chat_detail_view.dart';

mixin ChatDetailMixin on State<ChatDetailView>, BaseViewMixin<ChatDetailView> {
  Stream<DocumentSnapshot>? stream;
  late final TextEditingController controller;
  late final ScrollController scrollController;
  StreamSubscription? streamSubscription;

  @override
  void initState() {
    super.initState();
    initControllers();
    initMessages();
    initAndListenStream();
  }

  @override
  void dispose() {
    super.dispose();
    disposeControllers();
    disposeStream();
  }

  void initAndListenStream() {
    stream = FirebaseCollections.chat.reference.doc(context.read<ChatDetailCubit>().state.currentChat!.id).snapshots();
    if (stream != null) {
      streamSubscription = stream!.listen((event) async {
        if (event.exists) {
          await context.read<BaseCubit>().fetchChats();

          directSafeOperarion(() => context.read<BaseCubit>().sendChatsToStates(context));

          safeOperation(() async => await context.read<ChatDetailCubit>().getMessages(context));
        }
      });
    }
  }

  void initControllers() {
    controller = TextEditingController();
    scrollController = ScrollController();
  }

  void disposeControllers() {
    controller.dispose();
    scrollController.dispose();
  }

  void disposeStream() {
    if (streamSubscription != null) {
      streamSubscription!.cancel();
    }
  }

  Future<void> initMessages() async {
    changeLoading();
    await context.read<ChatDetailCubit>().getMessages(context);
    if (!mounted) return;
    changeLoading();
  }

  void scrollToBottomOnKeyboardOpen(ScrollController controller) {
    controller.animateTo(
      0.0,
      duration: const Duration(milliseconds: 100),
      curve: Curves.easeOut,
    );
  }
}

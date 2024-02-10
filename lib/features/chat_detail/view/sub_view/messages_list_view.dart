part of '../chat_detail_view.dart';

class MessagesListView extends StatelessWidget {
  const MessagesListView({
    super.key,
    required this.scrollController,
    required this.func,
  });
  final ScrollController scrollController;
  final Function(ScrollController controller) func;
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ChatDetailCubit, ChatDetailState>(
      builder: (context, state) {
        final isKeyboardOpen = context.general.isKeyBoardOpen;
        final keyboardHeight = context.general.keyboardPadding;
        if (isKeyboardOpen) {
          func(scrollController);
        }

        return SizedBox(
          height: context.sized.dynamicHeight(isKeyboardOpen ? .76 - (keyboardHeight / 940) : .76),
          child: ListView.builder(
            controller: scrollController,
            reverse: true,
            itemCount: state.messages?.length ?? 0,
            itemBuilder: (BuildContext context, int index) {
              final currentIndex = state.messages![index];
              return Padding(
                padding: context.padding.onlyBottomNormal,
                child: currentIndex!.fromId == state.loggedInUser!.id
                    ? MessageContainer(currentIndex: currentIndex)
                    : MessageContainer(currentIndex: currentIndex, isMainMessageContainer: false),
              );
            },
          ),
        );
      },
    );
  }
}

class MessageContainer extends StatelessWidget {
  const MessageContainer({super.key, required this.currentIndex, this.isMainMessageContainer = true});
  final MessageModel currentIndex;
  final bool isMainMessageContainer;
  @override
  Widget build(BuildContext context) {
    return Container(
        padding: context.padding.onlyBottomLow,
        margin: isMainMessageContainer ? context.padding.onlyLeftHigh : context.padding.onlyRightHigh,
        decoration: BoxDecoration(
            borderRadius: context.border.normalBorderRadius,
            color: isMainMessageContainer
                ? ProjectColors.instance.chatDetailMainMessageColor
                : ProjectColors.instance.chatDetailOtherMessageColor),
        child: Stack(
          children: [
            Padding(
              padding: context.padding.normal,
              child: SizedBox(
                width: context.sized.dynamicWidth(.63),
                child: CustomText(
                  currentIndex.content!,
                  textAlign: TextAlign.start,
                  size: FontSizeEnum.lowMid,
                ),
              ),
            ),
            Positioned(
                bottom: 0,
                right: context.sized.dynamicWidth(.05),
                child: CustomText(
                  '${currentIndex.time!.hour.convertToTimeWithZero}:${currentIndex.time!.minute.convertToTimeWithZero}',
                  size: FontSizeEnum.low,
                ))
          ],
        ));
  }
}

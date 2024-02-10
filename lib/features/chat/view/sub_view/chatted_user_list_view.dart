part of '../chat_view.dart';

class ChattedUserListView extends StatelessWidget {
  const ChattedUserListView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ChatCubit, ChatState>(
      builder: (context, state) {
        return SizedBox(
          height: context.sized.dynamicHeight(.73),
          child: ListView.builder(
            itemCount: state.chattedUsers?.length ?? 0,
            itemBuilder: (BuildContext context, int index) {
              return state.chattedUsers!.isEmpty
                  ? const SizedBox.shrink()
                  : Padding(
                      padding: context.padding.onlyBottomNormal,
                      child: SizedBox(
                          // height: context.sized.dynamicHeight(.13),
                          height: context.sized.dynamicHeight(.1),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              ChattedUserImageButton(index: index),
                              context.sized.emptySizedWidthBoxNormal,
                              ChattedUserTextsButton(
                                index: index,
                              )
                            ],
                          )),
                    );
            },
          ),
        );
      },
    );
  }
}

class ChattedUserImageButton extends StatelessWidget {
  const ChattedUserImageButton({
    super.key,
    required this.index,
  });
  final int index;
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ChatCubit, ChatState>(
      builder: (context, state) {
        return InkWell(
          onTap: () {
            showDialog(
                context: context,
                builder: (context) => AlertDialog(
                      content: Image.network(
                        state.chattedUsers?[index].imageUrl ?? '',
                        filterQuality: FilterQuality.high,
                        fit: BoxFit.contain,
                        height: context.sized.dynamicHeight(.3),
                        alignment: Alignment.center,
                      ),
                    ));
          },
          child: UserImage(
            imageUrl: state.chattedUsers?[index].imageUrl ?? '',
            width: .175,
            height: .08,
            fit: BoxFit.cover,
          ),
        );
      },
    );
  }
}

class ChattedUserTextsButton extends StatelessWidget {
  const ChattedUserTextsButton({
    super.key,
    required this.index,
  });
  final int index;
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ChatCubit, ChatState>(
      builder: (context, state) {
        return InkWell(
          onTap: () {
            context.read<ChatDetailCubit>().updateChattingUserMessagesAndChat(
                chattingUser: state.chattedUsers![index], currentChat: state.chats![index]);

            context.route.navigateToPage(const ChatDetailView());
          },
          child: Row(
            children: [
              SizedBox(
                width: context.sized.dynamicWidth(.5),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    context.sized.emptySizedHeightBoxLow,
                    CustomText(
                      state.chattedUsers![index].name!,
                      //size: FontSizeEnum.medium,
                      size: FontSizeEnum.lowMid,
                      isBold: true,
                    ),
                    context.sized.emptySizedHeightBoxLow,
                    state.chats?[index].chats?.isEmpty ?? true
                        ? const SizedBox.shrink()
                        : Text(
                            state.chats![index].chats?.last!.content! ?? '',
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            //style: TextStyle(fontSize: FontSizeEnum.lowMid.value),
                            style: TextStyle(fontSize: FontSizeEnum.lowMid.value),
                          ),
                  ],
                ),
              ),
              context.sized.emptySizedWidthBoxLow3x,
              Container(
                margin: EdgeInsets.only(top: context.sized.dynamicHeight(.0375)),
                width: context.sized.dynamicWidth(.1),
                child: state.chats?[index].chats?.isEmpty ?? true
                    ? const SizedBox.shrink()
                    : CustomText(
                        '${state.chats![index].lastTime!.hour.convertToTimeWithZero} : ${state.chats![index].lastTime!.minute.convertToTimeWithZero}',
                        size: FontSizeEnum.low,
                      ),
              )
            ],
          ),
        );
      },
    );
  }
}

part of '../chat_detail_view.dart';

class AppBarTitle extends StatelessWidget {
  const AppBarTitle({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ChatDetailCubit, ChatDetailState>(
      builder: (context, state) {
        return Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.all(context.border.normalRadius),
                child: UserImage(
                  imageUrl: state.chattingUser!.imageUrl!,
                  fit: BoxFit.cover,
                ),
              ),
              context.sized.emptySizedWidthBoxLow3x,
              Padding(
                padding: context.padding.onlyTopLow,
                child: CustomText(
                  state.chattingUser!.name!,
                  isBold: true,
                ),
              ),
            ]);
      },
    );
  }
}

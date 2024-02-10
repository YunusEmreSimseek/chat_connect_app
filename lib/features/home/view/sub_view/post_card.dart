part of '../home_view.dart';

class _PostCard extends StatelessWidget {
  const _PostCard({
    required this.postedUser,
    required this.currentPost,
  });

  final UserModel? postedUser;
  final PostModel? currentPost;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: context.padding.low,
        child: Stack(children: [
          Positioned(
            left: context.sized.dynamicWidth(.04),
            child: Row(
              children: [
                UserImage(
                  imageUrl: postedUser?.imageUrl ?? ImageEnum.defaultUserIcon.toPng,
                  height: .05,
                  width: .1,
                  fit: BoxFit.cover,
                ),
                context.sized.emptySizedWidthBoxLow3x,
                CustomText(
                  '${postedUser?.name}',
                  size: FontSizeEnum.medium,
                  isBold: true,
                ),
              ],
            ),
          ),
          Container(
              margin: EdgeInsets.only(
                  top: context.sized.dynamicHeight(0.06),
                  left: context.sized.dynamicWidth(0.175),
                  bottom: context.sized.dynamicHeight(0.015)),
              width: context.sized.dynamicWidth(.6),
              child: CustomText(
                '${currentPost?.content}',
                textAlign: TextAlign.start,
                size: FontSizeEnum.lowMid,
              )),
          Positioned(
              bottom: 0,
              right: 0,
              child: CustomText(
                '${currentPost?.postedAt?.hour.convertToTimeWithZero} : ${currentPost?.postedAt?.minute.convertToTimeWithZero}',
                size: FontSizeEnum.low,
              )),
        ]),
      ),
    );
  }
}

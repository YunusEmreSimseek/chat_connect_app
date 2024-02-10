part of '../chat_detail_view.dart';

class AnimatedBottomNavigationBar extends StatelessWidget {
  const AnimatedBottomNavigationBar({
    super.key,
    required this.controller,
  });
  final TextEditingController controller;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
          bottom: context.general.isKeyBoardOpen
              ? context.sized
                  .dynamicHeight(MediaQuery.of(context).viewInsets.bottom / MediaQuery.of(context).size.height)
              : 0),
      color: ProjectColors.instance.bottomNavigationBarColor,
      height: context.sized.dynamicHeight(.08),
      width: double.infinity,
      child: Stack(children: [
        Positioned(
            left: context.sized.dynamicWidth(.05),
            top: context.sized.dynamicHeight(.01),
            child: IconButton(
                onPressed: () {},
                icon: Icon(
                  Icons.add,
                  size: IconSizeEnum.mid.value,
                ))),
        Positioned(
          left: context.sized.dynamicWidth(.2),
          top: context.sized.dynamicHeight(.01),
          child: SizedBox(
              height: context.sized.dynamicHeight(.05),
              width: context.sized.dynamicWidth(.6),
              child: TextField(
                enableSuggestions: true,
                keyboardType: TextInputType.text,
                autocorrect: false,
                controller: controller,
              )),
        ),
        Positioned(
            right: context.sized.dynamicWidth(.05),
            top: context.sized.dynamicHeight(.01),
            child: IconButton(
                onPressed: () async {
                  await context.read<ChatDetailCubit>().sendMessage(controller.text);
                  controller.clear();
                },
                icon: const Icon(
                  Icons.send_rounded,
                )))
      ]),
    );
  }
}

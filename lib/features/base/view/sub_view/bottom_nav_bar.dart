part of '../base_scaffold.dart';

class BottomNavBar extends StatefulWidget {
  const BottomNavBar({super.key});

  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  void rebuild() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    List<BottomNavigationBarItem> items = [
      BottomNavigationBarItem(
          icon: Icon(
            CupertinoIcons.home,
            size: IconSizeEnum.mid.value,
          ),
          label: LocaleKeys.general_page_home.tr()),
      BottomNavigationBarItem(
          icon: Icon(
            CupertinoIcons.chat_bubble_text,
            size: IconSizeEnum.mid.value,
          ),
          label: LocaleKeys.general_page_chats.tr()),
      BottomNavigationBarItem(
          icon: Icon(
            CupertinoIcons.settings,
            size: IconSizeEnum.mid.value,
          ),
          label: LocaleKeys.general_page_settings.tr()),
    ];
    return BlocConsumer<BaseCubit, BaseState>(
      listener: (context, state) {},
      builder: (context, state) {
        if (state.isLocalUpdated) {
          context.read<BaseCubit>().updateLocalUpdated();
          Future.microtask(() => rebuild());
        }
        return BottomNavigationBar(
            items: items,
            currentIndex: state.currentIndex,
            onTap: (value) {
              return context.read<BaseCubit>().changeCurrentIndex(value);
            });
      },
    );
  }
}

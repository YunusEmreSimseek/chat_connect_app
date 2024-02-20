import 'package:chat_connect_app/features/base/cubit/base_cubit.dart';
import 'package:chat_connect_app/features/chat/view/chat_view.dart';
import 'package:chat_connect_app/features/home/view/home_view.dart';
import 'package:chat_connect_app/features/settings/view/settings_view.dart';
import 'package:chat_connect_app/products/index.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part '../mixin/base_mixin.dart';
part 'sub_view/bottom_nav_bar.dart';

class BaseScaffold extends StatefulWidget {
  const BaseScaffold({super.key});

  @override
  State<BaseScaffold> createState() => _BaseScaffoldState();
}

class _BaseScaffoldState extends State<BaseScaffold> with BaseMixin {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BaseCubit, BaseState>(
      builder: (context, state) {
        return Scaffold(
          bottomNavigationBar: const BottomNavBar(),
          body: changeBodyPage(state.currentIndex),
        );
      },
    );
  }
}

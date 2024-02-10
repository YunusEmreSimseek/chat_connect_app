import 'package:chat_connect_app/features/base/cubit/base_cubit.dart';
import 'package:chat_connect_app/product/enums/icon_size_enum.dart';
import 'package:chat_connect_app/product/init/language/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'sub_view/bottom_nav_bar.dart';

class BaseScaffold extends StatefulWidget {
  const BaseScaffold({super.key});

  @override
  State<BaseScaffold> createState() => _BaseScaffoldState();
}

class _BaseScaffoldState extends State<BaseScaffold> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BaseCubit, BaseState>(
      builder: (context, state) {
        final Widget page = context.read<BaseCubit>().decisionBody();
        return Scaffold(
          bottomNavigationBar: const BottomNavBar(),
          body: page,
        );
      },
    );
  }
}

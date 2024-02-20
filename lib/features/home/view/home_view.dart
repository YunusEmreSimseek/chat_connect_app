import 'dart:async';

import 'package:chat_connect_app/features/home/cubit/home_cubit.dart';
import 'package:chat_connect_app/products/index.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kartal/kartal.dart';

part '../mixin/home_mixin.dart';
part 'sub_view/post_card.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> with BaseViewMixin, HomeMixin {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeState>(
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            leading: const SizedBox.shrink(),
            title: const AppBarTitleText(LocaleKeys.general_page_home),
            actions: [LoadingOrButtonWidget(onPressed: addPostOnPressed)],
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: context.padding.normal,
              child: Center(
                  child: Column(children: [
                SizedBox(
                  height: context.sized.dynamicHeight(.73),
                  child: ListView.builder(
                    reverse: true,
                    itemCount: state.posts?.length ?? 0,
                    itemBuilder: (BuildContext context, int index) {
                      final postedUser = getPostedUser(state.posts?[index].userId ?? '');
                      final currentPost = state.posts?[index];
                      return _PostCard(postedUser: postedUser, currentPost: currentPost);
                    },
                  ),
                ),
              ])),
            ),
          ),
        );
      },
    );
  }
}

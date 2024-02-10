import 'package:chat_connect_app/features/home/cubit/home_cubit.dart';
import 'package:chat_connect_app/features/home/mixin/home_mixin.dart';
import 'package:chat_connect_app/product/enums/font_size_enum.dart';
import 'package:chat_connect_app/product/enums/image_enum.dart';
import 'package:chat_connect_app/product/init/language/locale_keys.g.dart';
import 'package:chat_connect_app/product/models/post_model.dart';
import 'package:chat_connect_app/product/models/user_model.dart';
import 'package:chat_connect_app/product/utility/extensions/datetime_extension.dart';
import 'package:chat_connect_app/product/widgets/images/user_image.dart';
import 'package:chat_connect_app/product/widgets/loadings/loading_or_button_widget.dart';
import 'package:chat_connect_app/product/widgets/text/appbar_title_text.dart';
import 'package:chat_connect_app/product/widgets/text/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kartal/kartal.dart';

part 'sub_view/post_card.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> with HomeMixin {
  @override
  void initState() {
    super.initState();
    initController();
    initAndListenStream();
  }

  @override
  void dispose() {
    super.dispose();
    disposeStream();
  }

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

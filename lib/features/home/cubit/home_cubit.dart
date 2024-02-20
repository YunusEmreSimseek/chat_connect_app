import 'package:chat_connect_app/features/home/service/home_service.dart';
import 'package:chat_connect_app/products/models/post_model.dart';
import 'package:chat_connect_app/products/models/user_model.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'home_state.dart';

final class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(const HomeState());

  final IHomeService _homeService = HomeService();

  Future<void> fetchPosts() async {
    final postedUsersIds = getPostedUsersIds();
    if (postedUsersIds?.isEmpty ?? true) return;
    final posts = await _homeService.fetchPosts(postedUsersIds!);
    if (posts?.isEmpty ?? true) return;
    emit(state.copyWith(posts: posts));
  }

  Future<bool> addPost(String content) async {
    final response = await _homeService.addPost(content, state.loggedInUser!.id!);
    return response;
  }

  List<String>? getPostedUsersIds() {
    if (state.postedUsers?.isEmpty ?? true) return null;
    List<String> postedUsersIds = [];
    for (var user in state.postedUsers!) {
      postedUsersIds.add(user.id!);
    }
    return postedUsersIds;
  }

  void dispose() {
    emit(const HomeState());
  }
}

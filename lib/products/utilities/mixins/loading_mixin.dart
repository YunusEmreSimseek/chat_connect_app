import 'package:chat_connect_app/products/states/loading/loading_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

mixin LoadingMixin<T extends StatefulWidget> on State<T> {
  bool get isLoading => context.read<LoadingCubit>().state.isLoading;

  void changeLoading() => context.read<LoadingCubit>().changeLoading();
}

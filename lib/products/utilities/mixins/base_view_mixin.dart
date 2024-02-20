import 'package:chat_connect_app/products/states/loading/loading_cubit.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

mixin BaseViewMixin<T extends StatefulWidget> on State<T> {
  bool get isLoading => context.read<LoadingCubit>().state.isLoading;

  void changeLoading() => context.read<LoadingCubit>().changeLoading();

  Future<void> safeOperation(AsyncCallback callback) async {
    if (!mounted) return;
    await callback.call();
  }

  void directSafeOperarion(VoidCallback callback) {
    if (!mounted) return;
    callback.call();
  }
}

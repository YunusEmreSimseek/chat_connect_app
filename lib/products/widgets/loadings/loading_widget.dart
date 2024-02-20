import 'package:chat_connect_app/products/states/loading/loading_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoadingWidget extends StatelessWidget {
  const LoadingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: BlocSelector<LoadingCubit, LoadingState, bool>(
        selector: (state) {
          return state.isLoading;
        },
        builder: (context, state) {
          if (!state) {
            return const SizedBox.shrink();
          }
          return const CircularProgressIndicator();
        },
      ),
    );
  }
}

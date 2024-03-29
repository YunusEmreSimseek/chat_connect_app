import 'package:chat_connect_app/products/enums/icon_size_enum.dart';
import 'package:chat_connect_app/products/states/loading/loading_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoadingOrButtonWidget extends StatelessWidget {
  const LoadingOrButtonWidget({super.key, required this.onPressed});
  final void Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: BlocSelector<LoadingCubit, LoadingState, bool>(
        selector: (state) {
          return state.isLoading;
        },
        builder: (context, state) {
          if (!state) {
            return IconButton(
                onPressed: () => onPressed(),
                icon: Icon(
                  Icons.add_circle_rounded,
                  size: IconSizeEnum.mid.value,
                ));
          }
          return const CircularProgressIndicator();
        },
      ),
    );
  }
}

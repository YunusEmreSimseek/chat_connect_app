import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'loading_state.dart';

class LoadingCubit extends Cubit<LoadingState> {
  LoadingCubit() : super(const LoadingState());

  void changeLoading() {
    emit(state.copyWith(isLoading: !state.isLoading));
  }

  void dispose() {
    emit(const LoadingState());
  }
}

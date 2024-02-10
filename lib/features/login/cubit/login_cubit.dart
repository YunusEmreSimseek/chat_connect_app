import 'package:chat_connect_app/features/login/service/login_service.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'login_state.dart';

final class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(const LoginState());

  final ILoginService _loginService = LoginService();

  void changeObscureText(bool value) {
    emit(state.copyWith(obscureText: value));
  }

  bool isLoggedIn(User? user) {
    final response = _loginService.isLoggedIn(user);
    return response;
  }

  Future<bool> signIn(String email, String password) async {
    changeLoading();
    final response = await _loginService.signIn(email, password);
    changeLoading();
    return response;
  }

  void changeLoading() {
    emit(state.copyWith(isLoading: !state.isLoading));
  }

  void dispose() {
    emit(const LoginState());
  }
}

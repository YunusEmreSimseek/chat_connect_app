import 'package:chat_connect_app/features/register/service/register_service.dart';
import 'package:chat_connect_app/product/models/user_model.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'register_state.dart';

class RegisterCubit extends Cubit<RegisterState> {
  RegisterCubit() : super(const RegisterState());

  final IRegisterService _registerService = RegisterService();

  Future<bool> signUp(UserModel user) async {
    changeLoading();
    final response = await _registerService.signUp(user);
    changeLoading();
    return response;
  }

  Future<void> addIdIntoUser(String email) async {
    changeLoading();
    await _registerService.addIdIntoUser(email);
    changeLoading();
  }

  void changeObscureText() {
    emit(state.copyWith(obscureText: !state.obscureText));
  }

  void changeLoading() {
    emit(state.copyWith(isLoading: !state.isLoading));
  }

  void dispose() {
    emit(const RegisterState());
  }
}

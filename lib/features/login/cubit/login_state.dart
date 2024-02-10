part of 'login_cubit.dart';

@immutable
final class LoginState extends Equatable {
  const LoginState({
    this.obscureText = true,
    this.isLoading = false,
  });

  final bool obscureText;
  final bool isLoading;

  LoginState copyWith({
    bool? obscureText,
    bool? isLoading,
  }) {
    return LoginState(
      obscureText: obscureText ?? this.obscureText,
      isLoading: isLoading ?? this.isLoading,
    );
  }

  @override
  List<Object?> get props => [obscureText, isLoading];
}

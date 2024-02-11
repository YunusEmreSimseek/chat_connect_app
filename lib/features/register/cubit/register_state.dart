part of 'register_cubit.dart';

@immutable
final class RegisterState extends Equatable {
  final bool obscureText;
  final bool isLoading;
  final bool isRedirect;

  const RegisterState({this.obscureText = true, this.isLoading = false, this.isRedirect = false});

  RegisterState copyWith({
    bool? obscureText,
    bool? isLoading,
    bool? isRedirect,
  }) {
    return RegisterState(
        obscureText: obscureText ?? this.obscureText,
        isLoading: isLoading ?? this.isLoading,
        isRedirect: isRedirect ?? this.isRedirect);
  }

  @override
  List<Object> get props => [obscureText, isLoading, isRedirect];
}

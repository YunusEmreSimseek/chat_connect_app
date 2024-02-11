part of 'settings_cubit.dart';

@immutable
final class SettingsState extends Equatable {
  final UserModel? loggedInUser;
  final bool isProfileChanged;

  const SettingsState({
    this.loggedInUser,
    this.isProfileChanged = false,
  });

  SettingsState copyWith({
    UserModel? loggedInUser,
    bool? isProfileChanged,
  }) {
    return SettingsState(
      loggedInUser: loggedInUser ?? this.loggedInUser,
      isProfileChanged: isProfileChanged ?? this.isProfileChanged,
    );
  }

  @override
  List<Object?> get props => [loggedInUser, isProfileChanged];
}

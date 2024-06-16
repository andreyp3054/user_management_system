part of 'user_bloc.dart';

enum UserStatus {
  initial,
  loading,
  loaded,
  error,
}

@freezed
class UserState with _$UserState {
  const factory UserState({
    @Default(UserStatus.initial) UserStatus status,
    @Default([]) List<User> users,
    User? currentUser,
    int? id,
    String? errorMessage,
  }) = _UserState;
}

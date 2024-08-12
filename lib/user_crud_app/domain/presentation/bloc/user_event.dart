part of 'user_bloc.dart';

@freezed
class UserEvent with _$UserEvent {
  const factory UserEvent.addUser(User user) = _AddUser;

  const factory UserEvent.deleteUser(int id) = _DeleteUser;

  const factory UserEvent.updateUser(User user) = _UpdateUser;

  const factory UserEvent.getUsers() = _GetUsers;
}

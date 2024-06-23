import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:user_crud/user_crud_app/core/usecases/usecase.dart';

import '../../../core/error/failures.dart';
import '../../../core/result/result.dart';
import '../../entities/user.dart';
import '../../usecases/add_user.dart';
import '../../usecases/delete_user.dart';
import '../../usecases/get_users.dart';
import '../../usecases/update_user.dart';

part 'user_event.dart';

part 'user_state.dart';

part 'user_bloc.freezed.dart';

@injectable
class UserBloc extends Bloc<UserEvent, UserState> {
  final AddUser addUser;
  final DeleteUser deleteUser;
  final UpdateUser updateUser;
  final GetUsers getUsers;

  UserBloc({
    required AddUser add,
    required DeleteUser delete,
    required GetUsers get,
    required UpdateUser update,
  })  : addUser = add,
        deleteUser = delete,
        getUsers = get,
        updateUser = update,
        super(const UserState()) {
    on<UserEvent>((event, emit) async {
      switch (event) {
        case _AddUser():
          await _add(event, emit);
          break;
        case _DeleteUser():
          await _deleteUser(event, emit);
          break;
        case _GetUsers():
          await _get(event, emit);
          break;
        case _UpdateUser():
          await _update(event, emit);
      }
    });
  }

  Future<void> _add(_AddUser event, Emitter<UserState> emit) async {
    try {
      emit(state.copyWith(
        status: UserStatus.loading,
      ));

      final result = await addUser.call(AddUserParams(user: event.user));

      switch (result) {
        case ResultSuccess<User, Failure>():
          final currentList = state.users.toList();
          currentList.add(result.value);

          emit(state.copyWith(
            status: UserStatus.loaded,
            users: currentList,
          ));
          break;
        case ResultError<User, Failure>(:final failure):
          emit(state.copyWith(
            status: UserStatus.error,
            errorMessage: 'Failed to add user: {$failure}',
          ));
      }
    } catch (error) {
      emit(state.copyWith(
        status: UserStatus.error,
        errorMessage: 'Failed to add user: $error',
      ));
    }
  }

  Future<void> _deleteUser(_DeleteUser event, Emitter<UserState> emit) async {
    try {
      emit(state.copyWith(
        status: UserStatus.loading,
      ));

      final result = await deleteUser.call(DeleteUserParams(id: event.id));

      switch (result) {
        case ResultSuccess<void, Failure>():
          final currentList = state.users.toList();
          currentList.removeWhere((user) => user.id == event.id);

          emit(state.copyWith(
            status: UserStatus.loaded,
            users: currentList,
          ));
          break;
        case ResultError<void, Failure>(:final failure):
          emit(state.copyWith(
            status: UserStatus.error,
            errorMessage: 'Failed to delete user: {$failure}',
          ));
      }
    } catch (error) {
      emit(state.copyWith(
        status: UserStatus.error,
        errorMessage: 'Failed to delete user: $error',
      ));
    }
  }

  Future<void> _get(_GetUsers event, Emitter<UserState> emit) async {
    try {
      emit(state.copyWith(status: UserStatus.loading));

      final result = await getUsers.call(const NoParams());

      switch (result) {
        case ResultSuccess<List<User>, Failure>():
          final currentList = state.users.toList();
          emit(
            state.copyWith(
              status: UserStatus.loaded,
              users: currentList,
            ),
          );

        case ResultError<List<User>, Failure>(:final failure):
          emit(
            state.copyWith(
                status: UserStatus.error,
                errorMessage: "Failed to get users: $failure"),
          );
      }
    } catch (error) {
      emit(
        state.copyWith(
            status: UserStatus.error,
            errorMessage: "Failed to get users: $error"),
      );
    }
  }

  Future<void> _update(_UpdateUser event, Emitter<UserState> emit) async {
    try {
      emit(state.copyWith(status: UserStatus.loading));

      final result = await updateUser
          .call(UpdateUserParams(user: event.user))
          .then((value) => Result(event.user));

      switch (result) {
        case ResultSuccess<void, Failure>():
          final originalIndex =
              state.users.indexWhere((element) => element.id == event.user.id);
          final currentList = state.users.toList();

          currentList.removeAt(originalIndex);
          currentList.insert(originalIndex, event.user);
          emit(
            state.copyWith(
              status: UserStatus.loaded,
              users: currentList,
            ),
          );

        case ResultError<void, Failure>(:final failure):
          emit(
            state.copyWith(
                status: UserStatus.error,
                errorMessage: "Failed to get users: $failure"),
          );
      }
    } catch (error) {
      emit(
        state.copyWith(
            status: UserStatus.error,
            errorMessage: "Failed to get users: $error"),
      );
    }
  }
}

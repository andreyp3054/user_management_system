import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

import '../../../core/error/failures.dart';
import '../../../core/result/result.dart';
import '../../entities/user.dart';
import '../../usecases/add_user.dart';

part 'user_event.dart';

part 'user_state.dart';

part 'user_bloc.freezed.dart';

@injectable
class UserBloc extends Bloc<UserEvent, UserState> {
  final AddUser addUser;

  UserBloc({
    required AddUser add,
  })  : addUser = add,
        super(const UserState()) {
    on<UserEvent>((event, emit) async {
      switch (event) {
        case _AddUser():
          await _add(event, emit);
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
}

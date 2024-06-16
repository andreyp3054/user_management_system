import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:user_crud/user_crud_app/core/error/failures.dart';
import 'package:user_crud/user_crud_app/core/result/result.dart';
import 'package:user_crud/user_crud_app/core/usecases/usecase.dart';
import 'package:user_crud/user_crud_app/domain/repositories/user_repository.dart';
import 'package:injectable/injectable.dart';

import '../entities/user.dart';

part 'add_user.freezed.dart';

@injectable
class AddUser implements UseCase<User, AddUserParams> {
  final UserRepository repository;

  AddUser(this.repository);

  @override
  Future<Result<User, Failure>> call(params) async {
    return await repository.addUser(params.user);
  }
}

@freezed
class AddUserParams with _$AddUserParams {
  const factory AddUserParams({
    required User user,
  }) = _AddUserParams;
}

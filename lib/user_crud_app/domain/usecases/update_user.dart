import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:user_crud/user_crud_app/core/error/failures.dart';
import 'package:user_crud/user_crud_app/core/result/result.dart';
import 'package:user_crud/user_crud_app/core/usecases/usecase.dart';
import 'package:user_crud/user_crud_app/domain/repositories/user_repository.dart';

import '../entities/user.dart';

part 'update_user.freezed.dart';

@injectable
class UpdateUser implements UseCase<void, UpdateUserParams> {
  final UserRepository repository;

  UpdateUser(this.repository);

  @override
  Future<Result<void, Failure>> call(UpdateUserParams params) {
    return repository.updateUser(params.user);
  }
}

@freezed
class UpdateUserParams with _$UpdateUserParams {
  const factory UpdateUserParams({required User user}) = _UpdateUserParams;
}

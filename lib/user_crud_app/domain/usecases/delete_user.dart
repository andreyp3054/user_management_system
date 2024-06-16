import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:user_crud/user_crud_app/core/error/failures.dart';
import 'package:user_crud/user_crud_app/core/result/result.dart';
import 'package:user_crud/user_crud_app/core/usecases/usecase.dart';
import 'package:user_crud/user_crud_app/domain/repositories/user_repository.dart';

part 'delete_user.freezed.dart';

@injectable
class DeleteUser implements UseCase<void, DeleteUserParams> {
  final UserRepository repository;

  DeleteUser(this.repository);

  @override
  Future<Result<void, Failure>> call(params) async {
    try {
      return await repository.deleteUser(params.id);
    } catch (error) {
      return Result.error(NoIdError());
    }
  }
}

@freezed
class DeleteUserParams with _$DeleteUserParams {
  const factory DeleteUserParams({required int id}) = _DeleteUserParams;
}

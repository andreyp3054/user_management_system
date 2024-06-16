import 'package:injectable/injectable.dart';
import 'package:user_crud/user_crud_app/core/error/failures.dart';
import 'package:user_crud/user_crud_app/core/result/result.dart';
import 'package:user_crud/user_crud_app/core/usecases/usecase.dart';
import 'package:user_crud/user_crud_app/domain/repositories/user_repository.dart';

import '../entities/user.dart';

@injectable
class GetUsers implements UseCase<List<User>, NoParams> {
  final UserRepository repository;

  GetUsers(this.repository);

  @override
  Future<Result<List<User>, Failure>> call(NoParams params) async {
    return await repository.getUsers();
  }
}

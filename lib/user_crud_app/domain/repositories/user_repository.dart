
import '../../core/error/failures.dart';
import '../../core/result/result.dart';
import '../../core/usecases/usecase.dart';
import '../entities/user.dart';

abstract class UserRepository {
  Future<Result<User, Failure>> addUser(User user);

  Future<Result<NoReturn, Failure>> updateUser(User user);

  Future<Result<NoReturn, Failure>> deleteUser(int id);

  Future<Result<List<User>, Failure>> getUsers();
}

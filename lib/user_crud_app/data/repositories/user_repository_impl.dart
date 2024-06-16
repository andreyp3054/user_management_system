import 'package:injectable/injectable.dart';
import 'package:user_crud/user_crud_app/core/error/failures.dart';
import 'package:user_crud/user_crud_app/core/result/result.dart';
import 'package:user_crud/user_crud_app/core/usecases/usecase.dart';
import 'package:user_crud/user_crud_app/data/datasources/user_remote_data_source.dart';
import 'package:user_crud/user_crud_app/domain/entities/user.dart';
import 'package:user_crud/user_crud_app/domain/mapper/user_mapper.dart';
import 'package:user_crud/user_crud_app/domain/repositories/user_repository.dart';

import '../../core/network/network_info.dart';

@Singleton(as: UserRepository)
class UserRepositoryImpl implements UserRepository {
  final NetworkInfo networkInfo;

  final UserRemoteDataSource remoteDataSource;

  UserRepositoryImpl(this.networkInfo, this.remoteDataSource);

  @override
  Future<Result<User, Failure>> addUser(User user) async {
    if (await networkInfo.isConnected == false) {
      return Result.error(NotConnectedToInternetError());
    }
    try {
      final result = await remoteDataSource.addUser(user.toData());
      return Result(result.toDomain());
    } catch (error) {
      return Result.error(ServerFailure());
    }
  }

  @override
  Future<Result<NoReturn, Failure>> deleteUser(int id) async {
    if (await networkInfo.isConnected == false) {
      return Result.error(NotConnectedToInternetError());
    }
    try {
      await remoteDataSource.deleteUser(id);
      return Result(NoReturn());
    } catch (error) {
      return Result.error(ServerFailure());
    }
  }

  @override
  Future<Result<List<User>, Failure>> getUsers() async {
    if (await networkInfo.isConnected == false) {
      return Result.error(NotConnectedToInternetError());
    }
    try {
      final result = await remoteDataSource.getUsers();
      final castedResult = result.map((e) => e.toDomain()).toList();
      return Result(castedResult);
    } catch (error) {
      return Result.error(ServerFailure());
    }
  }

  @override
  Future<Result<NoReturn, Failure>> updateUser(User user) async {
    if (await networkInfo.isConnected == false) {
      return Result.error(NotConnectedToInternetError());
    }
    try {
      await remoteDataSource.addUser(user.toData());
      return Result(NoReturn());
    } catch (error) {
      return Result.error(ServerFailure());
    }
  }
}

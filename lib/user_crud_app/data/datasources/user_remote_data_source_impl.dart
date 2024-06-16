import 'package:injectable/injectable.dart';
import 'package:user_crud/user_crud_app/data/api_service/user_api_service.dart';
import 'package:user_crud/user_crud_app/data/datasources/user_remote_data_source.dart';
import 'package:user_crud/user_crud_app/data/models/user_model.dart';

@Singleton(as: UserRemoteDataSource)
class UserRemoteDataSourceImpl implements UserRemoteDataSource {
  final UserApiService apiService;

  UserRemoteDataSourceImpl(this.apiService);

  @override
  Future<UserModel> addUser(UserModel user) async {
    return await apiService.addUserDetails(user);
  }

  @override
  Future<void> deleteUser(int id) {
    // TODO: implement deleteUser
    throw UnimplementedError();
  }

  @override
  Future<List<UserModel>> getUsers() {
    // TODO: implement getUsers
    throw UnimplementedError();
  }

  @override
  Future<void> updateUser(UserModel user) {
    // TODO: implement updateUser
    throw UnimplementedError();
  }
}

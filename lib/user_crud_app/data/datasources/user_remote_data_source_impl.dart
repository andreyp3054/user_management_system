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
    return await apiService.addUser(user);
  }

  @override
  Future<void> deleteUser(int id) async {
    return await apiService.deleteUser(id);
  }

  @override
  Future<List<UserModel>> getUsers() async {
    return await apiService.getUsers();
  }

  @override
  Future<void> updateUser(UserModel user) async {
    return await apiService.updateUser(user);
  }
}

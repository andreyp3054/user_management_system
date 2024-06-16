import 'package:user_crud/user_crud_app/data/models/user_model.dart';

abstract class UserRemoteDataSource {
  Future<List<UserModel>> getUsers();

  Future<UserModel> addUser(UserModel user);

  Future<void> updateUser(UserModel user);

  Future<void> deleteUser(int id);
}

import '../models/user_model.dart';

abstract class UserApiService {
  Future addUser(UserModel user);

  Future<void> deleteUser(int id);

  Future getUsers();

  Future updateUser(UserModel user);
}

import '../models/user_model.dart';

abstract class UserApiService {
  Future addUserDetails(UserModel user);
}

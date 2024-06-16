import 'package:user_crud/user_crud_app/data/models/user_model.dart';

import '../entities/user.dart';

extension UserMapper on UserModel {
  User toDomain() {
    return User(firstName: firstName, lastName: lastName, age: age);
  }
}

extension UserModelMapper on User {
  UserModel toData() {
    return UserModel(
        id: id, firstName: firstName, lastName: lastName, age: age);
  }
}

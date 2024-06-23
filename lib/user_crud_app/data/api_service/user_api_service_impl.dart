import 'package:injectable/injectable.dart';
import 'package:user_crud/user_crud_app/data/api_service/user_api_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:user_crud/user_crud_app/data/models/user_model.dart';

@Singleton(as: UserApiService)
class UserApiServiceImpl implements UserApiService {
  int currentId = 0; // set id manually

  @override
  Future addUser(UserModel user) async {
    final id = currentId++;
    final Map<String, dynamic> userInfoMap = {
      "First Name": user.firstName,
      "Last Name": user.lastName,
      "Age": user.age,
      "id": id,
    };
    return await FirebaseFirestore.instance
        .collection("users")
        .doc()
        .set(userInfoMap);
  }

  @override
  Future<void> deleteUser(int id) async {
    return await FirebaseFirestore.instance
        .collection("users")
        .doc(id.toString())
        .delete();
  }

  @override
  Future getUsers() async {
    return await FirebaseFirestore.instance.collection("users").get();
  }

  @override
  Future updateUser(UserModel user) async {
    return await FirebaseFirestore.instance
        .collection("users")
        .doc(user.id.toString())
        .update({
      "Age": user.age,
      "First Name": user.firstName,
      "Last Name": user.lastName,
    });
  }
}

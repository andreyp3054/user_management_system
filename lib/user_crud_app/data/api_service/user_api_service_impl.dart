import 'package:injectable/injectable.dart';
import 'package:user_crud/user_crud_app/data/api_service/user_api_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:user_crud/user_crud_app/data/models/user_model.dart';

@Singleton(as: UserApiService)
class UserApiServiceImpl implements UserApiService {
  @override
  Future addUserDetails(UserModel user) async {
    final Map<String, dynamic> userInfoMap = {
      "First Name": user.firstName,
      "Last Name": user.lastName,
      "Age": user.age,
    };
    return await FirebaseFirestore.instance
        .collection("users")
        .doc()
        .set(userInfoMap);
  }
}

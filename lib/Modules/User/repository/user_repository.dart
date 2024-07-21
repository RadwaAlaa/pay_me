import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:pay_me/Core/network_service.dart';
import 'package:pay_me/Modules/User/model/user_model.dart';
import 'package:pay_me/Modules/User/repository/i_user_repository.dart';

class UserRepository implements IUserRepository {
  const UserRepository();

  @override
  Future<UserModel> getUser() async {
    var db = FirebaseFirestore.instance;

    var response = await NetworkClient.request('user');
    var result = await db.collection('users').get();
    return UserModel.fromJson(result.docs.first.data());
  }
}

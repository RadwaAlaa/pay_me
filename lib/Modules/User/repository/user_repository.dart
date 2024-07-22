import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:pay_me/Core/firestore_service.dart';
import 'package:pay_me/Modules/User/model/user_model.dart';
import 'package:pay_me/Modules/User/repository/i_user_repository.dart';

class UserRepository implements IUserRepository {
  const UserRepository();

  @override
  Future<UserModel> getUser() async {
    var db = FirebaseFirestore.instance;
    // var response = await NetworkClient.request('user');
    var result = await db.collection('users').get();
    var user = UserModel.fromJson(result.docs.first.data());
    user.documentId = result.docs.first.id;
    return user;
  }

  Future<void> updateBalance(double amount, UserModel user) async {
    user.balance = user.balance - amount - 1;
    var db = FirestoreService();
    await db.updateDocument('users', user.documentId, UserModel.toJson(user));
  }
}

import 'package:pay_me/Core/firestore_service.dart';
import 'package:pay_me/Modules/User/model/user_model.dart';
import 'package:pay_me/Modules/User/repository/i_user_repository.dart';

class UserRepository implements IUserRepository {
  const UserRepository();

  @override
  Future<UserModel> getUser(String id) async {
    var fireStoreService = FirestoreService();
    var result = await fireStoreService.getCollection('users');
    var user = UserModel.fromJson(
        result.docs.toList().where((e) => e.data()['id'] == id).first.data());
    user.documentId = result.docs.first.id;
    return user;
  }

  Future<void> updateBalance(double amount, UserModel user) async {
    user.balance = user.balance - amount - 1;
    var db = FirestoreService();
    await db.updateDocument('users', user.documentId, UserModel.toJson(user));
  }
}

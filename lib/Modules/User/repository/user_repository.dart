import 'package:pay_me/Core/network_service.dart';
import 'package:pay_me/Modules/User/model/user_model.dart';
import 'package:pay_me/Modules/User/repository/i_user_repository.dart';

class UserRepository implements IUserRepository {
  UserRepository();

  @override
  Future<UserModel> getUser() async {
    var response = await NetworkClient.request('user');
    return UserModel.fromJson(response);
  }
}

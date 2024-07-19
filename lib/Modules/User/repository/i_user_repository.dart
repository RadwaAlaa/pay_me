import 'package:pay_me/Modules/User/model/user_model.dart';

abstract class IUserRepository {
  Future<UserModel> getUser();
}

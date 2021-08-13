import 'package:chat/global/Locator.dart';
import 'package:chat/models/User.dart';
import 'package:chat/repository/UserRepository.dart';
import 'package:chat/services/UserServices.dart';

class UserRepository_Impl implements UserRepository {
  UserServices _userServices = getIt<UserServices>();
  @override
  Future<List<AppUser>> getAllUser() async {
    return await _userServices.getAllUser();
  }
}

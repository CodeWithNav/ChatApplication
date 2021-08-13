import 'package:chat/models/User.dart';

abstract class UserRepository {
  Future<List<AppUser>> getAllUser();
}

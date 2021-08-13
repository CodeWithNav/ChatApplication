import 'package:chat/global/Locator.dart';
import 'package:chat/models/User.dart';
import 'package:chat/repository/AuthRepository.dart';
import 'package:chat/services/AuthServices.dart';
import 'package:chat/services/UserServices.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthRepository_Impl implements AuthRepository {
  AuthServices _authServices = getIt<AuthServices>();
  UserServices _userServices = getIt<UserServices>();

  @override
  Future<void> continueWithGoogle() async {
    await _authServices.continueWithGoogle();
  }

  @override
  Future<void> signInWithEmailAndPassword(String email, String password) async {
    await _authServices.sighInWithEmail(email, password);
  }

  @override
  Future<void> signUpWithEmailAndPassword(String email, String password) async {
    await _authServices.sighUpWithEmail(email, password);
    if (_authServices.auth.currentUser != null) {
      User? currentUser = _authServices.auth.currentUser;

      int index = email.indexOf('@');
      String userName = email.substring(0, index);

      AppUser user = AppUser(userName, currentUser?.photoURL, email)
        ..uId = currentUser?.uid;
      await _userServices.createUser(user);
    }
  }
}

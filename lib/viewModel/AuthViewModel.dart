import 'package:chat/form_model/auth_form_model.dart';
import 'package:chat/global/Locator.dart';
import 'package:chat/repository_impl/AuthRepository_impl.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:stacked/stacked.dart';

class AuthViewModel extends BaseViewModel {
  bool _isLoading = false;
  bool get isLoading => _isLoading;
  String? _err;
  String? get err => _err;
  AuthFormModel authFormModel = AuthFormModel();

  _setIsLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  _setErr(String? value) {
    _err = value;
    notifyListeners();
  }

  AuthRepository_Impl _repository_impl = getIt<AuthRepository_Impl>();

  Future<void> continueWithGoogle() async {
    _setIsLoading(true);
    await _repository_impl.continueWithGoogle();
    _setIsLoading(false);
  }

  Future<void> signInWithEmailAndPassword(String email, String password) async {
    _setIsLoading(true);
    _setErr(null);
    try {
      await _repository_impl.signInWithEmailAndPassword(email, password);
    } catch (e) {
      if (e.runtimeType == FirebaseAuthException) {
        FirebaseAuthException error = e as FirebaseAuthException;
        _setErr(error.message);
      } else {
        _setErr("Something went Wrong");
      }
    }
    _setIsLoading(false);
  }

  Future<void> signUpWithEmailAndPassword(String email, String password) async {
    _setIsLoading(true);
    _setErr(null);
    try {
      await _repository_impl.signUpWithEmailAndPassword(email, password);
    } catch (e) {
      if (e.runtimeType == FirebaseAuthException) {
        FirebaseAuthException error = e as FirebaseAuthException;
        _setErr(error.message);
      } else {
        _setErr("Something went Wrong");
      }
    }
    _setIsLoading(false);
  }
}

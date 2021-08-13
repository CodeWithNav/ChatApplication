abstract class AuthRepository {
  Future<void> continueWithGoogle();
  Future<void> signUpWithEmailAndPassword(String email, String password);
  Future<void> signInWithEmailAndPassword(String email, String password);
}

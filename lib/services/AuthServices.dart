import 'package:firebase_auth/firebase_auth.dart';

class AuthServices {
  FirebaseAuth auth = FirebaseAuth.instance;

  Future<void> continueWithGoogle() async {
    // GoogleAuthProvider googleProvider = GoogleAuthProvider();
    //
    // googleProvider
    //     .addScope('https://www.googleapis.com/auth/contacts.readonly');
    // googleProvider.setCustomParameters({'login_hint': 'user@example.com'});
    //
    // // Once signed in, return the UserCredential
    // await FirebaseAuth.instance.signInWithPopup(googleProvider);
  }

  Future<void> sighUpWithEmail(String email, String password) async {
    await auth.createUserWithEmailAndPassword(email: email, password: password);
  }

  Future<void> sighInWithEmail(String email, String password) async {
    await auth.signInWithEmailAndPassword(email: email, password: password);
  }

  Future<void> logOut() async {
    await auth.signOut();
  }
}

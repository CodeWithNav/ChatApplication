import 'package:chat/global/Locator.dart';
import 'package:chat/models/User.dart';
import 'package:chat/services/AuthServices.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class UserServices {
  CollectionReference users =
      FirebaseFirestore.instance.collection(AppUser.keyTableName);
  Future<void> createUser(AppUser user) async {
    await users
        .doc(user.uId)
        .set(user.toMap())
        .onError((error, stackTrace) => print(error))
        .whenComplete(() => print("Completed"));
  }

  Future<List<AppUser>> getAllUser() async {
    List<AppUser> res = [];
    await users
        .where(AppUser.keyEmail,
            isNotEqualTo: getIt<AuthServices>().auth.currentUser!.email)
        .get()
        .then((value) => value.docs.forEach((element) {
              print(element.data().toString());

              res.add(AppUser.fromJson(element.data(), element.id));
            }));

    return res;
  }
}

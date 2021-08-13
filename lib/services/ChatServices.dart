import 'dart:async';

import 'package:chat/global/Locator.dart';
import 'package:chat/models/ChatModel.dart';
import 'package:chat/services/AuthServices.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ChatServices {
  CollectionReference _chats =
      FirebaseFirestore.instance.collection(ChatModel.keyTableName);

  Stream<QuerySnapshot> getChatAsStream(String senderId) {
    List<String> condition = [
      getIt<AuthServices>().auth.currentUser!.uid + senderId,
      senderId + getIt<AuthServices>().auth.currentUser!.uid
    ];
    return _chats.where(ChatModel.keyId, whereIn: condition).snapshots(
          includeMetadataChanges: true,
        );
  }

  Future<void> setChatMessage(ChatModel chatModel) async {
    await _chats.add(chatModel.toMap());
  }
}

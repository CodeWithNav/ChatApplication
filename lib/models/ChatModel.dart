import 'package:cloud_firestore/cloud_firestore.dart';

class ChatModel {
  static const keyTableName = "Chats";
  static const keyMsg = "Message";
  static const keySenderId = "SenderId";
  static const keyReceiverId = "ReceiverId";
  static const keyDataTime = "DateTime";
  static const keyId = "Id";
  String? senderId;
  String? receiverId;
  String? message;
  DateTime? createdOn;
  String getId() {
    return senderId! + receiverId!;
  }

  ChatModel();
  Map<String, dynamic> toMap() {
    return {
      keyMsg: message,
      keySenderId: senderId,
      keyReceiverId: receiverId,
      keyDataTime: createdOn,
      keyId: getId()
    };
  }

  ChatModel.fromJson(json) {
    senderId = json[keySenderId];
    receiverId = json[keyReceiverId];
    message = json[keyMsg];
    createdOn = (json[keyDataTime] as Timestamp).toDate();
  }
}

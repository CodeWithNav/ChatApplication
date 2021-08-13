import 'package:chat/models/ChatModel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

abstract class ChatRepository {
  Stream<QuerySnapshot> getChatAsStream(String senderId);
  Future<void> sendMessage(ChatModel chatModel);
}

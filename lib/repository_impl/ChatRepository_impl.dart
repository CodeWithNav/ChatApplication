import 'package:chat/global/Locator.dart';
import 'package:chat/models/ChatModel.dart';
import 'package:chat/repository/ChatRepository.dart';
import 'package:chat/services/ChatServices.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ChatRepository_impl implements ChatRepository {
  ChatServices _chatServices = getIt<ChatServices>();
  @override
  Stream<QuerySnapshot> getChatAsStream(String senderId) {
    return _chatServices.getChatAsStream(senderId);
  }

  @override
  Future<void> sendMessage(ChatModel chatModel) async {
    _chatServices.setChatMessage(chatModel);
  }
}

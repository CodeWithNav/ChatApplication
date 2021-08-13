import 'package:chat/global/Locator.dart';
import 'package:chat/models/ChatModel.dart';
import 'package:chat/repository_impl/ChatRepository_impl.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:stacked/stacked.dart';

class ChatViewModel extends BaseViewModel {
  ChatRepository_impl _chatRepository_impl = getIt<ChatRepository_impl>();
  Stream<List<ChatModel>>? chats;

  ChatViewModel(String senderId);

  Stream<QuerySnapshot> setUp(String senderId) {
    return _chatRepository_impl.getChatAsStream(senderId);
  }

  send(ChatModel chatModel) {
    _chatRepository_impl.sendMessage(chatModel);
  }
}

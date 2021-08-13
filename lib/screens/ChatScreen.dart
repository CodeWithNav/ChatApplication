import 'package:chat/global/Locator.dart';
import 'package:chat/models/ChatModel.dart';
import 'package:chat/models/User.dart';
import 'package:chat/services/AuthServices.dart';
import 'package:chat/viewModel/ChatViewModel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class ChatScreen extends StatelessWidget {
  ChatScreen({Key? key, required this.user}) : super(key: key);
  final AppUser user;

  TextEditingController msg = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<ChatViewModel>.reactive(
      viewModelBuilder: () => ChatViewModel(user.uId!),
      builder: (_, ChatViewModel viewModel, ___) => Scaffold(
        appBar: AppBar(
          title: Text((user.name!)),
        ),
        body: StreamBuilder<QuerySnapshot>(
          stream: viewModel.setUp(user.uId!),
          builder: (context, snapshot) {
            List<ChatModel> chats = [];
            if (snapshot.hasData) {
              snapshot.data!.docs.forEach((element) {
                chats.add(ChatModel.fromJson(element.data()));
              });
              chats.sort((e, s) {
                return s.createdOn!.compareTo(e.createdOn!);
              });
              return Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Expanded(
                    child: ListView.builder(
                        itemCount: chats.length,
                        reverse: true,
                        itemBuilder: (_, i) {
                          if (chats[i].senderId ==
                              getIt<AuthServices>().auth.currentUser!.uid) {
                            return Align(
                              alignment: Alignment.centerRight,
                              child: ChatCard(chatModel: chats[i]),
                            );
                          } else {
                            return Align(
                              alignment: Alignment.centerLeft,
                              child: ChatCard(chatModel: chats[i]),
                            );
                          }
                        }),
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: TextField(
                            controller: msg,
                            decoration: InputDecoration(
                                hintText: "Enter Message",
                                border: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    width: 5,
                                  ),
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(20),
                                  ),
                                )),
                          ),
                        ),
                      ),
                      IconButton(
                          onPressed: () {
                            if (msg.text != null && msg.text.length > 0) {
                              ChatModel chatModel = ChatModel()
                                ..message = msg.text
                                ..senderId =
                                    getIt<AuthServices>().auth.currentUser!.uid
                                ..receiverId = user.uId
                                ..createdOn = DateTime.now();
                              viewModel.send(chatModel);
                              msg.text = "";
                              // viewModel.notifyListeners();
                            }
                          },
                          icon: Icon(Icons.send)),
                    ],
                  ),
                ],
              );
            }
            return Center(
              child: CircularProgressIndicator(),
            );
          },
        ),
      ),
    );
  }
}

class ChatCard extends StatelessWidget {
  ChatCard({Key? key, required this.chatModel}) : super(key: key);
  final ChatModel chatModel;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(10),
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.blueGrey.shade200,
        borderRadius: BorderRadius.only(
          topLeft:
              chatModel.senderId == getIt<AuthServices>().auth.currentUser!.uid
                  ? Radius.circular(10)
                  : Radius.circular(2),
          bottomLeft:
              chatModel.senderId == getIt<AuthServices>().auth.currentUser!.uid
                  ? Radius.circular(2)
                  : Radius.circular(10),
          topRight: Radius.circular(10),
          bottomRight: Radius.circular(10),
        ),
      ),
      child: Text("${chatModel.message}"),
    );
  }
}

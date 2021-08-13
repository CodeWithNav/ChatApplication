import 'package:chat/components/FriendsList.dart';
import 'package:chat/screens/ChatScreen.dart';
import 'package:chat/viewModel/HomeViewModel.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ViewModelBuilder<HomeViewModel>.reactive(
        viewModelBuilder: () => HomeViewModel(),
        builder: (_, HomeViewModel viewModel, __) =>
            LayoutBuilder(builder: (_, boxC) {
          print(boxC.maxWidth.toString());
          if (boxC.maxWidth >= 500) {
            return Row(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Expanded(
                  flex: 4,
                  child: viewModel.users != null
                      ? FriendsList(
                          users: viewModel.users!,
                          onItemTap: (index) {
                            viewModel.setSelectedFriend(index);
                          },
                        )
                      : Center(
                          child: CircularProgressIndicator(),
                        ),
                ),
                Container(
                  color: Colors.blueGrey,
                  width: 10,
                ),
                Expanded(
                  flex: 6,
                  child: viewModel.selectedFriend == -1
                      ? Center(
                          child: Text('No Friend Selected'),
                        )
                      : ChatScreen(
                          user: viewModel.users![viewModel.selectedFriend]),
                ),
              ],
            );
          }
          return viewModel.users != null
              ? FriendsList(
                  users: viewModel.users!,
                  onItemTap: (index) {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return ChatScreen(user: viewModel.users![index]);
                    }));
                    viewModel.setSelectedFriend(index);
                  },
                )
              : Center(
                  child: CircularProgressIndicator(),
                );
        }),
      ),
    );
  }
}

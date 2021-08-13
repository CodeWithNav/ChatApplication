import 'package:chat/global/Locator.dart';
import 'package:chat/models/User.dart';
import 'package:chat/services/AuthServices.dart';
import 'package:flutter/material.dart';

class FriendsList extends StatelessWidget {
  FriendsList({Key? key, required this.users, required this.onItemTap})
      : super(key: key);
  final List<AppUser> users;
  final Function(int) onItemTap;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Friends"),
        actions: [
          ElevatedButton.icon(
            onPressed: () {
              getIt<AuthServices>().logOut();
            },
            icon: Icon(Icons.logout),
            label: Text("Logout"),
          ),
        ],
      ),
      body: ListView.builder(
          itemCount: users.length,
          itemBuilder: (_, index) {
            return Container(
              margin: EdgeInsets.all(10),
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Colors.greenAccent.shade200,
                borderRadius: BorderRadius.all(Radius.circular(20)),
              ),
              child: ListTile(
                onTap: () {
                  this.onItemTap(index);
                },
                title: Text(users[index].name!),
              ),
            );
          }),
    );
  }
}

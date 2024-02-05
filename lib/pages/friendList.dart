import 'package:flutter/material.dart';

class FriendList extends StatelessWidget {
  const FriendList({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Text("Friend List", style: TextStyle(color: Colors.black)),
        title: Text("Friend List"),
      ),
      body: Center(
        child: Text("Friend List"),
      ),
    );
  }
}

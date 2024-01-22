import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:bulbtalk/Rooms.dart';

class LoginPage extends StatelessWidget {
  LoginPage({super.key});
  final myController = TextEditingController();

  @override
  Widget build(BuildContext context) => Scaffold(
        body: Scaffold(
          appBar: AppBar(
            leading: IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () => Get.back(),
            ),
          ),
          body: Center(
            child: Column(
              children: [
                TextField(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: "user_id",
                  ),
                  controller: myController,
                ),
                FloatingActionButton(
                  onPressed: () => Get.to(
                    Rooms(),
                    arguments: {"user_id": myController.text},
                  ),
                ),
              ],
            ),
          ),
        ),
      );
}

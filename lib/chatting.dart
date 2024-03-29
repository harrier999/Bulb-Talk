import 'package:flutter/material.dart';
import 'package:flutter_chat_ui/flutter_chat_ui.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'package:web_socket_channel/web_socket_channel.dart';

import 'dart:convert';
import 'dart:math';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

String randomString() {
  final random = Random.secure();
  final values = List<int>.generate(16, (i) => random.nextInt(255));
  return base64UrlEncode(values);
}

class Chatting extends StatefulWidget {
  const Chatting({super.key});

  @override
  State<Chatting> createState() => _ChattingState();
}

class _ChattingState extends State<Chatting> {
  late List<types.Message> chat; //chatting message list of this chatting room
  late types.User user; // user of this phone
  late WebSocketChannel socket; // websocket for this chatting room
  late String room_id; // room id of this chatting room

  @override
  void initState() {
    super.initState();
    getChatFromDB();
    getUserID();
    createSocket();
  }

  void getChatFromDB() async {
    chat = [];
    return;
  }

  void getUserID() {
    print("user_id: " + Get.arguments["user_id"]);
    print("url: " + dotenv.env['CHATTING_SERVER_URL']!);
    print("room_id: " + Get.arguments["room_id"]!);
    room_id = Get.arguments["room_id"];
    user = types.User(
        id: Get.arguments["user_id"],
        imageUrl:
            'https://blog.kakaocdn.net/dn/eERcfo/btqK7cioPfB/weKJpVnfZDk3RB2JOXBfTK/img.png');
  }

  void createSocket() {
    String? chattingServerURL = dotenv.env['CHATTING_SERVER_URL'];
    if (chattingServerURL == null) {
      Fluttertoast.showToast(
          msg: "Failed to create connection to server. Error 101");
      return;
    }

    socket = WebSocketChannel.connect(Uri.parse(chattingServerURL + "/chat"));
    socket.sink.add(json.encode({"room_id": room_id , "user_id": user.id}));

    socket.stream.listen(
      (event) {
        setState(
          () {
            var data = json.decode(event);
            if (data["messageType"] == "messageList") {
              for (var i = data["payload"]["messages"].length - 1;
                  i >= 0;
                  i--) {
                chat.add(
                    types.Message.fromJson(data["payload"]["messages"][i]));
              }
            } else {
              chat.insert(0, types.Message.fromJson(data["payload"]));
            }
          },
        );
      },
      onError: (error) {
        Fluttertoast.showToast(
          msg: error.toString(),
        );
        Get.back();
      },
    );
  }

  @override
  void dispose() {
    socket.sink.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          leading: IconButton(
        icon: Icon(
          Icons.arrow_back,
        ),
        onPressed: () => Get.back(),
      )),
      body: Chat(
        messages: chat,
        onSendPressed: onSendPressed,
        user: user,
        showUserAvatars: true,
        showUserNames: true,
      ),
    );
  }

  void onSendPressed(types.PartialText message) {
    final textMessage = types.TextMessage(
        author: user,
        createdAt: DateTime.now().millisecondsSinceEpoch,
        id: randomString(),
        text: message.text,
        roomId: "31");
    // setState(() {
    //   chat.insert(0, textMessage);
    // });
    socket.sink.add(json.encode(textMessage.toJson()));
  }
}

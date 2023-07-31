import 'package:flutter/material.dart';
import 'package:flutter_chat_ui/flutter_chat_ui.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'package:web_socket_channel/io.dart';

import 'dart:convert';
import 'dart:math';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:fluttertoast/fluttertoast.dart';

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
  late IOWebSocketChannel socket; // websocket for this chatting room

  @override
  void initState() {
    super.initState();
    getChatFromDB();
    getUserID();
    createSocket();
  }

  void getChatFromDB() {
    chat = [];
    return;
  }

  void getUserID() {
    user = types.User(
        id: "me",
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
    socket = IOWebSocketChannel.connect(chattingServerURL + "/ws");
    socket.stream.listen((event) {
      setState(() {
        chat.insert(
          0,
          types.ImageMessage(
            author: types.User(
                id: "server",
                firstName: "aloha ",
                lastName: "can",
                imageUrl:
                    "https://blog.kakaocdn.net/dn/eERcfo/btqK7cioPfB/weKJpVnfZDk3RB2JOXBfTK/img.png"),
            id: randomString(),
            uri:
                "https://blog.kakaocdn.net/dn/eERcfo/btqK7cioPfB/weKJpVnfZDk3RB2JOXBfTK/img.png",
            name: "gp",
            size: 1,
            
          ),
        );
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Chat(
      messages: chat,
      onSendPressed: onSendPressed,
      user: user,
      showUserAvatars: true,
      showUserNames: true,
      
    );
  }

  void onSendPressed(types.PartialText message) {
    final textMessage = types.TextMessage(
      author: user,
      createdAt: DateTime.now().millisecondsSinceEpoch,
      id: randomString(),
      text: message.text,
    );
    // setState(() {
    //   chat.insert(0, textMessage);
    // });
    socket.sink.add(json.encode(textMessage.toJson()));
  }
}

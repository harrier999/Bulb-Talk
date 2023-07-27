import 'package:flutter/material.dart';
import 'package:flutter_chat_ui/flutter_chat_ui.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'package:web_socket_channel/io.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

import 'dart:convert';
import 'dart:math';

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
    socket = IOWebSocketChannel.connect("ws://141.164.50.18:8000/ws");
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          chat.insert(
            0,
            types.TextMessage(
              author: types.User(
                id: "server",
                firstName: "fdsa",
                lastName: "fdsa",
                imageUrl:
                    'https://blog.kakaocdn.net/dn/eERcfo/btqK7cioPfB/weKJpVnfZDk3RB2JOXBfTK/img.png',
              ),
              id: randomString(),
              text: snapshot.data.toString(),
            ),
          );
        }
        return Chat(
          messages: chat,
          onSendPressed: onSendPressed,
          user: user,
          showUserAvatars: true,
          showUserNames: true,
        );
      },
      stream: socket.stream,
    );
  }

  void onSendPressed(types.PartialText message) {
    final textMessage = types.TextMessage(
      author: user,
      createdAt: DateTime.now().millisecondsSinceEpoch,
      id: randomString(),
      text: message.text,
    );
    socket.sink.add(json.encode(textMessage.toJson()));
  }
}

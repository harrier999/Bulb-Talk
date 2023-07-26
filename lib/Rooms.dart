import 'package:flutter/material.dart';
import 'package:flutter_chat_ui/flutter_chat_ui.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'package:web_socket_channel/web_socket_channel.dart';
import 'package:web_socket_channel/io.dart';
import 'dart:convert';
import 'dart:math';

String randomString() {
  final random = Random.secure();
  final values = List<int>.generate(16, (i) => random.nextInt(255));
  return base64UrlEncode(values);
}

class Rooms extends StatefulWidget {
  const Rooms({super.key});

  @override
  State<Rooms> createState() => _RoomsState();
}

class _RoomsState extends State<Rooms> {
  final List<List<types.Message>> messageListList = [
    [
      types.TextMessage(
          id: randomString(),
          author: const types.User(id: "first"),
          text: "hello")
    ],
    [
      types.TextMessage(
          id: randomString(),
          author: const types.User(id: "first"),
          text: "hello")
    ]
  ];
  final channel = IOWebSocketChannel.connect("ws://141.164.50.18:8000/ws",
      headers: {'connection-type': 'initial'});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: channel.stream,
      builder: (context, snapshot) {
        messageListList[0].insert(
            0,
            types.TextMessage(
              author: const types.User(id: "server"),
              id: randomString().toString(),
              text: snapshot.data.toString(),
            ));
        return ListView.builder(
          itemCount: 2,
          itemBuilder: (context, index) {
            return Room(
              roomName: "room # $index",
              recentMessage: "recent message",
              numberOfUnreadMessages: messageListList[index].length,
              roomNum: index,
              messages: messageListList[index],
              channel: channel,
            );
          },
        );
      },
    );
  }
}

class Room extends StatefulWidget {
  const Room(
      {super.key,
      required this.roomName,
      required this.recentMessage,
      required this.numberOfUnreadMessages,
      required this.roomNum,
      required this.messages,
      required this.channel});

  final user = const types.User(
    id: "first",
  );

  final String roomName;
  final int roomNum;
  final String recentMessage;
  final int numberOfUnreadMessages;
  final List<types.Message> messages;
  final WebSocketChannel channel;

  @override
  State<Room> createState() => _RoomState();
}

class _RoomState extends State<Room> {
  late List<types.Message> _messages;

  @override
  void initState() {
    super.initState();
    _messages = widget.messages; // Initialize the messages list
  }

  void onSendPressed(types.PartialText message) {
    final textMessage = types.TextMessage(
      author: widget.user,
      createdAt: DateTime.now().millisecondsSinceEpoch,
      id: randomString(),
      text: message.text,
    );
    widget.channel.sink.add(textMessage.text);
    setState(() {
      _messages.insert(0, textMessage);
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: ((context) {
              return Chat(
                messages: _messages,
                onSendPressed: onSendPressed,
                user: widget.user,
              );
            }),
          ),
        );
      },
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(
            color: Colors.brown,
          ),
        ),
        child: Row(
          children: [
            const Icon(
              Icons.face,
              color: Colors.blue,
            ),
            Column(
              children: [
                Text(
                  widget.roomName,
                ),
                Text(
                  widget.recentMessage,
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}

class Chatting extends StatefulWidget {
  const Chatting({super.key});

  @override
  State<Chatting> createState() => _ChattingState();
}

class _ChattingState extends State<Chatting> {
  final channel = IOWebSocketChannel.connect("ws://141.164.50.18:8000/ws",
      headers: {'connection-type': 'chatting'});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
        stream: channel.stream,
        builder: (context, snapshot) {
          return Chat(messages: messages, onSendPressed: onSendPressed, user: user)
        },
      ),
    );
  }
}

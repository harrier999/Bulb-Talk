import 'package:flutter/material.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'package:get/get.dart';

import 'dart:convert';
import 'dart:math';

import 'chatting.dart';

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
  // final List<List<types.Message>> messageListList = [
  //   [
  //     types.TextMessage(
  //         id: randomString(),
  //         author: const types.User(id: "first"),
  //         text: "hello")
  //   ],
  //   [
  //     types.TextMessage(
  //         id: randomString(),
  //         author: const types.User(id: "first"),
  //         text: "hello")
  //   ]
  // ];
  // final channel =
  //     WebSocketChannel.connect(Uri.parse("ws://141.164.50.18:8000/rooms"));

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 100,
        ),
        Room(roomName: "roomName", recentMessage: "hell", roomNum: 31),
        Room(roomName: "good", recentMessage: "how are you", roomNum: 33),
      ],
    );
    // return StreamBuilder(
    //   stream: channel.stream,
    //   builder: (context, snapshot) {
    //     messageListList[0].insert(
    //         0,
    //         types.TextMessage(
    //           author: const types.User(id: "server"),
    //           id: randomString().toString(),
    //           text: snapshot.data.toString(),
    //         ));
    //     return ListView.builder(
    //       itemCount: 2,
    //       itemBuilder: (context, index) {
    //         return Room(
    //           roomName: "room # $index",
    //           recentMessage: "recent message",
    //           numberOfUnreadMessages: messageListList[index].length,
    //           roomNum: index,
    //           messages: messageListList[index],
    //           channel: channel,
    //         );
    //       },
    //     );
    //   },
    // );
  }
}

class Room extends StatefulWidget {
  const Room({
    super.key,
    required this.roomName,
    required this.recentMessage,
    // required this.numberOfUnreadMessages,
    required this.roomNum,
    // required this.messages,
    // required this.channel
  });

  final user = const types.User(
    id: "first",
  );

  final String roomName;
  final int roomNum;
  final String recentMessage;
  // final int numberOfUnreadMessages;
  // final List<types.Message> messages;
  // final WebSocketChannel channel;

  @override
  State<Room> createState() => _RoomState();
}

class _RoomState extends State<Room> {
  // void onSendPressed(types.PartialText message) {
  //   final textMessage = types.TextMessage(
  //     author: widget.user,
  //     createdAt: DateTime.now().millisecondsSinceEpoch,
  //     id: randomString(),
  //     text: message.text,
  //   );
  //   widget.channel.sink.add(textMessage.text);
  //   setState(() {
  //     widget.messages.insert(0, textMessage);
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Get.to(() => Chatting());

        // Navigator.of(context)
        //     .push(MaterialPageRoute(builder: (context) => Chatting()));

        // Navigator.of(context).push(MaterialPageRoute(builder: ((context) {
        //   return Chat(
        //     messages: widget.messages,
        //     onSendPressed: onSendPressed,
        //     user: widget.user,
        //   );
        // })));
      },
      // Navigator.of(context).push(MaterialPageRoute(builder: ((context) {
      //   return Chat(
      //     messages: widget.messages,
      //     onSendPressed: onSendPressed,
      //     user: widget.user,
      //   );
      // })));
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(
            color: Colors.brown,
          ),
        ),
        child: Row(
          children: [
            StaticAvatar(),
            SizedBox(
              height: 40,
              width: 34,
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

class StaticAvatar extends StatelessWidget {
  StaticAvatar({super.key, this.avatarURL});
  String? avatarURL;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsetsDirectional.only(end: 8),
      child: CircleAvatar(
        backgroundColor: Colors.white,
        backgroundImage: NetworkImage(
            "https://blog.kakaocdn.net/dn/eERcfo/btqK7cioPfB/weKJpVnfZDk3RB2JOXBfTK/img.png"),
        radius: 16,
      ),
    );
  }
}

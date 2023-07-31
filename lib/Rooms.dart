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

  @override
  State<Room> createState() => _RoomState();
}

class _RoomState extends State<Room> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Get.to(() => Chatting());
      },
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
  final String? avatarURL;

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

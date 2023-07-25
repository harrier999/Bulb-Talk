import 'package:flutter/widgets.dart';

import 'package:flutter_chat_types/flutter_chat_types.dart' as types;

class RoomList with ChangeNotifier {
  List<List<types.Message>> rooms;

  RoomList({required this.rooms});

  void insertMessage(int room_id, types.Message message) {
    rooms[room_id].insert(0, message);
    notifyListeners();
  }
}

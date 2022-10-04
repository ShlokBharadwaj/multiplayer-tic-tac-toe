import 'package:flutter/widgets.dart';
import 'package:tic_tac_toe/resources/socket_client.dart';
import 'package:tic_tac_toe/screens/game_screen.dart';

class SocketMethods {
  final _socketClient = SocketClient.instance.socket!;
  void createRoom(String roomName) {
    if (roomName.isNotEmpty) {
      _socketClient.emit('create-room', {
        'roomName': roomName,
      });
    }
  }

  void roomCreatedListener(BuildContext context) {
    _socketClient.on('room-created', (room) {
      print(room);
      Navigator.pushNamed(context, GameScreen.routeName);
    });
  }
}

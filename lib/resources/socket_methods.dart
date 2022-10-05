import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:tic_tac_toe/provider/room_data_provider.dart';
import 'package:tic_tac_toe/resources/socket_client.dart';
import 'package:tic_tac_toe/screens/game_screen.dart';

class SocketMethods {
  final _socketClient = SocketClient.instance.socket!;

  void createRoom(String roomName) {
    if (roomName.isNotEmpty) {
      _socketClient.emit(
        'create-room',
        {
          'roomName': roomName,
        },
      );
    }
  }

  void joinRoom(String gamingName, String gameId) {
    if (gamingName.isNotEmpty && gameId.isNotEmpty) {
      _socketClient.emit(
        'join-room',
        {
          'gamingName': gamingName,
          'gameId': gameId,
        },
      );
    }
  }

  void roomCreatedListener(BuildContext context) {
    _socketClient.on('room-created', (room) {
      Provider.of<RoomDataProvider>(context, listen: false)
          .updateRoomData(room);
      Navigator.pushNamed(context, GameScreen.routeName);
    });
  }
}

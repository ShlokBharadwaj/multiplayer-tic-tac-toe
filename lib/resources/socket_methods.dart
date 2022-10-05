import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:tic_tac_toe/provider/room_data_provider.dart';
import 'package:tic_tac_toe/resources/socket_client.dart';
import 'package:tic_tac_toe/screens/game_screen.dart';
import 'package:tic_tac_toe/utils/utils.dart';

class SocketMethods {
  final _socketClient = SocketClient.instance.socket!;

  void createRoom(String gamingName) {
    if (gamingName.isNotEmpty) {
      _socketClient.emit(
        'create-room',
        {
          'gamingName': gamingName,
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

  void roomJoinedListener(BuildContext context) {
    _socketClient.on('room-joined', (room) {
      Provider.of<RoomDataProvider>(context, listen: false)
          .updateRoomData(room);
      Navigator.pushNamed(context, GameScreen.routeName);
    });
  }

  void errorOccuredListener(BuildContext context) {
    _socketClient.on('Error-Occured', (error) {
      showSnackBar(context, error);
    });
  }

  void updatePlayersStateListener(BuildContext context) {
    _socketClient.on('updatePlayers', (playerData) {
      Provider.of<RoomDataProvider>(context, listen: false)
          .updatePlayer1(playerData[0]);
      Provider.of<RoomDataProvider>(context, listen: false)
          .updatePlayer2(playerData[1]);
    });
  }
}

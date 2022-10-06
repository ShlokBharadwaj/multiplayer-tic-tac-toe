import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:socket_io_client/socket_io_client.dart';
import 'package:tic_tac_toe/provider/room_data_provider.dart';
import 'package:tic_tac_toe/resources/game_methods.dart';
import 'package:tic_tac_toe/resources/socket_client.dart';
import 'package:tic_tac_toe/screens/game_screen.dart';
import 'package:tic_tac_toe/utils/utils.dart';

class SocketMethods {
  final _socketClient = SocketClient.instance.socket!;

  Socket get socketClient => _socketClient;

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

  void tapOnBox(int index, String roomID, List<String> displayElements) {
    if (displayElements[index] == '') {
      _socketClient.emit(
        'tap',
        {
          'index': index,
          'roomID': roomID,
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

  void updateRoomListener(BuildContext context) {
    _socketClient.on('updateRoom', (data) {
      Provider.of<RoomDataProvider>(context, listen: false)
          .updateRoomData(data);
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

  void tappedListener(BuildContext context) {
    _socketClient.on('tapped', (data) {
      RoomDataProvider roomDataProvider =
          Provider.of<RoomDataProvider>(context, listen: false);
      roomDataProvider.updateDisplayElements(
        data['index'],
        data['choice'],
      );
      roomDataProvider.updateRoomData(data['room']);

      GameMethods().checkWinner(context, socketClient);
    });
  }

  void pointIncreaseListener(BuildContext context) {
    _socketClient.on('increasePoints', (playerData) {
      var roomDataProvider =
          Provider.of<RoomDataProvider>(context, listen: false);
      if (roomDataProvider.player1.socketID == playerData['socketID']) {
        roomDataProvider.updatePlayer1(playerData);
      } else {
        roomDataProvider.updatePlayer2(playerData);
      }
    });
  }

  void endGameListener(BuildContext context) {
    _socketClient.on('game-over', (playerData) {
      showGameDialog(context, '${playerData['gamingName']} won the game');
      Navigator.popUntil(context, (route) => false);
    });
  }
}

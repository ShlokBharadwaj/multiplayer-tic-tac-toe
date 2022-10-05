import 'package:flutter/material.dart';
import 'package:tic_tac_toe/models/players.dart';

class RoomDataProvider extends ChangeNotifier {
  Map<String, dynamic> _roomData = {};

  Players _player1 = Players(
    gamingName: '',
    socketId: '',
    points: 0.0,
    playerType: 'X',
  );

  Players _player2 = Players(
    gamingName: '',
    socketId: '',
    points: 0.0,
    playerType: 'O',
  );

  Map<String, dynamic> get roomData => _roomData;

  Players get player1 => _player1;
  Players get player2 => _player2;

  void updateRoomData(Map<String, dynamic> roomData) {
    _roomData = roomData;
    notifyListeners();
  }

  void updatePlayer1(Map<String, dynamic> player1Data) {
    _player1 = Players.fromMap(player1Data);
    notifyListeners();
  }

  void updatePlayer2(Map<String, dynamic> player2Data) {
    _player2 = Players.fromMap(player2Data);
    notifyListeners();
  }
}

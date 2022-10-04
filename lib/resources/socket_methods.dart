import 'package:tic_tac_toe/resources/socket_client.dart';

class SocketMethods {
  final _socketClient = SocketClient.instance.socket!;
  void createRoom(String roomName) {
    if (roomName.isNotEmpty) {
      _socketClient.emit('create-room', {
        'roomName': roomName,
      });
    }
  }
}

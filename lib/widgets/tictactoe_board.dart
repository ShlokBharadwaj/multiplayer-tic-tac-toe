import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tic_tac_toe/provider/room_data_provider.dart';
import 'package:tic_tac_toe/resources/socket_methods.dart';

class TicTacToe extends StatefulWidget {
  const TicTacToe({super.key});

  @override
  State<TicTacToe> createState() => _TicTacToeState();
}

class _TicTacToeState extends State<TicTacToe> {
  final SocketMethods _socketMethods = SocketMethods();

  @override
  void initState() {
    _socketMethods.tappedListener(context);
    super.initState();
  }

  void tapped(int index, RoomDataProvider roomDataProvider) {
    _socketMethods.tapOnBox(
      index,
      roomDataProvider.roomData['_id'],
      roomDataProvider.displayElements,
    );
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    RoomDataProvider roomDataProvider = Provider.of<RoomDataProvider>(context);
    return ConstrainedBox(
      constraints: BoxConstraints(
        maxHeight: size.height * 0.7,
        maxWidth: 500,
      ),
      child: AbsorbPointer(
        absorbing: roomDataProvider.roomData['turn']['socketID'] !=
            _socketMethods.socketClient.id,
        child: GridView.builder(
          itemCount: 9,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
          ),
          itemBuilder: (BuildContext context, int index) {
            return GestureDetector(
              onTap: () => tapped(
                index,
                roomDataProvider,
              ),
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(),
                  color: Colors.white24,
                ),
                child: Center(
                  child: Text(
                    roomDataProvider.displayElements[index],
                    style: TextStyle(
                      fontSize: 100,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      shadows: [
                        Shadow(
                          blurRadius: 10.0,
                          color: roomDataProvider.displayElements[index] == 'O'
                              ? Colors.blue
                              : Colors.red,
                          offset: const Offset(5.0, 5.0),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

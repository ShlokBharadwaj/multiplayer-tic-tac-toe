import 'package:flutter/material.dart';
import 'package:tic_tac_toe/resources/game_methods.dart';

void showSnackBar(BuildContext context, String message) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(message),
    ),
  );
}

void showGameDialog(BuildContext context, String text) {
  showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(text),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                GameMethods().clearBoard(context);
              },
              child: const Text(
                'Play Again',
              ),
            ),
          ],
        );
      });
}

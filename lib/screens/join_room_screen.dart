import 'package:flutter/material.dart';
import 'package:tic_tac_toe/responsive/responsive.dart';
import 'package:tic_tac_toe/widgets/custom_button.dart';
import 'package:tic_tac_toe/widgets/custom_text.dart';
import 'package:tic_tac_toe/widgets/custom_textfield.dart';

class JoinRoomScreen extends StatefulWidget {
  static String routeName = '/join-room';

  const JoinRoomScreen({super.key});

  @override
  State<JoinRoomScreen> createState() => _JoinRoomScreenState();
}

class _JoinRoomScreenState extends State<JoinRoomScreen> {
  final TextEditingController _joinRoomGamingNameController =
      TextEditingController();
  final TextEditingController _gameIdController = TextEditingController();

  @override
  void dispose() {
    _joinRoomGamingNameController.dispose();
    _gameIdController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: Responsive(
        child: Container(
          margin: const EdgeInsets.symmetric(
            horizontal: 30,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const CustomText(
                shadows: [
                  Shadow(
                    blurRadius: 30.0,
                    color: Colors.lightBlue,
                    offset: Offset(5.0, 5.0),
                  )
                ],
                text: 'Join Room',
                fontSize: 70,
              ),
              SizedBox(
                height: size.height * 0.04,
              ),
              CustomTextField(
                controller: _joinRoomGamingNameController,
                hintText: 'Enter your Gaming name',
              ),
              SizedBox(
                height: size.height * 0.04,
              ),
              CustomTextField(
                controller: _gameIdController,
                hintText: 'Enter Game ID',
              ),
              SizedBox(
                height: size.height * 0.04,
              ),
              CustomButton(onTap: () {}, text: 'Join'),
            ],
          ),
        ),
      ),
    );
  }
}

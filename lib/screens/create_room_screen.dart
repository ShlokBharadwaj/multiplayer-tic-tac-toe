import 'package:flutter/material.dart';
import 'package:tic_tac_toe/widgets/custom_button.dart';
import 'package:tic_tac_toe/widgets/custom_text.dart';
import 'package:tic_tac_toe/widgets/custom_textfield.dart';

class CreateRoomScreen extends StatefulWidget {
  static String routeName = '/create-room';
  const CreateRoomScreen({super.key});

  @override
  State<CreateRoomScreen> createState() => _CreateRoomScreenState();
}

class _CreateRoomScreenState extends State<CreateRoomScreen> {
  final TextEditingController _createRoomNameController =
      TextEditingController();

  @override
  void dispose() {
    _createRoomNameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        margin: const EdgeInsets.symmetric(
          horizontal: 20,
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
              text: 'Create Room',
              fontSize: 70,
            ),
            SizedBox(
              height: size.height * 0.08,
            ),
            CustomTextField(
              controller: _createRoomNameController,
              hintText: 'Enter Room Name',
            ),
            SizedBox(
              height: size.height * 0.08,
            ),
            CustomButton(onTap: () {}, text: 'Create'),
          ],
        ),
      ),
    );
  }
}

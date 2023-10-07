import 'package:flutter/material.dart';
import 'package:flash_chat/constants.dart';

class AuthButton extends StatelessWidget {
  const AuthButton(
      {super.key, required this.pressed, required this.message, this.colour});

  final Function() pressed;
  final String message;
  final Color? colour;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      child: Material(
        elevation: 5,
        color: colour,
        borderRadius: BorderRadius.circular(30.0),
        child: TextButton(
          style: ButtonStyle(
            shape: MaterialStateProperty.all(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30.0),
              ),
            ),
          ),
          onPressed: pressed,
          child: Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 8.0,
            ),
            child: Text(
              message,
              textAlign: TextAlign.center,
              style: kAuthButtonTextSTyle,
            ),
          ),
        ),
      ),
    );
  }
}

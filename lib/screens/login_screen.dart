import 'package:flash_chat/screens/chat_screen.dart';
import 'package:flutter/material.dart';
import 'package:flash_chat/widgets/auth_button.dart';
import 'package:flash_chat/widgets/auth_input.dart';

class LoginScreen extends StatefulWidget {
  static String id = "/login_screen";

  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Hero(
                  tag: 'logo',
                  child: SizedBox(
                    height: 200,
                    child: Image.asset('images/logo.png'),
                  ),
                ),
                const SizedBox(
                  height: 50,
                ),
                AuthInput(
                  borderColor: Colors.lightBlueAccent,
                  hintText: 'Enter e-mail',
                  onChange: (value) {},
                ),
                const SizedBox(
                  height: 8,
                ),
                AuthInput(
                  borderColor: Colors.lightBlueAccent,
                  hintText: 'Enter password',
                  onChange: (value) {},
                ),
                const SizedBox(
                  height: 24.0,
                ),
                Hero(
                  tag: 'loginButton',
                  child: AuthButton(
                    pressed: () {
                      Navigator.pushNamed(context, ChatScreen.id);
                    },
                    message: 'Log in',
                    colour: Colors.lightBlueAccent,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

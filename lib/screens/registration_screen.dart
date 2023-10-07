import 'package:flash_chat/screens/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:flash_chat/widgets/auth_button.dart';
import 'package:flash_chat/widgets/auth_input.dart';

class RegistrationScreen extends StatefulWidget {
  static String id = "/register_screen";

  const RegistrationScreen({super.key});

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
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
                  borderColor: Colors.blueAccent,
                  hintText: 'Enter e-mail',
                  onChange: (value) {},
                ),
                const SizedBox(
                  height: 8,
                ),
                AuthInput(
                  borderColor: Colors.blueAccent,
                  hintText: 'Enter password',
                  onChange: (value) {},
                ),
                const SizedBox(
                  height: 24.0,
                ),
                Hero(
                  tag: 'registerButton',
                  child: AuthButton(
                    pressed: () {
                      Navigator.pushNamed(context, LoginScreen.id);
                    },
                    message: 'Register',
                    colour: Colors.blueAccent,
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

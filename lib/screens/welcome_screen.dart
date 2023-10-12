import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flash_chat/constants.dart';
import 'package:flash_chat/screens/login_screen.dart';
import 'package:flash_chat/screens/registration_screen.dart';
import 'package:flash_chat/widgets/auth_button.dart';
import 'package:flutter/material.dart';
import 'package:flash_chat/widgets/flicker_animated_text_corrected.dart';

class WelcomeScreen extends StatefulWidget {
  static String id = "/welcome_screen";

  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen>
    with SingleTickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              children: [
                Hero(
                  tag: 'logo',
                  child: Container(
                    height: 100,
                    child: Image.asset('images/logo.png'),
                  ),
                ),
                Expanded(
                  child: DefaultTextStyle(
                    style: kTitleTextBig,
                    child: AnimatedTextKit(
                      animatedTexts: [
                        FlickerAnimatedTextCorrected(
                          'Flash Chat',
                        ),
                      ],
                      repeatForever: true,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 50.0,
            ),
            Hero(
              tag: 'loginButton',
              child: AuthButton(
                pressed: () {
                  Navigator.pushNamed(context, LoginScreen.id);
                },
                message: 'Log in',
                colour: Colors.lightBlueAccent,
              ),
            ),
            Hero(
              tag: 'registerButton',
              child: AuthButton(
                pressed: () {
                  Navigator.pushNamed(context, RegistrationScreen.id);
                },
                message: 'Register',
                colour: Colors.blueAccent,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:flash_chat/constants.dart';
import 'package:flash_chat/screens/login_screen.dart';
import 'package:flash_chat/screens/registration_screen.dart';
import 'package:flash_chat/widgets/auth_button.dart';
import 'package:flutter/material.dart';

class WelcomeScreen extends StatefulWidget {
  static String id = "/welcome_screen";

  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController animationController;
  late Animation animation;

  @override
  void initState() {
    super.initState();
    animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    );

    animation =
        CurvedAnimation(parent: animationController, curve: Curves.ease);

    animationController.forward();

    animation.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        animationController.reverse(from: 1.0);
      } else if (status == AnimationStatus.dismissed) {
        animationController.forward();
      }
    });

    animationController.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    super.dispose();
    animationController.dispose();
  }

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
                    height: animation.value * 100,
                    child: Image.asset('images/logo.png'),
                  ),
                ),
                const Text(
                  'Flash Chat',
                  style: kTitleTextBig,
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

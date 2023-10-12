import 'package:flash_chat/screens/chat_screen.dart';
import 'package:flutter/material.dart';
import 'package:flash_chat/widgets/auth_button.dart';
import 'package:flash_chat/widgets/auth_input.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class LoginScreen extends StatefulWidget {
  static String id = "/login_screen";

  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<LoginScreen> {
  late String email;
  late String password;
  final _auth = FirebaseAuth.instance;
  bool spinner = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: ModalProgressHUD(
        inAsyncCall: spinner,
        child: Padding(
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
                    keyboardType: TextInputType.emailAddress,
                    borderColor: Colors.lightBlueAccent,
                    hintText: 'Enter e-mail',
                    onChange: (value) {
                      email = value;
                    },
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  AuthInput(
                    isObscureText: true,
                    borderColor: Colors.lightBlueAccent,
                    hintText: 'Enter password',
                    onChange: (value) {
                      password = value;
                    },
                  ),
                  const SizedBox(
                    height: 24.0,
                  ),
                  Hero(
                    tag: 'loginButton',
                    child: AuthButton(
                      pressed: () async {
                        setState(() {
                          spinner = true;
                        });
                        try {
                          await _auth.signInWithEmailAndPassword(
                            email: email,
                            password: password,
                          );
                          email = "";
                          password = "";
                          Navigator.pushNamed(context, ChatScreen.id);
                        } catch (e) {
                          print(e);
                        }
                        setState(() {
                          spinner = false;
                        });
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
      ),
    );
  }
}

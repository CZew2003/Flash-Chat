import 'dart:io';

import 'package:flash_chat/screens/chat_screen.dart';
import 'package:flash_chat/services/firebase_storage_manager.dart';
import 'package:flutter/material.dart';
import 'package:flash_chat/widgets/auth_button.dart';
import 'package:flash_chat/widgets/auth_input.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:image_picker/image_picker.dart';
import 'package:fluttertoast/fluttertoast.dart';

class RegistrationScreen extends StatefulWidget {
  static String id = "/register_screen";

  const RegistrationScreen({super.key});

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  late String email;
  late String password;
  final _auth = FirebaseAuth.instance;
  bool spinner = false;

  XFile? _image;
  final picker = ImagePicker();

  final firebaseStorageManager = FirebaseStorageManager();

  Future getImageFromGallery() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    setState(() {
      if (pickedFile != null) {
        _image = pickedFile;
      } else {
        return;
      }
    });
    print(_image!.path);
  }

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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      GestureDetector(
                        onTap: () async {
                          await getImageFromGallery();
                        },
                        child: SizedBox(
                          child: ClipOval(
                            child: _image != null
                                ? Image.file(
                                    File(_image!.path),
                                    width:
                                        MediaQuery.of(context).size.width * 0.3,
                                    height:
                                        MediaQuery.of(context).size.width * 0.3,
                                    fit: BoxFit.cover,
                                  )
                                : Image.asset(
                                    'images/avatar.webp',
                                    width:
                                        MediaQuery.of(context).size.width * 0.3,
                                    height:
                                        MediaQuery.of(context).size.width * 0.3,
                                    fit: BoxFit.cover,
                                  ),
                          ),
                        ),
                      ),
                      Hero(
                        tag: 'logo',
                        child: SizedBox(
                          height: 200,
                          child: Image.asset('images/logo.png'),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 50,
                  ),
                  AuthInput(
                    keyboardType: TextInputType.emailAddress,
                    borderColor: Colors.blueAccent,
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
                    borderColor: Colors.blueAccent,
                    hintText: 'Enter password',
                    onChange: (value) {
                      password = value;
                    },
                  ),
                  const SizedBox(
                    height: 24.0,
                  ),
                  Hero(
                    tag: 'registerButton',
                    child: AuthButton(
                      pressed: () async {
                        setState(() {
                          spinner = true;
                        });
                        try {
                          if (_image != null) {
                            await firebaseStorageManager.uploadImage(_image!);
                          } else {
                            Fluttertoast.showToast(
                              msg: 'Imaginea nu a fost incarcata',
                              toastLength: Toast.LENGTH_SHORT,
                            );
                            throw "imaginea nu a fost incarcata";
                          }
                          UserCredential userCredential =
                              await _auth.createUserWithEmailAndPassword(
                            email: email,
                            password: password,
                          );
                          await userCredential.user
                              ?.updatePhotoURL(firebaseStorageManager.imageUrl);
                          email = "";
                          password = "";
                          _image = null;
                          Navigator.pushNamed(context, ChatScreen.id);
                        } catch (e) {
                          print(e);
                        }
                        setState(() {
                          spinner = false;
                        });
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
      ),
    );
  }
}

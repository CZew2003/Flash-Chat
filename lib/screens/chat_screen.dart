import 'package:flash_chat/widgets/stream_messages.dart';
import 'package:flutter/material.dart';
import 'package:flash_chat/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ChatScreen extends StatefulWidget {
  static String id = "/chat_screen";

  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final _auth = FirebaseAuth.instance;
  late User loggedInUser;
  String message = "";
  final _firestore = FirebaseFirestore.instance;
  final messageTextController = TextEditingController();

  void getUser() {
    final user = _auth.currentUser;
    if (user != null) {
      loggedInUser = user;
    }
  }

  @override
  void initState() {
    super.initState();
    getUser();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.lightBlueAccent,
        title: const Text('⚡️Chat'),
        leading: null,
        actions: [
          IconButton(
            onPressed: () {
              _auth.signOut();
              Navigator.pop(context);
            },
            icon: const Icon(Icons.close),
          ),
        ],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          StreamMessages(
            usersEmail: loggedInUser.email ?? "",
          ),
          Container(
            decoration: kMessageContainerDecoration,
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: messageTextController,
                    style: const TextStyle(
                      color: Colors.black,
                    ),
                    decoration: kMessageTextFieldDecoration,
                    onChanged: (value) {
                      message = value;
                    },
                  ),
                ),
                TextButton(
                  onPressed: () {
                    messageTextController.clear();
                    if (message != "") {
                      _firestore.collection('messages').add({
                        'message': message,
                        'sender': loggedInUser.email,
                        'time': Timestamp.now(),
                      });
                    }
                    message = "";
                  },
                  child: const Text(
                    'Send',
                    style: kSendButtonTextStyle,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

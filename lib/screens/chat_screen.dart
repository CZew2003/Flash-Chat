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

  void getUser() {
    final user = _auth.currentUser;
    if (user != null) {
      loggedInUser = user;
    }
  }

  void getMessages() async {
    final messages = await _firestore.collection('messages').get();
    for (var message in messages.docs) {
      print(message.data());
    }
  }

  void messagesStream() async {
    await for (var snapshot in _firestore.collection('messages').snapshots()) {
      for (var message in snapshot.docs) {
        print(message.data());
      }
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
              // _auth.signOut();
              // Navigator.pop(context);
              messagesStream();
            },
            icon: const Icon(Icons.close),
          ),
        ],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          StreamBuilder<QuerySnapshot>(
              stream: _firestore.collection('messages').snapshots(),
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return Text('Something went wrong');
                }

                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
                final documents = snapshot.data!.docs;
                List<Text> messageWidgets = [];
                for (var document in documents) {
                  Map<String, dynamic> data =
                      document.data() as Map<String, dynamic>;
                  final message = data['message'];
                  final sender = data['sender'];
                  messageWidgets.add(
                    Text('$message from $sender'),
                  );
                }
                return Column(
                  children: messageWidgets,
                );
              }),
          Container(
            decoration: kMessageContainerDecoration,
            child: Row(
              children: [
                Expanded(
                  child: TextField(
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
                    _firestore.collection('messages').add({
                      'message': message,
                      'sender': loggedInUser.email,
                    });
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

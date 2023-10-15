import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flash_chat/widgets/message_bubble.dart';

class StreamMessages extends StatelessWidget {
  StreamMessages({
    super.key,
    required this.usersEmail,
  });

  final String usersEmail;
  final _firestore = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: _firestore.collection('messages').orderBy('time').snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return const Text('Something went wrong');
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        final documents = snapshot.data!.docs.reversed;
        List<MessageBubble> messageWidgets = [];
        for (var document in documents) {
          Map<String, dynamic> data = document.data() as Map<String, dynamic>;
          final message = data['message'];
          final sender = data['sender'];
          messageWidgets.add(
            MessageBubble(
              message: message,
              sender: sender,
              usersMessage: sender == usersEmail,
            ),
          );
        }
        return Expanded(
          child: ListView(
            reverse: true,
            padding:
                const EdgeInsets.symmetric(horizontal: 10.0, vertical: 20.0),
            children: messageWidgets,
          ),
        );
      },
    );
  }
}

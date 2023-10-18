import 'package:flutter/material.dart';

class MessageContainer extends StatelessWidget {
  const MessageContainer({
    super.key,
    required this.message,
    required this.sender,
    required this.usersMessage,
  });

  final bool usersMessage;
  final String message;
  final String sender;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment:
          usersMessage ? CrossAxisAlignment.end : CrossAxisAlignment.start,
      children: [
        Text(
          sender.split('@')[0],
          style: const TextStyle(
            color: Colors.black54,
            fontSize: 12,
          ),
        ),
        Material(
          elevation: 5,
          color: usersMessage ? Colors.lightBlueAccent : Colors.blueAccent,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(usersMessage ? 30.0 : 0),
              topRight: Radius.circular(!usersMessage ? 30.0 : 0),
              bottomLeft: const Radius.circular(30.0),
              bottomRight: const Radius.circular(30.0)),
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 20.0,
              vertical: 10.0,
            ),
            child: Text(
              message,
              overflow: TextOverflow.clip,
              style: const TextStyle(
                fontSize: 15,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

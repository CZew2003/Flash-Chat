import 'package:flutter/material.dart';
import 'message_container.dart';

class MessageBubble extends StatelessWidget {
  const MessageBubble({
    super.key,
    required this.message,
    required this.sender,
    required this.usersMessage,
    required this.profileImage,
  });

  final bool usersMessage;
  final String message;
  final String sender;
  final String? profileImage;

  List<Widget> getWidgets() {
    List<Widget> elements = [];
    elements.add(Expanded(
      child: MessageContainer(
          message: message, sender: sender, usersMessage: usersMessage),
    ));
    if (profileImage != null) {
      elements.insert(
        usersMessage ? 1 : 0,
        Padding(
          padding: EdgeInsets.only(
            left: usersMessage ? 5.0 : 0,
            right: !usersMessage ? 5.0 : 0,
          ),
          child: ClipOval(
            child: Image.network(
              profileImage!,
              width: 40,
              height: 40,
              fit: BoxFit.cover,
            ),
          ),
        ),
      );
    }
    return elements;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment:
            usersMessage ? MainAxisAlignment.end : MainAxisAlignment.start,
        textBaseline: TextBaseline.ideographic,
        children: getWidgets(),
      ),
    );
  }
}

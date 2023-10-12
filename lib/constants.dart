import 'package:flutter/material.dart';

const kTitleTextBig = TextStyle(
  fontSize: 50,
  fontWeight: FontWeight.w900,
  color: Colors.black,
  shadows: [
    Shadow(
      blurRadius: 20.0,
      color: Colors.black54,
      offset: Offset(0, 0),
    ),
  ],
);

const kAuthButtonTextSTyle = TextStyle(
  color: Colors.white,
  fontSize: 18.0,
);

const kSendButtonTextStyle = TextStyle(
  color: Colors.lightBlueAccent,
  fontWeight: FontWeight.bold,
  fontSize: 18.0,
);

const kMessageTextFieldDecoration = InputDecoration(
  contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
  hintText: 'Type your message here...',
  border: InputBorder.none,
);

const kMessageContainerDecoration = BoxDecoration(
  border: Border(
    top: BorderSide(color: Colors.lightBlueAccent, width: 2.0),
  ),
);

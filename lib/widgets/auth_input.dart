import 'package:flutter/material.dart';

class AuthInput extends StatelessWidget {
  const AuthInput({
    super.key,
    required this.borderColor,
    required this.hintText,
    required this.onChange,
  });

  final String hintText;
  final Function(String) onChange;
  final Color borderColor;

  @override
  Widget build(BuildContext context) {
    return TextField(
      onChanged: onChange,
      style: const TextStyle(
        color: Colors.black,
      ),
      decoration: InputDecoration(
        hintText: hintText,
        contentPadding:
            const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
        hintStyle: const TextStyle(
          color: Colors.grey,
        ),
        border: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(30.0)),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: borderColor, width: 1.5),
          borderRadius: const BorderRadius.all(
            Radius.circular(30.0),
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: borderColor, width: 2.5),
          borderRadius: const BorderRadius.all(
            Radius.circular(30.0),
          ),
        ),
      ),
    );
  }
}

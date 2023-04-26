import 'package:flutter/material.dart';

class ChatItem extends StatelessWidget {
  final String message;
  const ChatItem({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    return Text(message);
  }
}

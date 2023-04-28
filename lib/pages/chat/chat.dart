import 'package:flutter/material.dart';
import 'package:flutter_chatgpt/views/comm/app_bar.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class ChatPage extends StatefulHookConsumerWidget {
  const ChatPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ChatPageState();
}
class _ChatPageState extends ConsumerState<ChatPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PageBar(context,title: "Chat",),
    );
  }
}
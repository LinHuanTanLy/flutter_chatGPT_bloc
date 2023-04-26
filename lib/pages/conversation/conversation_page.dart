import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_chatgpt/bloc/conversation/conversation_bloc.dart';

class ConversationPage extends StatefulWidget {
  const ConversationPage({Key? key}) : super(key: key);

  @override
  State<ConversationPage> createState() => _ConversationPageState();
}

class _ConversationPageState extends State<ConversationPage> {
  @override
  void initState() {
    BlocProvider.of<ConversationBloc>(context).add(LoadConversationsEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<ConversationBloc, ConversationState>(builder: (c, s) {
        if (s.runtimeType == ConversationLoaded) {
          return ListView.builder(
            itemBuilder: (c, i) {
              return ListTile(
                title: Text(s.conversations[i].name),
              );
            },
            itemCount: s.conversations.length,
          );
        } else {
          return const Text('empty');
        }
      }),
    );
  }
}

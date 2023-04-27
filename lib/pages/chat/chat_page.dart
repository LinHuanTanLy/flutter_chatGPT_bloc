import 'dart:async';
import 'package:dart_openai/openai.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_chatgpt/bloc/conversation/conversation_bloc.dart';
import 'package:flutter_chatgpt/bloc/message/message_bloc.dart';
import 'package:flutter_chatgpt/enum/role/role_enum.dart';
import 'package:flutter_chatgpt/repository/model/conversation.dart';
import 'package:flutter_chatgpt/repository/model/message.dart';

import 'package:flutter_chatgpt/views/comm/assets_image.dart';
import 'package:go_router/go_router.dart';
import 'package:uuid/uuid.dart';

import 'widget/chat_item.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({super.key});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  TextEditingController textEditingController = TextEditingController();
  ScrollController scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    Widget messageWidget =
        BlocBuilder<MessageBloc, MessageState>(builder: (context, state) {
      if (state.runtimeType == MessageLoaded) {
        var currState = state as MessageLoaded;
        WidgetsBinding.instance.addPostFrameCallback((_) {
          _scrollToNewMessage();
        });

        ///loadSuc
        return ListView.separated(
          controller: scrollController,
          padding:
              const EdgeInsets.only(top: 12, left: 6, right: 6, bottom: 12),
          itemBuilder: ((context, index) {
            return ChatItem(
              message: currState.message[index].text,
              isMe: currState.message[index].role == Role.user,
            );
          }),
          itemCount: currState.message.length,
          separatorBuilder: (BuildContext context, int index) => const SizedBox(
            height: 12,
          ),
        );
      } else {
        /// loadEmpty or error
        return const Text('empty');
      }
    });
    Widget inputWidget = Container(
      color: const Color(0xfff6f6f6),
      height: 60 + MediaQuery.of(context).padding.bottom,
      padding: EdgeInsets.only(bottom: MediaQuery.of(context).padding.bottom),
      child: Row(
        children: [
          Expanded(
            child: Container(
              margin: const EdgeInsets.only(left: 12),
              padding: const EdgeInsets.only(left: 6, right: 6),
              height: 40,
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(6)),
              child: TextField(
                controller: textEditingController,
                showCursor: true,
                scrollPadding: EdgeInsets.zero,
                decoration: const InputDecoration(
                  border: InputBorder.none,
                  hintText: "你想聊什么",
                  hintStyle: TextStyle(
                      fontSize: 15, color: Color.fromRGBO(0, 0, 0, 0.40)),
                ),
              ),
            ),
          ),
          InkWell(
            onTap: _sendMessage,
            child: Container(
              padding: const EdgeInsets.only(right: 12, left: 16),
              child: const AssetsImageWidget(
                assets: 'send.png',
                width: 24,
                height: 24,
              ),
            ),
          ),
        ],
      ),
    );

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xffEDEDED),
        elevation: 0.1,
        leading: InkWell(
          onTap: context.pop,
          child: Container(
            alignment: Alignment.centerLeft,
            padding: const EdgeInsets.only(left: 12),
            child: const AssetsImageWidget(
              assets: 'back.png',
              height: 20,
              fit: BoxFit.cover,
              alignment: Alignment.center,
            ),
          ),
        ),
      ),
      backgroundColor: const Color(0xffEDEDED),
      body: Column(
        children: [Expanded(child: messageWidget), inputWidget],
      ),
    );
  }

  void _scrollToNewMessage() {
    if (scrollController.hasClients) {
      scrollController.jumpTo(scrollController.position.maxScrollExtent);
    }
  }

  void _sendMessage() {
    final String message = textEditingController.text;
    if (message.isNotEmpty) {
      var conversationUuid =
          context.read<ConversationBloc>().state.currentConversationUuid;
      if (conversationUuid.isEmpty) {
        conversationUuid = _newConversationUuid(message, message);
      }
      final newMessage = Message(
          conversationId: conversationUuid, text: message, role: Role.user);
      context.read<MessageBloc>().add(SendMessageEvent(newMessage));
      textEditingController.text = "";
    }
  }

  String _newConversationUuid(String name, String description) {
    var conversation = Conversation(
        name: name, description: description, uuid: const Uuid().v4());
    BlocProvider.of<ConversationBloc>(context)
        .add(AddConversationEvent(conversation));
    return conversation.uuid;
  }
}

import 'package:dart_openai/openai.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chatgpt/conf/conf.dart';
import 'package:flutter_chatgpt/cubit/setting_cubit.dart';
import 'package:flutter_chatgpt/enum/role/role_enum.dart';
import 'package:flutter_chatgpt/repository/db/conversation_db.dart';
import 'package:flutter_chatgpt/repository/model/message.dart';
import 'package:get_it/get_it.dart';

class MessageRepository {
  static final MessageRepository _instance = MessageRepository._internal();

  factory MessageRepository() {
    return _instance;
  }

  MessageRepository._internal() {
    init();
  }
  void init() {
    OpenAI.apiKey = Config.key;
    OpenAI.baseUrl = Config.baseUrl;
  }

  void postMessage(Message message,
      {required ValueChanged<Message> onResponse,
      required ValueChanged<Message> onError,
      required ValueChanged<Message> onSuccess}) async {
    List<Message> messages = await ConversationDb()
        .getMessagesByConversationUUid(message.conversationId);
    _getResponseFromGPT(messages,
        onResponse: onResponse, onError: onError, onSuccess: onSuccess);
  }

  void _getResponseFromGPT(List<Message> messages,
      {required ValueChanged<Message> onResponse,
      required ValueChanged<Message> onError,
      required ValueChanged<Message> onSuccess}) async {
    List<OpenAIChatCompletionChoiceMessageModel> openAIMessages = messages
        .map((message) => OpenAIChatCompletionChoiceMessageModel(
              content: message.text,
              role: OpenAIChatMessageRole.user,
            ))
        .toList();
    var message = Message(
        conversationId: messages.first.conversationId,
        text: "",
        role: Role.assistant);
    if (GetIt.instance.get<SettingCubit>().state.ifStream) {
      Stream<OpenAIStreamChatCompletionModel> chatStream = OpenAI.instance.chat
          .createStream(model: 'gpt-3.5-turbo', messages: openAIMessages);
      chatStream.listen((event) {
        if (event.choices.first.delta.content != null) {
          message.text = message.text + event.choices.first.delta.content!;
          debugPrint("message.text is ${message.text}");
          onResponse(message);
        }
      }, onError: (error) {
        message.text = error.message;
        debugPrint("message error is ${message.text}");

        onError(message);
      }, onDone: () {
        debugPrint("message done");
        onSuccess(message);
      });
    } else {
      try {
        var response = await OpenAI.instance.chat
            .create(model: 'gpt-3.5-turbo', messages: openAIMessages);
        message.text = response.choices.first.message.content;
        onSuccess(message);
      } catch (e) {
        message.text = e.toString();
        onError(message);
      }
    }
  }
}

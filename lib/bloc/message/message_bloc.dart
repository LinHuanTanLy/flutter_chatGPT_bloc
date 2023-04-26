import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chatgpt/repository/db/conversation_db.dart';
import 'package:flutter_chatgpt/repository/model/message.dart';
import 'package:flutter_chatgpt/repository/net/message_repository.dart';

part 'message_event.dart';
part 'message_state.dart';

class MessageBloc extends Bloc<MessageEvent, MessageState> {
  MessageBloc() : super(MessageInitial()) {
    on<MessageEvent>((event, emit) async {});
    on<SendMessageEvent>((event, emit) async {
      await ConversationDb().addMessage(event.message);
      final messages = await ConversationDb()
          .getMessagesByConversationUUid(event.message.conversationId);
      emit(MessageLoaded(messages));
      final completer = Completer();

      try {
        MessageRepository().postMessage(event.message, onResponse: (message) {
          emit(MessageLoaded([...messages, message]));
        }, onError: (message) {
          emit(MessageLoaded([...messages, message]));
        }, onSuccess: (message) async {
          ConversationDb().addMessage(message);
          final messages = await ConversationDb()
              .getMessagesByConversationUUid(event.message.conversationId);
          emit(MessageLoaded(messages));
          completer.complete();
        });
      } on Exception catch (e) {
        emit(MessageError(e.toString()));
        completer.complete();
      }
      await completer.future;
    });
    on<DeleteMessageEvent>((event, emit) {
      _deleteMessage(event, emit);
    });
    on<LoadAllMessagesEvent>((event, emit) {
      _loadAllMessage(event, emit);
    });
  }

  _sendMessage(SendMessageEvent event, emit) async {
    await ConversationDb().addMessage(event.message);
    final messages = await ConversationDb()
        .getMessagesByConversationUUid(event.message.conversationId);
    emit(MessageLoaded(messages));
    final completer = Completer();

    try {
      MessageRepository().postMessage(event.message, onResponse: (message) {
        emit(MessageLoaded([...messages, message]));
      }, onError: (message) {
        emit(MessageLoaded([...messages, message]));
      }, onSuccess: (message) async {
        ConversationDb().addMessage(message);
        final messages = await ConversationDb()
            .getMessagesByConversationUUid(event.message.conversationId);
        emit(MessageLoaded(messages));
        completer.complete();
      });
    } on Exception catch (e) {
      emit(MessageError(e.toString()));
      completer.complete();
    }
    await completer.future;
  }

  _deleteMessage(DeleteMessageEvent event, emit) async {
    try {
      await ConversationDb().deleteMessage(event.message.id!);
      final messages = await ConversationDb()
          .getMessagesByConversationUUid(event.message.conversationId);
      emit(MessageLoaded(messages));
    } on Exception catch (e) {
      emit(MessageError(e.toString()));
    }
  }

  _loadAllMessage(LoadAllMessagesEvent event, emit) async {
    try {
      emit(MessageLoading());
      final messages = await ConversationDb()
          .getMessagesByConversationUUid(event.conversationUUid);
      emit(MessageLoaded(messages));
      if (messages.isEmpty) {
        emit(MessageInitial());
      }
    } on Exception catch (e) {
      emit(MessageError(e.toString()));
    }
  }
}

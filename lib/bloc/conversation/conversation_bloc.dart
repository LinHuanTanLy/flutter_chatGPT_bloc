import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_chatgpt/repository/db/conversation_db.dart';
import 'package:flutter_chatgpt/repository/model/conversation.dart';
part 'conversation_event.dart';
part 'conversation_state.dart';
class ConversationBloc extends Bloc<ConversationEvent, ConversationState> {
  ConversationBloc() : super(const ConversationInitial([], '')) {
    on<LoadConversationsEvent>(_onLoadConversationsEvent);

    on<DeleteConversationEvent>(_onDeleteConversationEvent);

    on<UpdateConversationEvent>(_onUpdateConversationEvent);

    on<AddConversationEvent>(_onAddConversationEventEvent);

    on<ChooseConversationEvent>(_onChooseConversationEventEvent);
  }

  Future<void> _onChooseConversationEventEvent(
      ChooseConversationEvent event, Emitter<ConversationState> emit) async {
    final conversations = await ConversationDb().getConversations();
    emit(ConversationLoaded(conversations, event.conversationUUid));
  }

  Future<void> _onLoadConversationsEvent(
      LoadConversationsEvent event, Emitter<ConversationState> emit) async {
    final conversations = await ConversationDb().getConversations();
    emit(ConversationLoaded(conversations, state.currentConversationUuid));
  }

  Future<void> _onDeleteConversationEvent(
      DeleteConversationEvent event, Emitter<ConversationState> emit) async {
    await ConversationDb().deleteConversation(event.conversation.uuid);
    final conversations = await ConversationDb().getConversations();
    emit(ConversationLoaded(conversations, ""));
  }

  Future<void> _onUpdateConversationEvent(
      UpdateConversationEvent event, Emitter<ConversationState> emit) async {
    await ConversationDb().updateConversation(event.conversation);
    final conversations = await ConversationDb().getConversations();
    emit(ConversationLoaded(conversations, event.conversation.uuid));
  }

  Future<void> _onAddConversationEventEvent(
      AddConversationEvent event, Emitter<ConversationState> emit) async {
    await ConversationDb().addConversation(event.conversation);
    final conversations = await ConversationDb().getConversations();
    emit(ConversationLoaded(conversations, event.conversation.uuid));
  }
}

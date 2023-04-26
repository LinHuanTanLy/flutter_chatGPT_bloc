part of 'conversation_bloc.dart';

abstract class ConversationEvent extends Equatable {
  const ConversationEvent();

  @override
  List<Object> get props => [];
}

class AddConversationEvent extends ConversationEvent {
  final Conversation conversation;

  const AddConversationEvent(this.conversation);
}

class DeleteConversationEvent extends ConversationEvent {
  final Conversation conversation;

  const DeleteConversationEvent(this.conversation);
  @override
  List<Object> get props => [conversation];
}

class LoadConversationsEvent extends ConversationEvent {}

class UpdateConversationEvent extends ConversationEvent {
  final Conversation conversation;

  const UpdateConversationEvent(this.conversation);
  @override
  List<Object> get props => [conversation];
}

class ChooseConversationEvent extends ConversationEvent {
  final String conversationUUid;

  const ChooseConversationEvent(this.conversationUUid);
}

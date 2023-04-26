part of 'message_bloc.dart';

@immutable
abstract class MessageState {}

class MessageInitial extends MessageState {}

class MessageLoaded extends MessageState {
  final List<Message> message;

  MessageLoaded(this.message);
}

class MessageError extends MessageState {
  final String errorMessage;

  MessageError(this.errorMessage);
}

class MessageSending extends MessageState {}

class MessageLoading extends MessageState {}

class MessageRelayingState extends MessageState {
  final Message message;

  MessageRelayingState(this.message);
}

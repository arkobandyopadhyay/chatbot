part of 'messages_cubit.dart';




abstract class MessageState extends Equatable {
  const MessageState();

  @override
  List<Object> get props => [];
}

class MessageInitial extends MessageState {
  const MessageInitial();
}

class MessageLoading extends MessageState {
  const MessageLoading();
}

class MessageSuccess extends MessageState {
  final List<MessageModel> MessageList;

  const MessageSuccess(this.MessageList);

  @override
  List<Object> get props => [MessageList];
}

class MessageError extends MessageState {
  final String message;

  const MessageError(this.message);

  @override
  List<Object> get props => [message];
}

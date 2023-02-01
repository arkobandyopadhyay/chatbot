import 'package:bloc/bloc.dart';
import 'package:chatbot/model/message.dart';
import 'package:equatable/equatable.dart';

import '../../../../core/utils/errors.dart';
import '../../../../model/complaint_model.dart';
import '../message_repository.dart';






part 'messages_state.dart';

class MessageCubit extends Cubit<MessageState> {
  final APIMessageRepository _MessageRepository;
  MessageCubit(this._MessageRepository) : super(MessageInitial());
  Future<void> getMessageList() async {
    try {
      emit(MessageLoading());
      List<MessageModel> MessageList = await _MessageRepository.getAllMessages();
      print(MessageList);
      emit(MessageSuccess(MessageList));
    } on NetworkException {
      emit(MessageError("S.networkException"));
    } on ValidationException catch (e) {
      emit(MessageError(e.description));
    } on UnknownException {
      emit(MessageError("S.unknownException"));
    } catch (e) {
      print(e);
    }
  }
}

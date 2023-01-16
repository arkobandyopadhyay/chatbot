import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import '../../../core/utils/errors.dart';
import '../signup_repository.dart';

part 'signup_user_state.dart';

class SignupCubit extends Cubit<SignupState> {
  final SignupRepository _signupRepository;
  SignupCubit(this._signupRepository) : super(SignupInitial());

  Future<void> signup(
     String email, String password,String room) async {
    try {
      emit(SignupLoading());
      await _signupRepository.signup( email, password,room);
      emit(SignupSuccess());
    } on NetworkException {
      emit(SignupError("invalid"));
    } on ValidationException catch (e) {
      emit(SignupError(e.description));
    } on UnknownException {
      emit(SignupError("error"));
    } catch (e) {
      print(e);
    }
  }
}

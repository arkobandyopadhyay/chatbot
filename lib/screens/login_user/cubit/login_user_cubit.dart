import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import '../../../core/utils/errors.dart';
import '../login_user_repository.dart';

part 'login_user_state.dart';

class LoginUserCubit extends Cubit<LoginUserState> {
  final LoginRepository _loginRepository;
  LoginUserCubit(this._loginRepository) : super(LoginInitial());
  static String? Token;

  Future<void> login(String email, String password) async {
    try {
      emit(LoginLoading());
      String? token = await (_loginRepository.login(email, password));
      Token = token;
      print(token);
      emit(LoginSuccess(token!));
    } on NetworkException {
      emit(LoginError("login error"));
    } on ValidationException catch (e) {
      emit(LoginError(e.description));
    } on ResponseException catch (e) {
      emit(LoginError(e.message));
    } on UnknownException {
      emit(LoginError("User Not Found"));
    }
  }
}

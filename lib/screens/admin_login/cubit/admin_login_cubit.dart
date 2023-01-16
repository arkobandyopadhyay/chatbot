import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import '../../../core/utils/errors.dart';
import '../login_admin_repository.dart';


part  'admin_login_state.dart';

class LoginAdminCubit extends Cubit<LoginAdminState> {
  final LoginAdminRepository _loginRepository;
  LoginAdminCubit(this._loginRepository) : super(LoginAdminInitial());
  static String? Token;

  Future<void> login(String email, String password) async {
    try {
      emit(LoginAdminLoading());
      String? token = await (_loginRepository.login(email, password));
      Token = token;
      print(token);
      emit(LoginAdminSuccess(token!));
    } on NetworkException {
      emit(LoginAdminError("login error"));
    } on ValidationException catch (e) {
      emit(LoginAdminError(e.description));
    } on ResponseException catch (e) {
      emit(LoginAdminError(e.message));
    } on UnknownException {
      emit(LoginAdminError("User Not Found"));
    }
  }
}

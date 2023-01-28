import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import '../../../core/utils/errors.dart';
import '../splash_repository.dart';

part 'splash_state.dart';

class SplashCubit extends Cubit<SplashState> {
  final SplashRepository _splashRepository;
  SplashCubit(this._splashRepository) : super(SplashLoading());

  Future<void> login() async {
    try {
      emit(SplashLoading());
       await _splashRepository.login();
      emit(SplashSuccess());
    } on NetworkException {
      emit(SplashError("login error"));
    } on ValidationException catch (e) {
      emit(SplashError(e.description));
    } on ResponseException catch (e) {
      emit(SplashError("login error"));
    } on UnknownException {
      emit(SplashError("User Not Found"));
    }
  }
}

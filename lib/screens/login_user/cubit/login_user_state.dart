part of 'login_user_cubit.dart';

@immutable
abstract class LoginUserState extends Equatable {
  const LoginUserState();

  @override
  List<Object?> get props => [];
}

// LoginScreen  implements multuiple states
// 1.Initial
class LoginInitial extends LoginUserState {
  const LoginInitial();
}

//2.Loading
class LoginLoading extends LoginUserState {
  const LoginLoading();
}

//3.Success
class LoginSuccess extends LoginUserState {
  final String token;

  const LoginSuccess(this.token);
  @override
  List<Object> get props => [token];
}

//4.Error
class LoginError extends LoginUserState {
  final String? message;
  const LoginError(this.message);
  @override
  List<Object?> get props => [message];
}

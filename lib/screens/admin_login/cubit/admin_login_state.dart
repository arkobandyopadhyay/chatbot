part of 'admin_login_cubit.dart';



@immutable
abstract class LoginAdminState extends Equatable {
  const LoginAdminState();

  @override
  List<Object?> get props => [];
}

// LoginScreen  implements multuiple states
// 1.Initial
class LoginAdminInitial extends LoginAdminState {
  const LoginAdminInitial();
}

//2.Loading
class LoginAdminLoading extends LoginAdminState {
  const LoginAdminLoading();
}

//3.Success
class LoginAdminSuccess extends LoginAdminState {
  final String token;

  const LoginAdminSuccess(this.token);
  @override
  List<Object> get props => [token];
}

//4.Error
class LoginAdminError extends LoginAdminState {
  final String? message;
  const LoginAdminError(this.message);
  @override
  List<Object?> get props => [message];
}

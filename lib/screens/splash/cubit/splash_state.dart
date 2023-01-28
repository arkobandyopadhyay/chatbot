part of 'splash_cubit.dart';

abstract class SplashState extends Equatable {
  const SplashState();

  @override
  List<Object> get props => [];
}

class SplashLoading extends SplashState {
  const SplashLoading();
}

class SplashSuccess extends SplashState {
 
  const SplashSuccess();
  
}

class SplashError extends SplashState {
  final String message;
  const SplashError(this.message);
  @override
  List<Object> get props => [message];
}

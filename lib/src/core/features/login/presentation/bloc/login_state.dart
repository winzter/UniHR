part of 'login_bloc.dart';

abstract class LoginState extends Equatable {
  const LoginState();
}

class LoginInitial extends LoginState {
  @override
  List<Object> get props => [];
}

class LoginStateLoading extends LoginState{
  @override
  List<Object?> get props => [];
}

class LoginStateSuccess extends LoginState{
  final LoginEntity loginEntity;
  final bool isLogin;

  const LoginStateSuccess({required this.loginEntity,required this.isLogin,});

  @override
  List<Object?> get props => [loginEntity];
}

class LoginStateFailure extends LoginState{
  final ErrorMessage error;

  const LoginStateFailure({required this.error});

  @override
  List<Object?> get props => [error];
}

part of 'login_cubit.dart';


final class LoginState {}

final class LoginInitial extends LoginState {}

final class LoginLoading extends LoginState {}

final class LoginSuccess extends LoginState {}

final class LoginFailure extends LoginState {
   String errorMessage;
  LoginFailure({required this.errorMessage});
}

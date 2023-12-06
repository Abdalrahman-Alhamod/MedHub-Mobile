part of 'logout_cubit.dart';


final class LogoutState {}

final class LogoutInitial extends LogoutState {}

final class LogoutLoading extends LogoutState {}

final class LogoutSuccess extends LogoutState {}

final class LogoutFailure extends LogoutState {
  String errorMessage;
  LogoutFailure({required this.errorMessage});
}

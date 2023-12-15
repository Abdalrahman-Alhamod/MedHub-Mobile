part of 'user_cubit.dart';

final class UserState {}

final class UserInitial extends UserState {}

final class UserFetchLoading extends UserState {}

final class UserFetchSuccess extends UserState {
  User user;
  UserFetchSuccess({required this.user});
}

final class UserFetchFailure extends UserState {
  String errorMessage;
  UserFetchFailure({required this.errorMessage});
}

final class UserNetworkFailure extends UserState {
  String errorMessage;
  UserNetworkFailure({required this.errorMessage});
}

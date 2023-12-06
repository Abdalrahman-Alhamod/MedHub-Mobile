part of 'register_cubit.dart';

final class RegisterState {}

final class RegisterInitial extends RegisterState {}

final class RegisterLoading extends RegisterState {}

final class RegisterSuccess extends RegisterState {}

final class RegisterFailure extends RegisterState {
  String errorMessage;
  RegisterFailure({required this.errorMessage});
}

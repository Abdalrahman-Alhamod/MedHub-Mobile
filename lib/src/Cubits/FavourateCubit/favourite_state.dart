part of 'favourite_cubit.dart';

final class FavouriteState {}

final class FavouriteInitial extends FavouriteState {}

final class FavourateToggleLoading extends FavouriteState {}

final class FavourateToggleSuccess extends FavouriteState {}

final class FavoureteToggleFailure extends FavouriteState {
  String errorMessage;
  FavoureteToggleFailure({required this.errorMessage});
}

final class NetworkFailure extends FavouriteState {
  String errorMessage;
  NetworkFailure({required this.errorMessage});
}

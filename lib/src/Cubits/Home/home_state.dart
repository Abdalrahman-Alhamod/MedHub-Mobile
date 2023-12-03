part of 'home_cubit.dart';

final class HomeState {}

final class HomeInitial extends HomeState {}

final class HomeProductsFetchLoading extends HomeState {}

final class HomeProductsFetchSucess extends HomeState {
  List<Product> mostPopular, recentlyAdded;
  HomeProductsFetchSucess(
      {required this.mostPopular, required this.recentlyAdded});
}

final class HomeProductsFetchFailure extends HomeState {
  String errorMessage;
  HomeProductsFetchFailure({required this.errorMessage});
}

final class HomeNetworkFailure extends HomeState {
  String errorMessage;
  HomeNetworkFailure({required this.errorMessage});
}

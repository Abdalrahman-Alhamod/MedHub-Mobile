part of 'cart_cubit.dart';

class CartState {}

final class CartInitial extends CartState {}

final class CartAddLoading extends CartState {}

final class CartAddSuccess extends CartState {}

final class CartAddFailure extends CartState {}

final class CartProductsChange extends CartState {}

final class CartPurchaseLoading extends CartState {}

final class CartPurchaseSuccess extends CartState {}

final class CartPurchaseFailure extends CartState {
  String errorMessage;
  CartPurchaseFailure({required this.errorMessage});
}

final class CartNetworkFailure extends CartState {
  String errorMessage;
  CartNetworkFailure({required this.errorMessage});
}

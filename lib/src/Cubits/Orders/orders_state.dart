part of 'orders_cubit.dart';

final class OrdersState {}

final class OrdersInitial extends OrdersState {}

final class OrdersFetchLoading extends OrdersState {}

final class OrdersFetchSuccess extends OrdersState {
  List<Order> orders;
  OrdersFetchSuccess({required this.orders});
}

final class OrdersFetchFailure extends OrdersState {
  String errorMessage;
  OrdersFetchFailure({required this.errorMessage});
}

final class OrdersNetworkFailure extends OrdersState {
  String errorMessage;
  OrdersNetworkFailure({required this.errorMessage});
}

final class OrdersFetchEmpty extends OrdersState {}

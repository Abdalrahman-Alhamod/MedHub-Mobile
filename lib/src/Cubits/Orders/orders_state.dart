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

final class OrderFetchLoading extends OrdersState {}

final class OrderFetchSuccess extends OrdersState {
  Order order;
  OrderFetchSuccess({required this.order});
}

final class OrderFetchFailure extends OrdersState {
  String errorMessage;
  OrderFetchFailure({required this.errorMessage});
}

final class OrderNetworkFailure extends OrdersState {
  String errorMessage;
  OrderNetworkFailure({required this.errorMessage});
}

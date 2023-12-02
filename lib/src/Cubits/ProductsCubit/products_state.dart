part of 'products_cubit.dart';

final class ProductsState {}

final class ProductsInitial extends ProductsState {}

final class ProductsFetchLoading extends ProductsState {}

final class ProductsFetchSuccess extends ProductsState {
  List<Product> products;
  ProductsFetchSuccess({required this.products});
}

final class ProductsFetchFailure extends ProductsState {
  String errorMessage;
  ProductsFetchFailure({required this.errorMessage});
}

final class ProductsNotFound extends ProductsState {}

final class ProductNetworkFailure extends ProductsState {
  String errorMessage;
  ProductNetworkFailure({required this.errorMessage});
}

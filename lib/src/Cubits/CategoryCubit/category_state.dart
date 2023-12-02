part of 'category_cubit.dart';

class CategoryState {}

final class CategoryInitial extends CategoryState {}

final class CategoryFetchLoading extends CategoryState {}

final class CategoryFetchSuccess extends CategoryState {
  List<Category> categories;
  CategoryFetchSuccess({required this.categories});
}

final class CategoryFetchFailure extends CategoryState {
  final String errorMessage;
  CategoryFetchFailure({required this.errorMessage});
}

final class CategoryNetworkFailure extends CategoryState {
  final String errorMessage;
  CategoryNetworkFailure({required this.errorMessage});
}

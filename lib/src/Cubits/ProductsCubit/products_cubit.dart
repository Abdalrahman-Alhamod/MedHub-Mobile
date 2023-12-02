import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logger/logger.dart';
import 'package:pharmacy_warehouse_store_mobile/core/data/app_data.dart';
import 'package:pharmacy_warehouse_store_mobile/src/model/category.dart';
import 'package:pharmacy_warehouse_store_mobile/src/model/product.dart';
part 'products_state.dart';

class SearchConstraints {
  const SearchConstraints._();
  static const String all = 'all';
  static const String name = 'name';
  static const String scientificName = 'scientificName';
  static const String brand = 'brand';
}

class ProductsCubit extends Cubit<ProductsState> {
  ProductsCubit() : super(ProductsInitial());
  String searchBarContent = "";
  Category? choosenCategory;
  
  Logger logger = Logger(printer: PrettyPrinter(printEmojis: false));

  Future<void> search() async {
    logger.i("Chooosen category name : ${choosenCategory!.name}");
    logger.i("Search bar content : $searchBarContent");
    try {
      emit(ProductsFetchLoading());
      await Future.delayed(const Duration(seconds: 2));
      List<Product> products = AppData.filteredProducts[choosenCategory!.id];
      if (products.isEmpty) {
        emit(ProductsNotFound());
      } else {
        emit(ProductsFetchSuccess(products: products));
      }
    } on DioException catch (exception) {
      emit(ProductNetworkFailure(errorMessage: exception.message.toString()));
    } catch (e) {
      emit(ProductsFetchFailure(errorMessage: e.toString()));
    }
  }

  Future<void> getMostPopular() async {
    try {
      emit(ProductsFetchLoading());
      await Future.delayed(const Duration(seconds: 2));
      List<Product> products = AppData.products;
      emit(ProductsFetchSuccess(products: products));
    } on DioException catch (exception) {
      emit(ProductNetworkFailure(errorMessage: exception.message.toString()));
    } catch (e) {
      emit(ProductsFetchFailure(errorMessage: e.toString()));
    }
  }

  Future<void> getFavourates() async {
    try {
      emit(ProductsFetchLoading());
      await Future.delayed(const Duration(seconds: 2));
      List<Product> products = AppData.products;
      if (products.isEmpty) {
        emit(ProductsNotFound());
      } else {
        emit(ProductsFetchSuccess(products: products));
      }
    } on DioException catch (exception) {
      emit(ProductNetworkFailure(errorMessage: exception.message.toString()));
    } catch (e) {
      emit(ProductsFetchFailure(errorMessage: e.toString()));
    }
  }
}

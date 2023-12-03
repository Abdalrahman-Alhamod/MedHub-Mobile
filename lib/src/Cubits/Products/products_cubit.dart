import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pharmacy_warehouse_store_mobile/core/data/app_data.dart';
import 'package:pharmacy_warehouse_store_mobile/main.dart';
import 'package:pharmacy_warehouse_store_mobile/src/model/category.dart';
import 'package:pharmacy_warehouse_store_mobile/src/model/product.dart';
part 'products_state.dart';

class SearchConstraints {
  const SearchConstraints._();
  static const String name = 'name';
  static const String scientificName = 'scientificName';
  static const String description = 'description';
  static const String brand = 'brand';
}

class ProductsCubit extends Cubit<ProductsState> {
  ProductsCubit() : super(ProductsInitial());
  String searchBarContent = "";
  Category? choosenCategory;
  String searchByConstraints = SearchConstraints.name;

  Future<void> search() async {
    logger.i(
        "Product Cubit Search : \nChooosen category name : ${choosenCategory!.name} \nSearch bar content : $searchBarContent \nSearch By constraints : $searchByConstraints");
    try {
      emit(ProductsFetchLoading());
      await Future.delayed(const Duration(seconds: 2));
      List<Product> products = AppData.filteredProducts[choosenCategory!.id];
      if (products.isEmpty) {
        emit(ProductsNotFound());
        logger.e("Product Cubit Search : \nProduct Not Found");
      } else {
        emit(ProductsFetchSuccess(products: products));
      }
    } on DioException catch (exception) {
      logger
          .e("Product Cubit Search : \nNetwork Failure \n${exception.message}");
      emit(ProductNetworkFailure(errorMessage: exception.message.toString()));
    } catch (e) {
      logger.e("Product Cubit Search : \nFetch Failure \n$e");
      emit(ProductsFetchFailure(errorMessage: e.toString()));
    }
  }

  Future<void> getFavourites() async {
    try {
      emit(ProductsFetchLoading());
      await Future.delayed(const Duration(seconds: 2));
      List<Product> products = AppData.products;
      if (products.isEmpty) {
        emit(ProductsNotFound());
        logger.e("Product Cubit Favourite : \nProduct Not Found");
      } else {
        emit(ProductsFetchSuccess(products: products));
      }
    } on DioException catch (exception) {
      logger.e(
          "Product Cubit Favourite : \nNetwork Failure \n${exception.message}");
      emit(ProductNetworkFailure(errorMessage: exception.message.toString()));
    } catch (e) {
      logger.e("Product Cubit Favourite : \nFetch Failure \n$e");
      emit(ProductsFetchFailure(errorMessage: e.toString()));
    }
  }
}

import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pharmacy_warehouse_store_mobile/core/data/app_data.dart';
import 'package:pharmacy_warehouse_store_mobile/src/model/category.dart';
import 'package:pharmacy_warehouse_store_mobile/src/model/product.dart';

part 'products_state.dart';

class ProductsCubit extends Cubit<ProductsState> {
  ProductsCubit() : super(ProductsInitial());
  String searchBarContent = "";
  Category? choosenCategory;

  Future<void> search() async {
    log("Chooosen category name : ${choosenCategory!.name}");
    log("Search bar content : $searchBarContent");
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
      emit(NetworkFailure(errorMessage: exception.message.toString()));
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
      emit(NetworkFailure(errorMessage: exception.message.toString()));
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
      emit(NetworkFailure(errorMessage: exception.message.toString()));
    } catch (e) {
      emit(ProductsFetchFailure(errorMessage: e.toString()));
    }
  }
}

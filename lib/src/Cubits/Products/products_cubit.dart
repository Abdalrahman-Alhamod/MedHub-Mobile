import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:pharmacy_warehouse_store_mobile/core/data/app_data.dart';
import 'package:pharmacy_warehouse_store_mobile/main.dart';
import 'package:pharmacy_warehouse_store_mobile/src/model/category.dart';
import 'package:pharmacy_warehouse_store_mobile/src/model/product.dart';
import 'package:pharmacy_warehouse_store_mobile/src/model/user.dart';
import 'package:pharmacy_warehouse_store_mobile/src/services/api.dart';
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
  Category choosenCategory = Category(id: 0, name: "all".tr);
  String searchByConstraints = SearchConstraints.name;

  Future<void> search() async {
    logger.i(
        "Product Cubit Search : \nChooosen category name : ${choosenCategory.name} \nSearch bar content : $searchBarContent \nSearch By constraints : $searchByConstraints");
    try {
      emit(ProductsFetchLoading());

      String endpoint = '';
      if (searchBarContent == "" && choosenCategory.name == "all".tr) {
        endpoint = '/medicines/list';
      } else if (searchBarContent == "" && choosenCategory.name != "all".tr) {
        endpoint = '/categories/${choosenCategory.id}';
      }

      // Fetch Searched Products from API
      // Map<String, dynamic> productsJsonData = await Api.request(
      //     url: endpoint,
      //     body: {},
      //     token: User.token,
      //     methodType: MethodType.get) as Map<String, dynamic>;
      // List<Product> products = Product.fromListJson(productsJsonData);

      await Future.delayed(const Duration(seconds: 2));
      List<Product> products = AppData.filteredProducts[choosenCategory.id];
      if (products.isEmpty) {
        emit(ProductsNotFound());
        logger.e("Product Cubit Search : \nProduct Not Found");
      } else {
        emit(ProductsFetchSuccess(products: products));
      }
    } on DioException catch (exception) {
      logger.e("Product Cubit Search : \nNetwork Failure");
      emit(ProductNetworkFailure(errorMessage: exception.message.toString()));
    } catch (e) {
      logger.e("Product Cubit Search : \nFetch Failure");
      emit(ProductsFetchFailure(errorMessage: e.toString()));
    }
  }

  Future<void> getFavourites() async {
    try {
      emit(ProductsFetchLoading());

      // Fetch Favourite Products from API
      // Map<String, dynamic> favouriteJsonData = await Api.request(
      //     url: '/medicines/user/favourites',
      //     body: {},
      //     token: User.token,
      //     methodType: MethodType.get) as Map<String, dynamic>;
      // List<Product> favouriteProducts = Product.fromListJson(favouriteJsonData);

      await Future.delayed(const Duration(seconds: 2));
      List<Product> favouriteProducts = AppData.products;
      if (favouriteProducts.isEmpty) {
        emit(ProductsNotFound());
        logger.e("Product Cubit Favourite : \nProduct Not Found");
      } else {
        emit(ProductsFetchSuccess(products: favouriteProducts));
      }
    } on DioException catch (exception) {
      logger.e("Product Cubit Favourite : \nNetwork Failure ");
      emit(ProductNetworkFailure(errorMessage: exception.message.toString()));
    } catch (e) {
      logger.e("Product Cubit Favourite : \nFetch Failure ");
      emit(ProductsFetchFailure(errorMessage: e.toString()));
    }
  }
}

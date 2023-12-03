import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pharmacy_warehouse_store_mobile/core/data/app_data.dart';
import 'package:pharmacy_warehouse_store_mobile/src/model/product.dart';
part 'home_state.dart';

class HomeProductsType {
  const HomeProductsType._();
  static const mostPopular = "Most Popular";
  static const recentlyAdded = "Recently Added";
}

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeInitial());

  Future<void> getHomeProducts() async {
    try {
      emit(HomeProductsFetchLoading());
      await Future.delayed(const Duration(seconds: 2));
      List<Product> products = AppData.products;
      emit(HomeProductsFetchSucess(
          mostPopular: products, recentlyAdded: products));
    } on DioException catch (exception) {
      emit(HomeNetworkFailure(errorMessage: exception.message.toString()));
    } catch (e) {
      emit(HomeProductsFetchFailure(errorMessage: e.toString()));
    }
  }
}

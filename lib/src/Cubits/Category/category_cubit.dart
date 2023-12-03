import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pharmacy_warehouse_store_mobile/core/data/app_data.dart';
import 'package:pharmacy_warehouse_store_mobile/src/model/category.dart';

part 'category_state.dart';

class CategoryCubit extends Cubit<CategoryState> {
  CategoryCubit() : super(CategoryInitial());
  Future<void> getCategories() async {
    try {
      emit(CategoryFetchLoading());
      await Future.delayed(const Duration(seconds: 2));
      List<Category> categories = AppData.categories;
      // Api.request(
      //     url: '/category',
      //     body: {},
      //     token: User.token,
      //     methodType: MethodType.get);
      //categories.insert(0, Category(id: 0, name: "all".tr));
      emit(CategoryFetchSuccess(categories: categories));
    } on DioException catch (exception) {
      emit(CategoryNetworkFailure(errorMessage: exception.message.toString()));
    } catch (e) {
      emit(CategoryFetchFailure(errorMessage: e.toString()));
    }
  }
}

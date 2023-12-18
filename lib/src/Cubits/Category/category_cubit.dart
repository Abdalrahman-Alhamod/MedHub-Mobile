import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:pharmacy_warehouse_store_mobile/main.dart';
import 'package:pharmacy_warehouse_store_mobile/src/model/category.dart';
import 'package:pharmacy_warehouse_store_mobile/src/model/user.dart';
import 'package:pharmacy_warehouse_store_mobile/src/services/api.dart';

part 'category_state.dart';

class CategoryCubit extends Cubit<CategoryState> {
  CategoryCubit() : super(CategoryInitial());
  List<Category>? currentCategories;
  Future<void> getCategories() async {
    try {
      emit(CategoryFetchLoading());

      // Fetch Categories from API
      Map<String, dynamic> categoriesJsonData = await Api.request(
          url: 'api/categories',
          body: {},
          token: User.token,
          methodType: MethodType.get) as Map<String, dynamic>;
      List<Category> categories = Category.fromListJson(categoriesJsonData);
      currentCategories = categories;
      categories.insert(0, Category(id: 0, name: "All".tr));

      // await Future.delayed(const Duration(seconds: 2));
      // List<Category> categories = AppData.categories;
      emit(CategoryFetchSuccess(categories: categories));
    } on DioException catch (exception) {
      logger.e("Category Cubit Fetch : \nNetwork Failure ");
      emit(CategoryNetworkFailure(errorMessage: exception.message.toString()));
    } catch (e) {
      logger.e("Category Cubit Fetch : \nFetch Failure ");
      emit(CategoryFetchFailure(errorMessage: e.toString()));
    }
  }
}

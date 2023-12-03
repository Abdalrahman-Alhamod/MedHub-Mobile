import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pharmacy_warehouse_store_mobile/main.dart';
import 'package:pharmacy_warehouse_store_mobile/src/model/product.dart';

part 'favourite_state.dart';

class FavouriteCubit extends Cubit<FavouriteState> {
  FavouriteCubit() : super(FavouriteInitial());

  Future<void> toggleFavourate({required Product product}) async {
    try {
      emit(FavourateToggleLoading());
      // Api.request(
      //     url: '/favourate/$product.id',
      //     body: {},
      //     token: User.token,
      //     methodType: MethodType.post);
      await Future.delayed(
        const Duration(seconds: 2),
      );
      // add to favourate
      emit(FavourateToggleSuccess());
    } on DioException catch (exception) {
      logger.e("Favourite Cubit Toggle Favourite : \nNetwork Failure");
      emit(FavourateNetworkFailure(errorMessage: exception.message.toString()));
    } catch (e) {
      logger.e("Favourite Cubit Toggle Favourite : \nToggle Failure");
      emit(FavoureteToggleFailure(errorMessage: e.toString()));
    }
  }
}

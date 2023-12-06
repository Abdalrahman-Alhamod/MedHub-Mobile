import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pharmacy_warehouse_store_mobile/main.dart';
import 'package:pharmacy_warehouse_store_mobile/src/model/user.dart';
import 'package:pharmacy_warehouse_store_mobile/src/services/api.dart';

part 'logout_state.dart';

class LogoutCubit extends Cubit<LogoutState> {
  LogoutCubit() : super(LogoutInitial());
  void logout() async {
    try {
      emit(LogoutLoading());
      await Api.request(
        url: 'api/user/logout',
        body: {},
        token: User.token,
        methodType: MethodType.post,
      );
      //await Future.delayed(const Duration(seconds: 2));
      emit(LogoutSuccess());
    } on DioException catch (exception) {
      logger.e("Logout Cubit : \nNetwork Failure + ${exception.toString()}");
      emit(LogoutFailure(errorMessage: exception.message.toString()));
    } catch (e) {
      logger.e("Logout Cubit : \nGeneral Failure + ${e.toString()}");
      emit(LogoutFailure(errorMessage: e.toString()));
    }
  }
}

import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pharmacy_warehouse_store_mobile/main.dart';
import 'package:pharmacy_warehouse_store_mobile/src/model/statistics_data.dart';
import 'package:pharmacy_warehouse_store_mobile/src/model/user.dart';
import 'package:pharmacy_warehouse_store_mobile/src/services/api.dart';

part 'statistics_state.dart';

class StatisticsCubit extends Cubit<StatisticsState> {
  StatisticsCubit() : super(StatisticsInitial());
  void getStatistics({required DateTime monthChartsDate}) async {
    try {
      emit(StatisticsFetchLoading());
      Map<String, dynamic> statisticsJsonData = await Api.request(
        url: 'api/user/stat',
        body: {},
        token: User.token,
        methodType: MethodType.get,
      ) as Map<String, dynamic>;
      Map<String, dynamic> monthChartsJsonData = await Api.request(
        url: 'api/user/charts/${monthChartsDate.year}/${monthChartsDate.month}',
        body: {},
        token: User.token,
        methodType: MethodType.get,
      ) as Map<String, dynamic>;
      StatisticsData statisticsData =
          StatisticsData.fromJson(statisticsJsonData);
      statisticsData.monthChartsData = monthChartsJsonData['points'];

      emit(StatisticsFetchSuccess(statisticsData: statisticsData));
    } on DioException catch (exception) {
      logger.e("Orders Cubit : \nNetwork Failure \n${exception.message}");
      emit(
          StatisticsNetworkFailure(errorMessage: exception.message.toString()));
    } catch (e) {
      logger.e("Orders Cubit : \nFetch Failure \n$e");
      emit(StatisticsFetchFailure(errorMessage: e.toString()));
    }
  }
}

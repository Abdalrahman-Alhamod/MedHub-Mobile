import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../main.dart';
import '../../model/user.dart';
import '../../services/api.dart';

part 'report_state.dart';

class ReportCubit extends Cubit<ReportState> {
  ReportCubit() : super(ReportInitial());


  void getReport(
      {required DateTime startDate, required DateTime endDate}) async {
    try {
      emit(ReportFetchLoading());
      Map<String, dynamic> reportJsonData = await Api.request(
        url:
            'api/user/pdf/${startDate.year}/${startDate.month}/${startDate.day}/${endDate.year}/${endDate.month}/${endDate.day}',
        body: {},
        token: User.token,
        methodType: MethodType.get,
        lang: 'en',
      ) as Map<String, dynamic>;
      await launchUrl(Uri.parse(reportJsonData['file']));
      emit(ReportFetchSuccess());
    } on DioException catch (exception) {
      logger.e("Report Cubit : \nNetwork Failure \n${exception.message}");
      emit(ReportFetchNetworkFailure(
          errorMessage: exception.message.toString()));
    } catch (e) {
      logger.e("Report Cubit : \nFetch Failure \n$e");
      emit(ReportFetchFailure(errorMessage: e.toString()));
    }
  }
}

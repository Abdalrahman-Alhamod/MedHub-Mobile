part of 'report_cubit.dart';

final class ReportState {}

final class ReportInitial extends ReportState {}

final class ReportFetchLoading extends ReportState {}

final class ReportFetchSuccess extends ReportState {
}

final class ReportFetchFailure extends ReportState {
  String errorMessage;
  ReportFetchFailure({required this.errorMessage});
}

final class ReportFetchNetworkFailure extends ReportState {
  String errorMessage;
  ReportFetchNetworkFailure({required this.errorMessage});
}

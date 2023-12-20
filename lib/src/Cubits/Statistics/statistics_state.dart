part of 'statistics_cubit.dart';

final class StatisticsState {}

final class StatisticsInitial extends StatisticsState {}

final class StatisticsFetchLoading extends StatisticsState {}

final class StatisticsFetchSuccess extends StatisticsState {
  Statistics statistics;
  StatisticsFetchSuccess({required this.statistics});
}

final class StatisticsFetchFailure extends StatisticsState {
  String errorMessage;
  StatisticsFetchFailure({required this.errorMessage});
}

final class StatisticsNetworkFailure extends StatisticsState {
  String errorMessage;
  StatisticsNetworkFailure({required this.errorMessage});
}

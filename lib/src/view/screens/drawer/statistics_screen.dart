import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:pharmacy_warehouse_store_mobile/src/Cubits/Statistics/statistics_cubit.dart';
import 'package:month_year_picker/month_year_picker.dart';
import 'package:pharmacy_warehouse_store_mobile/src/view/screens/navigation%20bar/report_view.dart';

import '../../../../core/assets/app_images.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../model/statistics_data.dart';
import '../../helpers/show_snack_bar.dart';
import '../../widgets/show_image.dart';

final List<Color> _colors = [
  Colors.blue,
  Colors.deepOrange, // Replace yellow with deep orange
  Colors.purple,
  Colors.green,
  Colors.red,
  Colors.indigo,
  Colors.teal,
  Colors.pink,
  Colors.orange,
  Colors.cyan,
];

DateTime _monthChartsDate = DateTime.now();
var _monthChartsDateText =
    '${_monthChartsDate.year}-${_monthChartsDate.month}'.obs;

class StatisticsScreen extends StatelessWidget {
  const StatisticsScreen({super.key});
  @override
  Widget build(BuildContext context) {
    BlocProvider.of<StatisticsCubit>(context).getStatistics(
      monthChartsDate: _monthChartsDate,
    );
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
        title: Text(
          "statistics".tr,
          style: const TextStyle(
              fontWeight: FontWeight.bold, fontSize: 24, color: Colors.white),
        ),
        backgroundColor: Colors.lightBlueAccent,
        centerTitle: true,
      ),
      body: BlocConsumer<StatisticsCubit, StatisticsState>(
        listener: (context, state) {
          if (state is StatisticsFetchFailure) {
            showSnackBar(state.errorMessage, SnackBarMessageType.error);
          } else if (state is StatisticsNetworkFailure) {
            showSnackBar(state.errorMessage, SnackBarMessageType.error);
          }
        },
        builder: (context, state) {
          if (state is StatisticsFetchSuccess) {
            StatisticsData statisticsData = state.statisticsData;
            return _StatisticsSuccessView(statisticsData: statisticsData);
          } else if (state is StatisticsFetchLoading) {
            return const Center(
              child: CircularProgressIndicator(
                color: AppColors.primaryColor,
              ),
            );
          } else if (state is StatisticsFetchFailure) {
            return const Center(
              child: ShowImage(
                imagePath: AppImages.error,
                height: 500,
                width: 500,
              ),
            );
          } else if (state is StatisticsNetworkFailure) {
            return const Center(
              child: ShowImage(
                imagePath: AppImages.error404,
                height: 500,
                width: 500,
              ),
            );
          }
          return const Center(
            child: CircularProgressIndicator(
              color: AppColors.primaryColor,
            ),
          );
        },
      ),
    );
  }
}

class _StatisticsSuccessView extends StatelessWidget {
  const _StatisticsSuccessView({required this.statisticsData});
  final StatisticsData statisticsData;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      child: ListView(
        children: [
          const SizedBox(
            height: 10,
          ),
          _PieChartView(
            data: statisticsData.categoriesPercentages,
          ),
          const SizedBox(
            height: 40,
          ),
          _buildChartsColoredBoxes(data: statisticsData.categoriesPercentages),
          const Divider(
            height: 10,
          ),
          const SizedBox(
            height: 20,
          ),
          _LineChart(
            data: statisticsData.monthChartsData!,
          ),
          const SizedBox(
            height: 20,
          ),
          const Divider(
            height: 10,
          ),
          const SizedBox(
            height: 20,
          ),
          _DataCardsView(statisticsData: statisticsData),
          const SizedBox(
            height: 20,
          ),
          const SizedBox(
            width: double.infinity,
            height: 250,
            child: ReportView(),
          ),
        ],
      ),
    );
  }
}

class _DataCardsView extends StatelessWidget {
  const _DataCardsView({
    required this.statisticsData,
  });

  final StatisticsData statisticsData;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 20.0),
            child: Text(
              'Data Highlights'.tr,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          StatisticCard(
            title: 'Total Paid'.tr,
            iconData: Icons.attach_money,
            value: statisticsData.totalPayment,
            color: Colors.white,
            backgroundColor: Colors.green.shade700,
          ),
          StatisticCard(
            title: 'Medicines'.tr,
            iconData: Icons.local_hospital,
            value: statisticsData.totalMedicines,
            color: Colors.white,
            backgroundColor: Colors.blueGrey.shade700,
          ),
          StatisticCard(
            title: 'Favorites'.tr,
            iconData: Icons.favorite,
            value: statisticsData.favoriteMedicines,
            color: Colors.white,
            backgroundColor: Colors.redAccent.shade700,
          ),
          StatisticCard(
            title: 'Orders'.tr,
            iconData: Icons.shopping_cart,
            value: statisticsData.totalOrders,
            color: Colors.white,
            backgroundColor: Colors.blue.shade700,
          ),
          StatisticCard(
            title: 'In Preparation Orders'.tr,
            iconData: Icons.access_time,
            value: statisticsData.inPreparationOrders,
            color: Colors.white,
            backgroundColor: Colors.yellow.shade700,
          ),
          StatisticCard(
            title: 'Getting Delivered Orders'.tr,
            iconData: Icons.local_shipping,
            value: statisticsData.gettingDeliveredOrders,
            color: Colors.white,
            backgroundColor: Colors.orange.shade700,
          ),
          StatisticCard(
            title: 'Delivered Orders'.tr,
            iconData: Icons.done,
            value: statisticsData.deliveredOrders,
            color: Colors.white,
            backgroundColor: Colors.greenAccent.shade700,
          ),
          StatisticCard(
            title: 'Refused Orders'.tr,
            iconData: Icons.cancel,
            value: statisticsData.refusedOrders,
            color: Colors.white,
            backgroundColor: Colors.red.shade700,
          ),
        ],
      ),
    );
  }
}

Widget _buildChartsColoredBoxes({required Map<String, dynamic> data}) {
  return SizedBox(
    height: 350,
    child: GridView.builder(
      gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
          maxCrossAxisExtent: 300,
          mainAxisExtent: 70,
          mainAxisSpacing: 16,
          crossAxisSpacing: 16,
          childAspectRatio: 5),
      itemCount: data.length,
      itemBuilder: (context, index) {
        return Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 20),
              width: 20,
              height: 20,
              color: _colors[index],
            ),
            SizedBox(
              width: 130,
              child: Text(
                data.keys.elementAt(index),
                maxLines: 2,
                textAlign: TextAlign.start,
                style: const TextStyle(color: Colors.black),
              ),
            ),
          ],
        );
      },
    ),
  );
}

class _PieChartView extends StatefulWidget {
  const _PieChartView({required this.data});
  final Map<String, dynamic> data;

  @override
  State<_PieChartView> createState() => __PieChartViewState();
}

class __PieChartViewState extends State<_PieChartView> {
  int touchedIndex = -1;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 50.0),
          child: Text(
            'Top Purchased Categories'.tr,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        SizedBox(
          width: double.infinity,
          height: 300,
          child: PieChart(
            PieChartData(
              pieTouchData: PieTouchData(
                touchCallback: (FlTouchEvent event, pieTouchResponse) {
                  setState(() {
                    if (!event.isInterestedForInteractions ||
                        pieTouchResponse == null ||
                        pieTouchResponse.touchedSection == null) {
                      touchedIndex = -1;
                      return;
                    }
                    touchedIndex =
                        pieTouchResponse.touchedSection!.touchedSectionIndex;
                  });
                },
              ),
              borderData: FlBorderData(
                show: false,
              ),
              sectionsSpace: 5,
              centerSpaceRadius: 120,
              sections: showingSections(data: widget.data),
            ),
          ),
        ),
      ],
    );
  }

  List<PieChartSectionData> showingSections(
      {required Map<String, dynamic> data}) {
    final List<double> percentages = data.values.toList().cast<double>();

    return List.generate(
      percentages.length,
      (i) {
        final isTouched = i == touchedIndex;
        final fontSize = isTouched ? 16.0 : 12.0;
        final radius = i % 2 == 0 ? 60.0 : 50.0;
        const shadows = [Shadow(color: Colors.grey, blurRadius: 10)];

        return PieChartSectionData(
          color: _colors[i],
          value: percentages[i],
          title: '${percentages[i]}%',
          radius: radius,
          titleStyle: TextStyle(
            fontSize: fontSize,
            fontWeight: FontWeight.bold,
            color: Colors.black,
            shadows: shadows,
          ),
        );
      },
    );
  }
}

class _LineChart extends StatelessWidget {
  const _LineChart({required this.data});
  final Map<String, dynamic> data;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 20.0),
          child: Text(
            'Weekly Expense'.tr,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        SizedBox(
          width: double.infinity,
          height: 220,
          child: LineChart(
            _sampleData,
            duration: const Duration(milliseconds: 250),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 20.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Selecte Date'.tr,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(
                width: 10,
              ),
              IconButton(
                onPressed: () async {
                  final DateTime? picked = await showMonthYearPicker(
                    context: context,
                    initialDate: _monthChartsDate,
                    firstDate: DateTime(2023),
                    lastDate: DateTime.now(),
                  );
                  if (picked != null && picked != _monthChartsDate) {
                    _monthChartsDate = picked;
                    _monthChartsDateText.value =
                        '${_monthChartsDate.year}-${_monthChartsDate.month}';
                    // ignore: use_build_context_synchronously
                    BlocProvider.of<StatisticsCubit>(context).getStatistics(
                      monthChartsDate: _monthChartsDate,
                    );
                  }
                },
                icon: const Icon(
                  Icons.date_range,
                  size: 40,
                  color: AppColors.primaryColor,
                ),
              ),
              const SizedBox(
                width: 10,
              ),
              Obx(
                () => Text(
                  _monthChartsDateText.string,
                  style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey),
                ),
              )
            ],
          ),
        ),
      ],
    );
  }

  LineChartData get _sampleData => LineChartData(
        lineTouchData: _lineTouchData,
        gridData: _gridData,
        titlesData: _titlesData,
        borderData: _borderData,
        lineBarsData: _lineBarsData,
        minX: 1,
        maxX: 4,
        maxY: 10,
        minY: 0,
      );

  LineTouchData get _lineTouchData => const LineTouchData(
        enabled: false,
      );

  FlTitlesData get _titlesData => FlTitlesData(
        bottomTitles: AxisTitles(
          sideTitles: _bottomTitles,
        ),
        rightTitles: AxisTitles(
          sideTitles: _rightTitles(),
        ),
        topTitles: const AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        leftTitles: AxisTitles(
          sideTitles: _leftTitles(),
        ),
      );

  List<LineChartBarData> get _lineBarsData => [
        _lineChartBarData,
      ];
  SideTitles _rightTitles() => SideTitles(
        showTitles: true,
        interval: 1,
        reservedSize: 32,
        getTitlesWidget: _rightTitleWidgets,
      );

  Widget _rightTitleWidgets(double value, TitleMeta meta) {
    return const Text('');
  }

  Widget _leftTitleWidgets(double value, TitleMeta meta) {
    const style = TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: 14,
    );

    // Map the values to corresponding labels
    final Map<double, String> valueLabels = {
      0: '0',
      2: '2M',
      4: '4M',
      6: '6M',
      8: '8M',
      10: '10M',
    };

    final text = valueLabels[value] ?? '';

    return Text(text, style: style, textAlign: TextAlign.center);
  }

  SideTitles _leftTitles() => SideTitles(
        getTitlesWidget: _leftTitleWidgets,
        showTitles: true,
        interval: 2,
        reservedSize: 40,
      );

  Widget _bottomTitleWidgets(double value, TitleMeta meta) {
    const style = TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: 12,
    );

    final text = '${value.toInt()}';

    return SideTitleWidget(
      axisSide: meta.axisSide,
      space: 10,
      child: Text(text, style: style),
    );
  }

  SideTitles get _bottomTitles => SideTitles(
        showTitles: true,
        reservedSize: 32,
        interval: 1,
        getTitlesWidget: _bottomTitleWidgets,
      );

  FlGridData get _gridData => const FlGridData(show: true, verticalInterval: 1);

  FlBorderData get _borderData => FlBorderData(
        show: true,
        border: Border(
          bottom: BorderSide(color: Colors.blue.withOpacity(0.2), width: 4),
          left: const BorderSide(color: Colors.blueAccent),
          right: const BorderSide(color: Colors.blueAccent),
          top: const BorderSide(color: Colors.blueAccent),
        ),
      );

  LineChartBarData get _lineChartBarData => LineChartBarData(
        isCurved: true,
        color: Colors.pink.withOpacity(0.5),
        barWidth: 4,
        isStrokeCapRound: true,
        dotData: const FlDotData(show: false),
        belowBarData: BarAreaData(
          show: true,
          color: Colors.pink.withOpacity(0.2),
        ),
        spots: data.entries.map((entry) {
          final double x = double.parse(entry.key);
          double y = entry.value / 2;
          if (y > 10) y = 10;
          return FlSpot(x, y);
        }).toList(),
      );
}

class StatisticCard extends StatelessWidget {
  final String title;
  final IconData iconData;
  final int value;
  final Color color;
  final Color backgroundColor;

  const StatisticCard(
      {super.key,
      required this.title,
      required this.iconData,
      required this.value,
      required this.color,
      required this.backgroundColor});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 120,
      margin: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            spreadRadius: 2,
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            Icon(
              iconData,
              color: color,
              size: 50,
            ),
            const SizedBox(
              width: 30,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 8),
                Text(
                  title,
                  style: const TextStyle(
                    color: Colors.black87,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  '$value',
                  style: TextStyle(
                    color: color,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

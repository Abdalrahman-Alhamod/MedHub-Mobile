import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:pharmacy_warehouse_store_mobile/src/Cubits/Category/category_cubit.dart';
import 'package:pharmacy_warehouse_store_mobile/src/model/category.dart';

final List<Color> _colors = [
  Colors.blue,
  Colors.deepOrange, // Replace yellow with deep orange
  Colors.purple,
  Colors.green,
  Colors.red,
  Colors.orange,
  Colors.indigo,
  Colors.teal,
  Colors.pink,
  Colors.cyan,
];

class StatisticsScreen extends StatelessWidget {
  const StatisticsScreen({super.key});
  @override
  Widget build(BuildContext context) {
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
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          child: ListView(
            children: [
              const SizedBox(
                height: 10,
              ),
              const _PieChartView(),
              const SizedBox(
                height: 80,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Flexible(
                      flex: 1,
                      child: _buildColoredBoxListView(0, _colors.length ~/ 2)),
                  Flexible(
                    flex: 1,
                    child: _buildColoredBoxListView(
                        _colors.length ~/ 2, _colors.length),
                  ),
                ],
              ),
              const Divider(
                height: 10,
              ),
              const SizedBox(
                height: 20,
              ),
              const _LineChart(),
              const SizedBox(
                height: 20,
              ),
              const Divider(
                height: 10,
              ),
              const SizedBox(
                height: 20,
              ),
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
                title: 'Orders'.tr,
                iconData: Icons.shopping_cart,
                value: 256,
                color: Colors.white,
                backgroundColor: Colors.blue.shade700,
              ),
              StatisticCard(
                title: 'Total Paid'.tr,
                iconData: Icons.attach_money,
                value: 12500000,
                color: Colors.white,
                backgroundColor: Colors.green.shade700,
              ),
              StatisticCard(
                title: 'Medicines'.tr,
                iconData: Icons.local_hospital,
                value: 3567,
                color: Colors.white,
                backgroundColor: Colors.orange.shade700,
              ),
              StatisticCard(
                title: 'Favorites'.tr,
                iconData: Icons.favorite,
                value: 42,
                color: Colors.white,
                backgroundColor: Colors.red.shade700,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildColoredBoxListView(int start, int end) {
    List<Category>? categories =
        BlocProvider.of<CategoryCubit>(Get.context!).currentCategories;
    return SizedBox(
      height: 300,
      child: ListView.builder(
        scrollDirection: Axis.vertical,
        physics: const NeverScrollableScrollPhysics(), // Disable scrolling
        itemCount: end - start,
        itemBuilder: (context, index) {
          return Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 20),
                width: 20,
                height: 20,
                color: _colors[start + index],
              ),
              SizedBox(
                width: 140,
                child: Text(
                  categories![start + index + 1].name,
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
}

class _PieChartView extends StatefulWidget {
  const _PieChartView();

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
              sections: showingSections(),
            ),
          ),
        ),
      ],
    );
  }

  List<PieChartSectionData> showingSections() {
    final List<double> percentages = [20, 15, 10, 10, 8, 7, 6, 5, 5, 4];

    return List.generate(
      10,
      (i) {
        final isTouched = i == touchedIndex;
        final fontSize = isTouched ? 20.0 : 16.0;
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
            color: Colors.white,
            shadows: shadows,
          ),
        );
      },
    );
  }
}

class _LineChart extends StatelessWidget {
  const _LineChart();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 20.0),
          child: Text(
            'Daily Expense'.tr,
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
      ],
    );
  }

  LineChartData get _sampleData => LineChartData(
        lineTouchData: _lineTouchData,
        gridData: _gridData,
        titlesData: _titlesData,
        borderData: _borderData,
        lineBarsData: _lineBarsData,
        minX: 0,
        maxX: 6, // Changed to represent 7 days
        maxY: 2.5, // Adjusted to match the specified values
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
      0.5: '500k',
      1: '1m',
      1.5: '1.5m',
      2: '2m',
      2.5: '2.5m',
    };

    final text = valueLabels[value] ?? '';

    return Text(text, style: style, textAlign: TextAlign.center);
  }

  SideTitles _leftTitles() => SideTitles(
        getTitlesWidget: _leftTitleWidgets,
        showTitles: true,
        interval: 0.5, // Adjusted interval for better representation
        reservedSize: 40,
      );

  Widget _bottomTitleWidgets(double value, TitleMeta meta) {
    const style = TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: 12, // Adjusted font size for better representation
    );

    final text = '${value.toInt() + 1}'; // Days start from 1

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

  FlGridData get _gridData => const FlGridData(show: true);

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
        spots: const [
          FlSpot(0, 250000 / 1000000),
          FlSpot(1, 1200000 / 1000000),
          FlSpot(2, 1400000 / 1000000),
          FlSpot(3, 1000000 / 1000000),
          FlSpot(4, 900000 / 1000000),
          FlSpot(5, 1900000 / 1000000),
          FlSpot(6, 700000 / 1000000),
        ],
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
      width: 150,
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

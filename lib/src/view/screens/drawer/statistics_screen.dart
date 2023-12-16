import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class StatisticsScreen extends StatefulWidget {
  const StatisticsScreen({super.key});

  @override
  State<StatefulWidget> createState() => StatisticsState();
}

class StatisticsState extends State {
  int touchedIndex = -1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "statistics".tr,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
        ),
        backgroundColor: Colors.white,
        centerTitle: true,
      ),
      body: SafeArea(
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
    );
  }

  List<PieChartSectionData> showingSections() {
    final List<Color> colors = [
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

    final List<double> percentages = [20, 15, 10, 10, 8, 7, 6, 5, 5, 4];

    return List.generate(
      10,
      (i) {
        final isTouched = i == touchedIndex;
        final fontSize = isTouched ? 25.0 : 16.0;
        final radius = isTouched ? 60.0 : 50.0;
        const shadows = [Shadow(color: Colors.grey, blurRadius: 10)];

        return PieChartSectionData(
          color: colors[i],
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

import 'package:banking_store/home_page/tabs/wallet/model/chart.dart';
import 'package:banking_store/utils/colors.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class LineChartWidget extends StatefulWidget {
  const LineChartWidget({super.key, required this.chart});

  final Chart chart;

  @override
  State<LineChartWidget> createState() => _LineChartState();
}

class _LineChartState extends State<LineChartWidget> {
  List<Color> gradientColors = [
    StoreColors.darkBrown,
    for (int i = 0; i < 10; i++) StoreColors.darkBrown.withOpacity(.9 - i * .1)
  ];

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        AspectRatio(
          aspectRatio: 1.40,
          child: Padding(
            padding: const EdgeInsets.only(
              top: 4,
              bottom: 4,
              right: 20,
            ),
            child: LineChart(mainData()),
          ),
        ),
      ],
    );
  }

  Widget bottomTitleWidgets(double value, TitleMeta meta) {
    const style = TextStyle(fontSize: 13, color: Colors.grey);
    return SideTitleWidget(
      axisSide: meta.axisSide,
      child: Text(widget.chart.calculateBottomChartData()[value.toInt()],
          style: style),
    );
  }

  Widget leftTitleWidgets(double value, TitleMeta meta) {
    const style = TextStyle(
      fontSize: 13,
      color: Colors.grey,
    );
    String text = '';
    double zarib = widget.chart.maxValue / 4000;
    if (value.toInt() >= 0 && value.toInt() <= 4) {
      text = '${(value.toInt() * zarib)}k';
    }

    return Text(text, style: style, textAlign: TextAlign.left);
  }

  LineChartData mainData() {
    return LineChartData(
      gridData: FlGridData(
        show: true,
        drawVerticalLine: true,
        horizontalInterval: 1,
        verticalInterval: 1,
        getDrawingHorizontalLine: (value) {
          return FlLine(
            color: Colors.grey.withOpacity(.3),
            strokeWidth: 1,
          );
        },
        getDrawingVerticalLine: (value) {
          return FlLine(
            color: Colors.grey.withOpacity(.3),
            strokeWidth: 1,
          );
        },
      ),
      titlesData: FlTitlesData(
        show: true,
        rightTitles: const AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        topTitles: const AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        bottomTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            reservedSize: 30,
            interval: 1,
            getTitlesWidget: bottomTitleWidgets,
          ),
        ),
        leftTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            interval: 1,
            getTitlesWidget: leftTitleWidgets,
            reservedSize: 42,
          ),
        ),
      ),
      borderData: FlBorderData(
        show: true,
        border: Border.fromBorderSide(
            BorderSide(color: Colors.grey.withOpacity(.3))),
      ),
      minX: 0,
      maxX: widget.chart.maxX.toDouble(),
      minY: 0,
      maxY: 4,
      lineBarsData: [
        LineChartBarData(
          spots: widget.chart.chartData.entries
              .map((e) => FlSpot(
                  e.key.toDouble(),
                  ((e.value['average']! / widget.chart.maxValue) * 4)
                      .toDouble()))
              .toList(),
          isCurved: true,
          color: StoreColors.darkBrown,
          barWidth: 5,
          isStrokeCapRound: true,
          dotData: const FlDotData(
            show: false,
          ),
          belowBarData: BarAreaData(
            show: true,
            applyCutOffY: false,
            cutOffY: .4,
            gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: gradientColors),
          ),
        ),
      ],
    );
  }
}

import 'package:banking_store/home_page/tabs/wallet/model/chart.dart';
import 'package:intl/intl.dart';

import '../../../../utils/function.dart';

class ThreeMonthlyChart extends Chart {
  ThreeMonthlyChart({
    super.minValue,
    super.maxValue = 15000,
    super.maxX = 3,
    required super.data,
  }) {
    calculateChartData();
  }

  @override
  List<String> calculateBottomChartData() {
    final bottomChartData = <String>["", "", "", ""];
    int n = maxX;
    final now = DateTime.now();
    while (n >= 0) {
      final weekdayName = DateFormat.MMMM()
          .format(now.subtract(Duration(days: n * 28)))
          .substring(0, 3);
      bottomChartData[n] =
          "$weekdayName/${now.subtract(Duration(days: n * 28)).day}";
      n--;
    }
    return bottomChartData.reversed.toList();
  }

  @override
  void calculateChartData() {
    final now = DateTime.now();
    final endDate = now.subtract(Duration(days: 84));
    chartData = <int, Map<String, double>>{};
    for (int i = maxX; i >= 0; i--) {
      chartData[i] = {'price': 0.0, 'count': 0, 'average': 0.0};
    }
    for (final d in data) {
      if (d.dateTime.isAfter(endDate)) {
        final interval = (d.dateTime.difference(endDate).inDays / 28).round();

        chartData.update(
            interval,
            (map) =>
                {'price': map['price']! + d.price, 'count': map['count']! + 1});
      }
    }

    for (final interval in chartData.keys) {
      if (chartData[interval]!['count']! == 0) {
        chartData[interval]!['average'] = 0.0;
      } else {
        chartData[interval]!['average'] =
            chartData[interval]!['price']! / chartData[interval]!['count']!;
      }
    }
  }
}

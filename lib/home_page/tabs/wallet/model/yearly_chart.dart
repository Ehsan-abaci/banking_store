import 'package:banking_store/home_page/tabs/wallet/model/chart.dart';
import 'package:intl/intl.dart';


class YearlyChart extends Chart {
  YearlyChart({
    super.minValue,
    super.maxX = 6,
    super.maxValue = 20000,
    required super.data,
  }) {
    calculateChartData();
  }

  @override
  List<String> calculateBottomChartData() {
    final bottomChartData = List.generate(7, (_) => "");
    int n = maxX;
    final now = DateTime.now();
    while (n >= 0) {
      final weekdayName = DateFormat.MMMM()
          .format(now.subtract(Duration(days: n * 2 * 28)))
          .substring(0, 3);
      bottomChartData[n] =
          "$weekdayName/${now.subtract(Duration(days: n * 2 * 28)).day}";
      n--;
    }
    return bottomChartData.reversed.toList();
  }

  @override
  void calculateChartData() {
    final now = DateTime.now();
    final endDate = now.subtract(Duration(days: maxX * 2 * 28));

    chartData = <int, Map<String, double>>{};
    for (int i = maxX; i >= 0; i--) {
      chartData[i] = {'price': 0.0, 'count': 0, 'average': 0.0};
    }
    for (final d in data) {
      if (d.dateTime.isAfter(endDate)) {
        final interval =
            (d.dateTime.difference(endDate).inDays / (28 * 2)).round();

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

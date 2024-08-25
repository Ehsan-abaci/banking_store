import 'package:banking_store/home_page/tabs/wallet/model/chart.dart';


class WeeklyChart extends Chart {
  WeeklyChart({
    super.minValue,
    super.maxValue = 20000,
    super.maxX = 4,
    required super.data,
  }) {
    calculateChartData();
  }
  @override
  List<String> calculateBottomChartData() {
    final bottomChartData = <String>["", "", "", "", ""];
    int n = maxX;
    final now = DateTime.now();
    while (n >= 0) {
      bottomChartData[n] =
          "${now.subtract(Duration(days: (n) * 7)).month}/${now.subtract(Duration(days: (n) * 7)).day}";
      n--;
    }
    return bottomChartData.reversed.toList();
  }

  @override
  void calculateChartData() {
    final now = DateTime.now();
    final endDate = now.subtract(Duration(days: 28));
    chartData = <int, Map<String, double>>{};
    for (int i = maxX; i >= 0; i--) {
      chartData[i] = {'price': 0.0, 'count': 0, 'average': 0.0};
    }
    for (final d in data) {
      if (d.dateTime.isAfter(endDate)) {
        final interval = (d.dateTime.difference(endDate).inDays / 7).round();
        chartData.update(
            interval,
            (map) =>
                {'price': map['price']! + d.price, 'count': map['count']! + 1});
      }
    }

    for (final day in chartData.keys) {
      if (chartData[day]!['count']! == 0) {
        chartData[day]!['average'] = 0.0;
      } else {
        chartData[day]!['average'] =
            chartData[day]!['price']! / chartData[day]!['count']!;
      }
    }

  }
}

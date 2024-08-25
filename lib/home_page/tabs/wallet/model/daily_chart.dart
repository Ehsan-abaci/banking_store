import 'package:banking_store/utils/function.dart';
import 'package:intl/intl.dart';

import 'package:banking_store/home_page/tabs/wallet/model/chart.dart';

class DailyChart extends Chart {
  DailyChart({
    super.minValue,
    super.maxValue = 10000,
    super.maxX = 6,
    required super.data,
  }) {
    calculateChartData();
  }

  @override
  List<String> calculateBottomChartData() {
    var bottomChartData = ['', '', '', '', '', '', ''];
    int n = 6;
    while (n >= 0) {
      final weekdayName = DateFormat.EEEE()
          .format(DateTime.now().subtract(Duration(days: n)))
          .substring(0, 3);
      bottomChartData[(n--)] = weekdayName;
    }
    bottomChartData = bottomChartData.reversed.toList();
    return bottomChartData;
  }

  @override
  void calculateChartData() {
    chartData = <int, Map<String, double>>{};
    for (int i = maxX; i >= 0; i--) {
      chartData[i] = {'price': 0.0, 'count': 0, 'average': 0.0};
    }
    for (var d in data) {
      final day = (d.dateTime.day - DateTime.now().day) + maxX;
      if (day < 0) break;
      chartData.update(
          day,
          (map) =>
              {'price': map['price']! + d.price, 'count': map['count']! + 1});
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

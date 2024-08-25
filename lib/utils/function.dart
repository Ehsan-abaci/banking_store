import 'dart:developer';

import 'package:banking_store/home_page/tabs/wallet/model/payment_model.dart';

List<PaymentModel> sortBasedOnDateTime(List<PaymentModel> data) {
  data.sort((a, b) => b.dateTime.compareTo(a.dateTime));
  log(data.toString());
  return data;
}

sortChartDataMap(Map<int, Map<String, double>> chartData) {
  List<MapEntry<int, Map<String, double>>> entries = chartData.entries.toList();

  entries.sort((a, b) => a.key.compareTo(b.key));

  return Map.fromEntries(entries);
}

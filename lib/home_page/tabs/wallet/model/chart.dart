import 'package:banking_store/home_page/tabs/wallet/model/payment_model.dart';

abstract class Chart {
  double minValue;
  double maxValue;
  late int maxX;
  late Map<int, Map<String, double>> chartData;
  List<PaymentModel> data;
  Chart({
    this.minValue = 0,
    required this.maxValue,
    this.maxX = 0,
    required this.data,
  });

  void calculateChartData();
  List<String> calculateBottomChartData();
}

// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:math';

class PaymentModel {
  final String id;
  final String name;
  final Authorization authorization;
  final double price;
  final DateTime dateTime;

  const PaymentModel({
    required this.id,
    required this.name,
    required this.authorization,
    required this.price,
    required this.dateTime,
  });

  static List<PaymentModel> dummy() {
    final random = Random();
    final startDate = DateTime.now().subtract(Duration(days: 365));
    final endDate = DateTime.now();

    // Calculate the difference in days
    final differenceInDays = endDate.difference(startDate).inDays;

    return [
      ...List.generate(
        500,
        (index) => PaymentModel(
          id: "$index",
          name: "Payment ${index + 1}",
          authorization: Authorization.automatic,
          price: random.nextInt(9000) + 1000,
          dateTime: startDate.add(
            Duration(
                days: random.nextInt(
                    differenceInDays + 1)), // Random day within difference
          ),
        ),
      ),
    ];
  }

  @override
  String toString() {
    return 'PaymentModel(id: $id, name: $name, authorization: $authorization, price: $price, dateTime: $dateTime)\n';
  }
}

class Authorization {
  final String value;
  const Authorization._(this.value);

  static const Authorization automatic = Authorization._('Automatic');
  static const Authorization manual = Authorization._('Manual');
  static const Authorization self = Authorization._('Self-Invested');
}

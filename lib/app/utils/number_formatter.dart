import 'package:intl/intl.dart';

class NumberFormatter {

  String convertToCurrency(int number) {
    final NumberFormat numberFormat = NumberFormat.currency(
      symbol: '\$ ',
      decimalDigits: 2,
    );

    return numberFormat.format(number);
  }
}

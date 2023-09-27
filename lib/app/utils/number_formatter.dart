import 'package:intl/intl.dart';

class NumberFormatter {

  String formatCurrency(int number) {
    final NumberFormat numberFormat = NumberFormat.currency(
      symbol: '\$ ',
      decimalDigits: 2,
    );

    return numberFormat.format(number);
  }

  String formatDuration(int minute) {
    if (minute < 60) {
      return '${minute}m';
    }
    else {
      final int hours = minute ~/ 60;
      final int remainingMinutes = minute % 60;

      if (remainingMinutes == 0) {
        return '$hours h';
      } else {
        return '${hours}h ${remainingMinutes}m';
      }
    }
  }

  String formatDate(String date) {
    DateTime dateTime = DateTime.parse(date);
    String formattedDate = DateFormat('dd MMMM y').format(dateTime);

    return formattedDate;
  }
}

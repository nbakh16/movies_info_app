import 'package:intl/intl.dart';

class MyFormatter {
  MyFormatter._();

  static String formatCurrency(int number) {
    final NumberFormat numberFormat = NumberFormat.currency(
      symbol: '\$ ',
      decimalDigits: 2,
    );

    return numberFormat.format(number);
  }

  static String formatDuration(int minute) {
    if (minute < 60) {
      return '${minute}m';
    } else {
      final int hours = minute ~/ 60;
      final int remainingMinutes = minute % 60;

      if (remainingMinutes == 0) {
        return '$hours h';
      } else {
        return '${hours}h ${remainingMinutes}m';
      }
    }
  }

  static String formatDate(String dateString) {
    try {
      // Parse the input date string "2023-12-24"
      final DateFormat inputFormat = DateFormat('yyyy-MM-dd');
      final DateTime parsedDate = inputFormat.parse(dateString);

      // Format the date using the desired output format
      final DateFormat outputFormat = DateFormat('MMMM d, yyyy');
      return outputFormat.format(parsedDate);
    } catch (e) {
      return dateString;
    }
  }

  // static String formatTime(String timeString) {
  //   try {
  //     // Parse the input time string "09:52:01"
  //     final DateFormat inputFormat = DateFormat('HH:mm:ss');
  //     final DateTime parsedTime = inputFormat.parse(timeString);

  //     // Format the time using the desired output format
  //     final DateFormat outputFormat = DateFormat('hh:mm a');
  //     return outputFormat.format(parsedTime);
  //   } catch (e) {
  //     return 'Invalid time format';
  //   }
  // }
}

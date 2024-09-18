import 'package:intl/intl.dart';

class MyFormatter {
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

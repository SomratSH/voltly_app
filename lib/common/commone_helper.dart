import 'package:intl/intl.dart';

String convertTo12HourFormat(String time24) {
  try {
    final inputFormat = DateFormat("HH:mm:ss");
    final dateTime = inputFormat.parse(time24);
    final outputFormat = DateFormat("h:mm a");
    return outputFormat.format(dateTime);
  } catch (e) {
    return time24; // fallback if parsing fails
  }
}
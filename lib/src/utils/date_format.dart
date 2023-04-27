import 'package:intl/intl.dart';

String changeDateFormat(int timestamp) {
  DateTime dateTime = DateTime.fromMillisecondsSinceEpoch(timestamp);
  return DateFormat('EEE, d MMM y').format(dateTime);
}

String changeHoursFormat(int timestamp) {
  return DateFormat.Hm().format(DateTime.fromMillisecondsSinceEpoch(timestamp));
}

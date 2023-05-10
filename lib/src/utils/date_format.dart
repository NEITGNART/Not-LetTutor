import 'package:intl/intl.dart';

String changeDateFormat(int timestamp) {
  DateTime dateTime = DateTime.fromMillisecondsSinceEpoch(timestamp);
  return DateFormat('EEE, d MMM y').format(dateTime);
}

String changeHoursFormat(int timestamp) {
  return DateFormat.Hm().format(DateTime.fromMillisecondsSinceEpoch(timestamp));
}

String printDuration(Duration duration) {
  String twoDigits(int n) => n.toString().padLeft(2, "0");
  String twoDigitMinutes = twoDigits(duration.inMinutes.remainder(60));
  String twoDigitSeconds = twoDigits(duration.inSeconds.remainder(60));
  return "${twoDigits(duration.inHours)}:$twoDigitMinutes:$twoDigitSeconds";
  //   if (duration.inHours != 0) {

  // }
  // return "$twoDigitMinutes:$twoDigitSeconds";
}

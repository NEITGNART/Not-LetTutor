import 'package:url_launcher/url_launcher.dart';

Future<void> launchUrlAsync(Uri url) async {
  if (!await launchUrl(
    url,
    mode: LaunchMode.externalApplication,
  )) throw 'Could not launch $url';
}

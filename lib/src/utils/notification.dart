import 'dart:io';

import 'package:beatiful_ui/src/utils/snack_bar.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:url_launcher/url_launcher.dart';

import 'open_url.dart';

void handleOpenInAppNoti(RemoteMessage message) {
  if (Platform.isIOS) {
    if (message.data['iosUrl'] != null) {
      showSnackbar(
          message.notification?.title ?? '', message.notification?.body ?? '',
          onclick: {
            launchUrlAsync(
              Uri.parse(
                '${message.data['iosUrl']}}',
              ),
            )
          });
    }
  } else {
    if (message.data['androidUrl'] != null) {
      showSnackbar(
          message.notification?.title ?? '', message.notification?.body ?? '',
          onclick: {
            launchUrlAsync(
              Uri.parse(
                '${message.data['androidUrl']}}',
              ),
            )
          });
    } else if (message.data['url'] != null) {
      showSnackbar(
          message.notification?.title ?? '', message.notification?.body ?? '',
          onclick: {
            launchUrlAsync(
              Uri.parse(
                '${message.data['androidUrl']}}',
              ),
            )
          });
    }
  }
}

void handleOpenFromNoti(RemoteMessage message) {
  if (Platform.isIOS) {
    if (message.data['iosUrl'] != null) {
      launchUrl(
        Uri.parse(
          '${message.data['iosUrl']}}',
        ),
      );
    }
  } else {
    if (message.data['androidUrl'] != null) {
      launchUrlAsync(
        Uri.parse(
          '${message.data['androidUrl']}}',
        ),
      );
    } else if (message.data['url'] != null) {
      launchUrlAsync(
        Uri.parse(
          '${message.data['url']}}',
        ),
      );
    }
  }
}

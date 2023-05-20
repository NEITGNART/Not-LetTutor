import 'dart:convert';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:jitsi_meet_wrapper/jitsi_meet_wrapper.dart';

import '../features/tutor/model/booking_info.dart';

joinMeeting(BookingInfo nextClass) async {
  Map<FeatureFlag, bool> featureFlags = {
    FeatureFlag.isWelcomePageEnabled: false,
  };
  if (!kIsWeb) {
    // Here is an example, disabling features for each platform
    if (Platform.isAndroid) {
      // Disable ConnectionService usage on Android to avoid issues (see README)
      featureFlags[FeatureFlag.isCallIntegrationEnabled] = false;
    } else if (Platform.isIOS) {
      // Disable PIP on iOS as it looks weird
      featureFlags[FeatureFlag.isPipEnabled] = false;
    }
  }

  final base64Decoded = base64.decode(base64.normalize(
      nextClass.studentMeetingLink.split('token=')[1].split('.')[1]));
  final urlObject = utf8.decode(base64Decoded);
  final jsonRes = json.decode(urlObject);
  final String roomId = jsonRes['room'];
  final String tokenMeeting = nextClass.studentMeetingLink.split('token=')[1];

  var options = JitsiMeetingOptions(
    serverUrl: 'https://meet.lettutor.com',
    roomNameOrUrl: roomId,
    token: tokenMeeting,
    isVideoMuted: true,
    isAudioMuted: true,
    isAudioOnly: true,
  )..featureFlags?.addAll(featureFlags);
  await JitsiMeetWrapper.joinMeeting(options: options);
}

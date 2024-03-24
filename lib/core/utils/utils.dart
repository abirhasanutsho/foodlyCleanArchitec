import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:cleanarchitec/features/call/presentation/screen/call_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';

import '../shared_helper/shared_pref.dart';

var accessToken = "";
var userId = "";
var fcmToken = "";
const developmentBaseUrl = "http://192.168.0.102:3000/api/";
initiateAccessToken() async {
  accessToken = await getAccessToken();
}

initaizationUserId() async {
  userId = await getUserID();
}

initiateFcmToken() async {
  fcmToken = await getFcmToken();
}

void showSnackBar({required BuildContext context, required String content}) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(content),
    ),
  );
}

class AppColors {
  static Color whitecolor = const Color(0xFFffffff);
  static Color navbartxtcolor = const Color(0xFF8aa9c7);
  static Color primarycolor = const Color(0xFF0d1d2b);
  static Color backgroundcolor = const Color(0xFFf9f9fa);
  static Color textprimarycolor = const Color(0xFF111827);
  static Color buttoncolor = const Color(0xff28e7fb);
  static Color selectioncolor = const Color(0xFF17314a);
  static Color lightgreycolor = const Color(0xFFf7f8f8);
  static Color blackcolor = Colors.black;
}

class NotificationControllerPush {
  @pragma("vm:entry-point")
  static Future<void> onNotificationCreatedMethod(
      ReceivedNotification receivedNotification) async {}

  @pragma("vm:entry-point")
  static Future<void> onNotificationDisplayedMethod(
      ReceivedNotification receivedNotification) async {}
  @pragma("vm:entry-point")
  static Future<void> onDismissActionReceivedMethod(
      ReceivedAction receivedAction) async {
     Get.back();
  }
  @pragma("vm:entry-point")
  static Future<void> onActionReceivedMethod(
      ReceivedAction receivedAction) async {
    if (receivedAction.buttonKeyPressed == "REJECT" ||
        receivedAction.channelKey == "REJECT") {
      print("Reject Call");
      Get.back();
    } else if (receivedAction.buttonKeyPressed == "ACCEPT" ||
        receivedAction.channelKey == "ACCEPT") {
      print("Accept Call");
      Get.to(CallScreen(
        channelId: userId,
      ));
    } else {
      print("On Tab Notification");
    }
  }
}

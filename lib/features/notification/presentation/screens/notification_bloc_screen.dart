import 'package:flutter/material.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:rxdart/rxdart.dart';

import '../../data/model/push_model.dart';
import 'notification_badges.dart';

class NotificationBloc {
  final BehaviorSubject<PushNotification> _subject =
      BehaviorSubject<PushNotification>();

  notification(PushNotification pushNotification) async {
    _subject.sink.add(pushNotification);
    showSimpleNotification(
        InkWell(
          onTap: () {},
          child: Container(
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const NotificationBadge(totalNotifications: 1),
                const SizedBox(
                  width: 10,
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      pushNotification.title!.isNotEmpty
                          ? pushNotification.title!
                          : pushNotification.dataTitle!,
                      style: TextStyle(color: Colors.red),
                    ),
                    const SizedBox(
                      height: 4,
                    ),
                    Text(
                      pushNotification.body!.isNotEmpty
                          ? pushNotification.body!
                          : pushNotification.dataBody!,
                      style: const TextStyle(fontSize: 12, color: Colors.red),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        // leading: const NotificationBadge(totalNotifications: 1),
        // subtitle: Text(pushNotification.body!.isNotEmpty
        //     ? pushNotification.body!
        //     : pushNotification.dataBody!),
        background: Colors.white,
        autoDismiss: true,
        slideDismiss: true,
        duration: const Duration(seconds: 5),
        slideDismissDirection: DismissDirection.startToEnd);
  }

  dispose() {
    _subject.close();
  }

  BehaviorSubject<PushNotification> get subject => _subject;
}

final notificationBloc = NotificationBloc();

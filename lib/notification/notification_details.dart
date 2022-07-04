import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_learning/utils/spacings.dart';
import 'package:flutter_learning/utils/text_style.dart';

import '../utils/string.dart';

class NotificationDetailsScreen extends StatelessWidget {
  const NotificationDetailsScreen({Key? key, required this.remoteMessage})
      : super(key: key);
  final RemoteMessage remoteMessage;
  @override
  Widget build(BuildContext context) {
    return (Scaffold(
      body: Center(
          child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('${Strings.lblTitle} ${remoteMessage.notification?.title}',
              style: TextStyles.notificationText),
          const SizedBox(height: Spacings.medium),
          Text('${Strings.lblBody} ${remoteMessage.notification?.body}',
              style: TextStyles.notificationText),
          const SizedBox(height: Spacings.medium),
          SizedBox(
            width: double.infinity,
            child: Text(
                '${Strings.lblPayload} ${remoteMessage.data.toString()}',
                textAlign: TextAlign.center,
                style: TextStyles.notificationText),
          )
        ],
      )),
    ));
  }
}

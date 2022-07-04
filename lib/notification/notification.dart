import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import '../firebase_options.dart';
import '../utils/color.dart';
import '../utils/spacings.dart';
import '../utils/string.dart';
import '../widgets/button.dart';
import 'notification_details.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const SafeArea(
        child: Scaffold(
      backgroundColor: Colors.white,
      body: NotificationScreenStateful(),
    ));
  }
}

class NotificationScreenStateful extends StatefulWidget {
  const NotificationScreenStateful({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => NotificationScreenState();
}

class NotificationScreenState extends State<NotificationScreenStateful> {
  Future<void> initFirebase() async {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
    FirebaseMessaging _messaging = FirebaseMessaging.instance;

    NotificationSettings settings = await _messaging.requestPermission(
      alert: true,
      badge: true,
      provisional: false,
      sound: true,
    );

    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      final fcmToken = await FirebaseMessaging.instance.getToken();

      FirebaseMessaging.instance.onTokenRefresh.listen((fcmToken) {
        debugPrint('FCM Token----->$fcmToken');
      }).onError((err) {
        debugPrint('FCM Token----->$err');
      });
      debugPrint('FCM Token----->$fcmToken');

      FirebaseMessaging.onMessage.listen((RemoteMessage message) {
        showLocalNotification(context, message);
      });

      FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
        moveToNextScreen(context, message);
      });

      FirebaseMessaging.instance.getInitialMessage().then((message) {
        if (message != null && message.notification?.title != null) {
          moveToNextScreen(context, message);
        }
      });
    } else {
      debugPrint('User declined or has not accepted permission');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: SizedBox(
            height: Spacings.xxxLarge,
            width: double.infinity,
            child: ButtonElevated(
              backgroundColor: Palette.color2167AE,
              text: Strings.lblTestNotification,
              isLoading: false,
              press: () {
                initFirebase();
              },
            )),
      ),
    );
  }

  void moveToNextScreen(BuildContext context, RemoteMessage message) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) =>
                NotificationDetailsScreen(remoteMessage: message)));
  }

  void showLocalNotification(BuildContext context, RemoteMessage message) {
    void onSelectNotification(String? payload) {
      moveToNextScreen(context, message);
    }

    final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
        FlutterLocalNotificationsPlugin();

    var initializationSettingsAndroid =
        const AndroidInitializationSettings('@mipmap/ic_launcher');
    var initializationSettingsIOS = const IOSInitializationSettings();
    var initializationSettings = InitializationSettings(
        android: initializationSettingsAndroid, iOS: initializationSettingsIOS);
    var androidPlatformChannelSpecifics = const AndroidNotificationDetails(
        'Channel id', '1',
        importance: Importance.defaultImportance,
        priority: Priority.defaultPriority);
    var iOSPlatformChannelSpecifics = const IOSNotificationDetails();
    var platformChannelSpecifics = NotificationDetails(
        android: androidPlatformChannelSpecifics,
        iOS: iOSPlatformChannelSpecifics);

    flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onSelectNotification: onSelectNotification);
    flutterLocalNotificationsPlugin.show(1234, message.notification?.title,
        message.notification?.body, platformChannelSpecifics,
        payload: message.data.toString());
  }
}

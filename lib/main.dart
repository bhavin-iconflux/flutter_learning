import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_learning/login/login.dart';
import 'package:flutter_learning/login_bloc/view/login_with_bloc.dart';
import 'package:flutter_learning/notification/notification.dart';
import 'package:flutter_learning/utils/color.dart';
import 'package:flutter_learning/utils/spacings.dart';
import 'package:flutter_learning/utils/string.dart';
import 'package:flutter_learning/utils/utils.dart';
import 'package:flutter_learning/widgets/button.dart';

import 'notification/notification_details.dart';

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  debugPrint(
      "Handling a background message----->: ${message.notification?.title}");
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  await Firebase.initializeApp();
  Utils.setStatusBarColor(true, Palette.colorF3F3F2);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const SafeArea(
        child: Scaffold(
          backgroundColor: Colors.white,
          body: MainScreen(),
        ),
      ),
    );
  }
}

class MainScreen extends StatelessWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    checkNotificationPayload(context);
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
                width: double.infinity,
                child: ButtonElevated(
                  backgroundColor: Palette.color2167AE,
                  text: Strings.lblLogin,
                  isLoading: false,
                  press: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const LoginScreen()));
                  },
                )),
            const SizedBox(height: Spacings.medium),
            SizedBox(
                width: double.infinity,
                child: ButtonElevated(
                  backgroundColor: Palette.color2167AE,
                  text: Strings.lblLoginWithBloc,
                  isLoading: false,
                  press: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>  LoginUsingBlockScreen()));
                  },
                )),
            const SizedBox(height: Spacings.medium),
            SizedBox(
                width: double.infinity,
                child: ButtonElevated(
                  backgroundColor: Palette.color2167AE,
                  text: Strings.lblNotification,
                  isLoading: false,
                  press: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const NotificationScreen()));
                  },
                )),
            const SizedBox(height: Spacings.medium),
          ],
        ),
      ),
    );
  }

  void checkNotificationPayload(BuildContext context) {
     FirebaseMessaging.instance.getInitialMessage().then((message) {
      if (message != null && message.notification?.title != null) {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) =>
                    NotificationDetailsScreen(remoteMessage: message)));
      }
    });
  }
}

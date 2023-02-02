import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:municipal_track/code/MapTools/location_controller.dart';
import 'package:municipal_track/code/SQLInt/sql_main.dart';
import 'package:municipal_track/code/SQLApp/auth/login_screen.dart';
import 'package:municipal_track/code/login/citizen_otp_page.dart';
import 'package:municipal_track/code/login/login_page.dart';

import 'code/main_page.dart';

///notification handler start
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  // If you're going to use other Firebase services in the background, such as Firestore,
  // make sure you call `initializeApp` before using other Firebase services.
  await Firebase.initializeApp();
  print('Handling a background message ${message.messageId}');
}
///notification handler end

void main() async{
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();
  await FirebaseMessaging.instance.getInitialMessage();

  ///notification section
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  await flutterLocalNotificationsPlugin
      .resolvePlatformSpecificImplementation<
      AndroidFlutterLocalNotificationsPlugin>()
      ?.createNotificationChannel(channel);
  await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
    alert: true,
    badge: true,
    sound: true,
  );
  ///notification section ended

  Get.put(LocationController());

  runApp(const MyApp());
  ///For the sql version the sql_main will call the SQLMain() StatelessWidget instead of the MyApp() StatelessWidget which is for the firebase version
  //runApp(const SQLMain())
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const GetMaterialApp(
      debugShowCheckedModeBanner: false,
      ///MainPage links to an auth state for logging in using the necessary firebase method.
      ///If already logged in user will be immediately directed to the dashboard
      home: MainPage(),
        //SQLMain(), For the sql version the sql_main will call the SQLMain() StatelessWidget
        //LoginScreen(), this is being developed and I am testing the mysql db login screen
        //MainPage(),
    );
  }
}

///notification channel init start
const AndroidNotificationChannel channel = AndroidNotificationChannel(
  'high_importance_channel', // id
  'High Importance Notifications', // title
  //'This channel is used for important notifications.', // description
  importance: Importance.high,
);
final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
FlutterLocalNotificationsPlugin();
///notification channel init end


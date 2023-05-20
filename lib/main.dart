import 'dart:developer';
import 'package:smoke_detection/screens/home/home_screen.dart';

import 'pages/login_page.dart';
import 'pages/register_page.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:smoke_detection/screens/main/main_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:smoke_detection/services/local_notification_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

//import 'package:fcmflutter/firebase_options.dart';
//import 'package:flutter/services.dart' as rootBundle;

// const AndroidNotificationChannel channel =
//     AndroidNotificationChannel(importance: Importance.high, playSound: true);
// final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
//     FlutterLocalNotificationsPlugin();
// Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
//   await Firebase.initializeApp();
//   print('A bg message just showed up: ${message.messageID}');
// }
// Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
//   print("Handling a background message: ${message.messageId}");
// }
Future<void> backgroundHandler(RemoteMessage message) async {
  log("message data :: ${message.data.toString()}");
  log("message title :: ${message.notification!.title}");
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  FirebaseMessaging messaging = FirebaseMessaging.instance;
  NotificationSettings settings = await messaging.requestPermission(
    alert: true,
    announcement: false,
    badge: true,
    carPlay: false,
    criticalAlert: false,
    provisional: false,
    sound: true,
  );
  if (settings.authorizationStatus == AuthorizationStatus.authorized) {
    log('User granted permission');
  } else if (settings.authorizationStatus == AuthorizationStatus.provisional) {
    log('User granted provisional permission');
  } else {
    log('User declined or has not accepted permission');
  }

  FirebaseMessaging.onBackgroundMessage(backgroundHandler);
  LocalNotificationService.initialize();
  
  FirebaseMessaging.instance.getInitialMessage().then(
    (message) {
      log("FirebaseMessaging.instance.getInitialMessage");
      if (message != null) {
        log("New Notification");
        // if (message.data['_id'] != null) {
        //   Navigator.of(context).push(
        //     MaterialPageRoute(
        //       builder: (context) => DemoScreen(
        //         id: message.data['_id'],
        //       ),
        //     ),
        //   );
        // }
      }
    },
  );
//   FirebaseFirestore firestore = FirebaseFirestore.instance;
// CollectionReference notifications = firestore.collection('notifications');

// notifications.add({
//   'title': notificationTitle,
//   'body': notificationBody,
//   // Add other relevant notification data
// });
// String notificationId = 'custom_notification_id';
// DocumentReference notificationRef = notifications.doc(notificationId);

// notificationRef.set({
//   'title': notificationTitle,
//   'body': notificationBody,
//   // Add other relevant notification data
// });




  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Flutter",
      theme: ThemeData(
        
        appBarTheme: const AppBarTheme(

          color: Color(0xFF075E54),

        ),
       
        fontFamily: "OpenSans",
        primaryColor: Color(0xFF075E54),
             ),

      routes: {
        '/': (context) => const MyLogin(),
        '/register': (context) => const MyRegister(),
                '/mainscreen': (context) => const MainScreen(),
                 '/logout': (context) => const MyLogin(),
           '/notification': (context) =>  HomeScreen(),
      },
    );
  }
}

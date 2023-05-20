import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:smoke_detection/pages/profile.dart';
import 'package:smoke_detection/screens/smoke_details/smoke_details_screen.dart';
import 'package:smoke_detection/screens/contact/contact_screen.dart';
import 'package:smoke_detection/screens/home/home_screen.dart';

import '../../models/push_notification_model.dart';
import '../../services/local_notification_service.dart';

late TabController tabController;
PushNotificationModel? pushNotificationModel;

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen>
    with SingleTickerProviderStateMixin {
  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 3, vsync: this, initialIndex: 0);

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      log('Got a message whilst in the foreground!');
      log('Message data: ${message.data}');

      if (message.notification != null) {
        log('Message also contained a notification: ${message.notification?.title}');
      }
      LocalNotificationService.createanddisplaynotification(message);
      var notificationIdToken =
          LocalNotificationService.getDeviceTokenToSendNotification();
      // notifications = firestore.collection("notifications");
      // notifications?.add({
      //   // add in hardware integration of notification service
      //   'title': message.notification?.title,
      //   'body': message.notification?.body,
      // });
      String notificationId = 'custom_notification_id';
      // DocumentReference? notificationRef =
      FirebaseFirestore.instance
          .collection("notifications")
          .add({
            "email": FirebaseAuth.instance.currentUser?.email ?? "",
            'title': message.notification?.title,
            'body': message.notification?.body,
          })
          .then((DocumentReference doc) =>
              log('DocumentSnapshot added with ID: ${doc.id}'))
          .onError((e, _) => print("Error writing document: $e"));

      // notificationRef?.set({
      //   'title': "notificationTitle",
      //   'body': "notificationBody",
      // });
      setState(() {
        pushNotificationModel = PushNotificationModel(
          body: message.notification?.body,
          title: message.notification?.title,
        );
      });
    });

    FirebaseMessaging.onMessageOpenedApp.listen(
      (message) {
        log("FirebaseMessaging.onMessageOpenedApp.listen");
        if (message.notification != null) {
          log(message.notification!.title ?? "");
          log(message.notification!.body ?? "");
          log("message.data ${message.data['_id']}");
          setState(() {
            pushNotificationModel = PushNotificationModel(
              body: message.notification?.body,
              title: message.notification?.title,
            );
          });
        }
      },
    );
  }

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            icon: Icon(Icons.notification_important_rounded),
            onPressed: () {
              Navigator.pushNamed(context, '/notification');
              ;
            },
          )
        ],
        title: Text("Smoke Detection"),
        bottom: TabBar(controller: tabController, tabs: [
          Tab(
            icon: Icon(Icons.home),
          ),
          // Tab(text: "Smoke Details"),
          Tab(text: "Contacts"),
          Tab(text: "Profile"),
        ]),
      ),
      body: TabBarView(
        controller: tabController,
        children: [
          Loading(),
          ContactScreen(),
          //HomeScreen(),

          ProfilePage(),
        ],
      ),
    );
  }
}

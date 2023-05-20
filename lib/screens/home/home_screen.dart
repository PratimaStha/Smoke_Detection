import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:smoke_detection/models/push_notification_model.dart';
import 'package:smoke_detection/services/local_notification_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../main/main_screen.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String? deviceTokenToSendPushNotification;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    CollectionReference notifications =
        FirebaseFirestore.instance.collection('notifications');
    return Scaffold(
      appBar: AppBar(
        title: Text("Notification"),
      ),
      body: FutureBuilder<QuerySnapshot>(
        future: notifications.get(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return Text("Something went wrong");
          }

          // if (snapshot.hasData) {
          //   return Text("Document does not exist");
          // }

          if (snapshot.connectionState == ConnectionState.done) {
            List<PushNotificationModel>? pushNotificationModel = [];
            snapshot.data?.docs.forEach((element) {
              log(element["title"]);
              pushNotificationModel.add(PushNotificationModel(
                body: element["body"],
                title: element["title"],
                email: element["email"],
              ));
            });
            // log(pushNotificationModel.length.toString());
            return pushNotificationModel.isEmpty
                ? Center(
                    child: CircularProgressIndicator(),
                  )
                : ListView.separated(
                    itemBuilder: (context, index) {
                      return Container(
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey.shade400),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Column(
                          children: [
                            SizedBox(
                              height: 20,
                            ),
                            Text("Notification Data"),
                            SizedBox(
                              height: 20,
                            ),
                            Text(pushNotificationModel[index].title ?? ""),
                            SizedBox(
                              height: 20,
                            ),
                            Text(pushNotificationModel[index].email ?? ""),
                            SizedBox(
                              height: 20,
                            ),
                            Text(pushNotificationModel[index].body ?? ""),
                          ],
                        ),
                      );
                    },
                    separatorBuilder: (context, index) => SizedBox(height: 20),
                    itemCount: pushNotificationModel.length);
          }
          return Text("loading");
        },
      ),
    );
  }
}

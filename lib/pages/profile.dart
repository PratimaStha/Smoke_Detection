import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Center(
          child: Column(
            children: [
              Row(
                children: [
                  Text(
                    "Email ",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Text(
                    FirebaseAuth.instance.currentUser?.email ?? "",
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 20,
              ),
              // Row(
              //   children: [
              //     Text(
              //       "Name ",
              //       style: TextStyle(
              //         fontSize: 16,
              //         fontWeight: FontWeight.w600,
              //       ),
              //     ),
              //     Text(
              //       FirebaseAuth.instance.currentUser?.displayName ?? "",
              //       style: TextStyle(
              //         fontSize: 14,
              //         fontWeight: FontWeight.w400,
              //       ),
              //     ),
              //   ],
              // ),
              SizedBox(
                height: 30,
              ),
              Container(
                width: 150,
                child: ElevatedButton(
                  onPressed: () {
                    FirebaseAuth.instance.signOut().then((value) {
                      print("Signed Out"); //   }, (){
                      Navigator.pushNamed(context, '/logout');
                    });
                  },
                  child: Center(child: Text("LogOut")),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFF075E54),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

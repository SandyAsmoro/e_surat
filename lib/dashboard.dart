import 'package:convex_bottom_bar/convex_bottom_bar.dart';
// import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:e_surat/home.dart';
import 'package:e_surat/inbox.dart';
import 'package:e_surat/outbox.dart';
import 'package:e_surat/profile.dart';

// import 'forgroundLocalNotification.dart';

const color1 = Color.fromARGB(255, 27, 0, 71);
const color2 = Color(0xFF488FB1);
const color3 = Color(0xFF4FD3C4);
const color4 = Color(0xFFC1F8CF);

class Dashboard extends StatefulWidget {
  const Dashboard({Key? key}) : super(key: key);

  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  String token = "";
  int selectedPage = 0;
  final _pageOption = [
    Home(),
    Inbox(),
    Outbox(),
    Profile(),
  ];

  @override
  Widget build(BuildContext context) {
    // LocalNotification.initialize();
    // // For Forground State
    // FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    //   LocalNotification.showNotification(message);
    // });
    return Scaffold(
      body: _pageOption[selectedPage],
      bottomNavigationBar: ConvexAppBar(
        backgroundColor: color1,
        items: [
          TabItem(icon: Icons.home, title: 'Home'),
          TabItem(icon: Icons.archive, title: 'Inbox'),
          TabItem(icon: Icons.unarchive, title: 'Outbox'),
          TabItem(icon: Icons.people, title: 'Profile'),
        ],
        initialActiveIndex: selectedPage,
        onTap: (int index) {
          setState(() {
            selectedPage = index;
          });
        },
      ),
    );
  }
}

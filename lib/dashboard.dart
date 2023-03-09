import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:e_surat/home.dart';
import 'package:e_surat/inbox.dart';
import 'package:e_surat/outbox.dart';
import 'package:e_surat/profile.dart';
import 'package:shared_preferences/shared_preferences.dart';

const color1 = Color(0xFF533E85);
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
    // Outbox(),
    Profile(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pageOption[selectedPage],
      bottomNavigationBar: ConvexAppBar(
        backgroundColor: color1,
        items: [
          TabItem(icon: Icons.home, title: 'Home'),
          TabItem(icon: Icons.inbox_outlined, title: 'Surat Masuk'),
          // TabItem(icon: Icons.outbox_outlined, title: 'Surat Keluar'),
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

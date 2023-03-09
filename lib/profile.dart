import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:e_surat/main.dart';

const color1 = Color(0xFF533E85);
const color2 = Color(0xFF488FB1);
const color3 = Color(0xFF4FD3C4);
const color4 = Color(0xFFC1F8CF);

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  String token = "";
  String jabatan = "";
  String nama = "";
  String opd = "";

  @override
  void initState() {
    super.initState();
    getProfile();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Profile"),
        backgroundColor: color1,
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: SafeArea(
            child: Center(
                child: Column(
                  children: [
                    Card(
                      clipBehavior: Clip.antiAlias,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      shadowColor: Colors.black,
                      elevation: 10,
                      child: Container(
                        decoration: BoxDecoration(
                            gradient: LinearGradient(
                                colors: [color2, color3],
                                stops: [0.1, 1],
                                begin: Alignment.topCenter,
                                end: Alignment.bottomRight)),
                        padding: EdgeInsets.all(12),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Nama     : ${nama}",
                              style: TextStyle(color: Colors.white, fontSize: 16),
                            ),
                            Divider(),
                            Text(
                              "Jabatan : ${jabatan}",
                              style: TextStyle(color: Colors.white, fontSize: 16),
                            ),
                            Divider(),
                            Text(
                              "OPD       : ${opd}",
                              style: TextStyle(color: Colors.white, fontSize: 16),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    OutlinedButton.icon(
                        onPressed: () {
                          logout();
                        },
                        icon: Icon(
                          Icons.logout,
                          size: 18,
                        ),
                        label: Text("Logout"))
                  ],
                ))),
      ),
    );
  }

  void logout() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    await pref.clear();
    Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) => LoginPage()), (route) => false);
  }

  Future<bool> getProfile() async {
    try {
      SharedPreferences pref = await SharedPreferences.getInstance();
      setState(() {
        token = pref.getString("token")!;
        jabatan = pref.getString("jabatan")!;
        nama = pref.getString("nama")!;
        opd = pref.getString("opd")!;
      });
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }
}

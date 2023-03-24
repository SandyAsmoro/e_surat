import 'dart:convert';

import 'package:e_surat/models/dbsuratmasuk.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

const color1 = Color(0xFF533E85);
const color2 = Color(0xFF488FB1);
const color3 = Color(0xFF4FD3C4);
const color4 = Color(0xFFC1F8CF);

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  String token = "";
  int totalSurat = 0;
  int totalProses = 0;
  int totalSelesai = 0;
  int totalUnread = 0;
  int totalUnkonf = 0;
  List<Dbsuratmasuk> dataSuratMasuk = [];
  @override
  void initState() {
    super.initState();
    getDbSurat();
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
        title: Text("E-Surat Kota Kediri"),
        backgroundColor: color1,
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: SafeArea(
            child: Center(
                child: Column(
          children: [
            Text("Selamat Datang di Aplikasi E-Surat Kota Kediri",
                style: TextStyle(
                    color: color1, fontSize: 20, fontWeight: FontWeight.bold)),
            Divider(),
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
                      "Total Surat Masuk      : ${totalSurat}",
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    ),
                    Divider(),
                    Text(
                      "Total Dalam Proses    : ${totalProses}",
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    ),
                    Divider(),
                    Text(
                      "Total Surat Selesai     : ${totalSelesai}",
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    ),
                    Divider(),
                    Text(
                      "Total Belum Dibaca    : ${totalUnread}",
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    ),
                    Divider(),
                    Text(
                      "Total Belum Disetujui : ${totalUnkonf}",
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ))),
      ),
    );
  }

  Future<bool> getDbSurat() async {
    try {
      SharedPreferences pref = await SharedPreferences.getInstance();
      setState(() {
        token = pref.getString("token")!;
      });
      if (token != '') {
        Map<String, String> requestHeaders = {
          'Authorization': token,
        };
        var response = await http.get(
            Uri.parse(
                "https://simponik.kedirikota.go.id/api/inbox?id=496&param=all"),
            // "https://sigap.kedirikota.go.id/apiesuratpkl/public/dashboard"),
            headers: requestHeaders);

        if (response.statusCode == 200) {
          totalSurat =
              (jsonDecode(response.body) as Map<String, dynamic>)["totalSurat"];
          totalProses = (jsonDecode(response.body)
              as Map<String, dynamic>)["totalProses"];
          totalSelesai = (jsonDecode(response.body)
              as Map<String, dynamic>)["totalSelesai"];
          totalUnread = (jsonDecode(response.body)
              as Map<String, dynamic>)["totalUnread"];
          totalUnkonf = (jsonDecode(response.body)
              as Map<String, dynamic>)["totalUnkonf"];

          setState(() {});
          return true;
        } else {
          return false;
        }
      } else {
        return false;
      }
    } catch (e) {
      print(e);
      return false;
    }
  }
}

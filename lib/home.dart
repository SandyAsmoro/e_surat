import 'dart:convert';

// import 'package:e_surat/models/dbsuratmasuk.dart';
import 'package:e_surat/models/suratkeluar.dart';
import 'package:flutter/material.dart';
// import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

import 'models/suratmasuk.dart';

const color1 = Color.fromARGB(255, 27, 0, 71);
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
  String id = "";
  int totalSurat = 0;
  int totalSuratKeluar = 0;
  int totalProses = 0;
  int totalSelesai = 0;
  int totalUnread = 0;
  int totalUnread2 = 0;
  int totalUnkonf = 0;
  List<SuratMasuk> suratMasuk = [];
  List<SuratKeluar> suratKeluar = [];
  // late FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;

  @override
  void initState() {
    super.initState();
    // var initializationSettingsAndroid = AndroidInitializationSettings('app_icon');
    // // var initializationSettingsIOS = IOSInitializationSettings();
    // var initializationSettings = InitializationSettings(
    //   android: initializationSettingsAndroid, 
    //   // iOS: initializationSettingsIOS,
    // );
    // flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
    // flutterLocalNotificationsPlugin.initialize(initializationSettings);
    getDbSurat();
  }

  // Future<void> _showNotification() async {
  //   var androidPlatformChannelSpecifics = AndroidNotificationDetails(
  //     'your channel id', 
  //     'your channel name', 
  //     // 'your channel description',
  //     importance: Importance.max,
  //     priority: Priority.high,
  //   );
  //   // var iOSPlatformChannelSpecifics = IOSNotificationDetails();
  //   var platformChannelSpecifics = NotificationDetails(
  //     android: androidPlatformChannelSpecifics, 
  //     // iOS: iOSPlatformChannelSpecifics,
  //   );
  //   await flutterLocalNotificationsPlugin.show(
  //     0, 
  //     'New message', 
  //     'You have received a new message.', 
  //     platformChannelSpecifics,
  //   );
  // }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: Text("Home"),
      //   backgroundColor: color1,
      // ),
      backgroundColor: Color.fromARGB(255, 27, 0, 71),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            height: 110,
          ),
          SizedBox(
            child: Image.asset("assets/icon/icon.png"),
            height: 150,
          ),
          Container(
            height: 65,
            padding: const EdgeInsets.all(0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text('ASN Digital'.toUpperCase(),
                    style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                        color: Colors.white, fontWeight: FontWeight.bold)),
              ],
            ),
          ),
          Expanded(
            child: Container(
              decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      topRight: Radius.circular(30),
                      topLeft: Radius.circular(30))),
              child: ListView(
                padding: const EdgeInsets.all(20),
                children: [
                  Container(
                    child: DataTable(
                      columns: <DataColumn>[
                        DataColumn(label: Text("Data Surat")),
                        DataColumn(label: Text("Jumlah")),
                      ],
                      rows: <DataRow>[
                        DataRow(
                          cells: <DataCell>[
                            DataCell(Text("Total Surat Masuk")),
                            DataCell(Text("${totalSurat}")),
                          ],
                        ),
                        DataRow(
                          cells: <DataCell>[
                            DataCell(Text("Total Surat Keluar")),
                            DataCell(Text("${totalSuratKeluar}")),
                          ],
                        ),
                        DataRow(
                          cells: <DataCell>[
                            DataCell(Text("Total Dalam Proses")),
                            DataCell(Text("${totalProses}")),
                          ],
                        ),
                        DataRow(
                          cells: <DataCell>[
                            DataCell(Text("Total Surat Selesai")),
                            DataCell(Text("${totalSelesai}")),
                          ],
                        ),
                        DataRow(
                          cells: <DataCell>[
                            DataCell(Text("Surat Masuk Belum Dibaca")),
                            DataCell(Text("${totalUnread}")),
                          ],
                        ),
                        DataRow(
                          cells: <DataCell>[
                            DataCell(Text("Surat Keluar Belum Dibaca")),
                            DataCell(Text("${totalUnread2}")),
                          ],
                        ),
                        DataRow(
                          cells: <DataCell>[
                            DataCell(Text("Total Belum Disetujui")),
                            DataCell(Text("${totalUnkonf}")),
                          ],
                        ),
                      ],
                      decoration: BoxDecoration(
                        color: Color.fromARGB(255, 255, 255, 255),
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(
                              offset: const Offset(0, 5),
                              color: Color.fromARGB(255, 255, 255, 255)
                                  .withOpacity(.2),
                              spreadRadius: 5,
                              blurRadius: 10)
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  Future<bool> getDbSurat() async {
  try {
    SharedPreferences pref = await SharedPreferences.getInstance();
    setState(() {
      token = pref.getString("token")!;
      id = pref.getString("id")!;
    });
    
    if (token != '') {
      Map<String, String> requestHeaders = {
        'Authorization': token,
      };
      
      List<SuratMasuk> allSuratMasuk = [];
      List<SuratKeluar> allSuratKeluar = [];
      
      int currentPage = 1;
      bool isNextPageAvailable = true;
      
      while (isNextPageAvailable) {
        var response = await http.get(
          Uri.parse("https://simponik.kedirikota.go.id/api/inbox?id=$id&param=all&page=$currentPage"),
          headers: requestHeaders,
        );
        
        if (response.statusCode == 200) {
          final bd = jsonDecode(response.body);
          List data = bd['inbox'];
          if (data.isEmpty) {
            isNextPageAvailable = false;
          } else {
            data.forEach((element) {
              allSuratMasuk.add(SuratMasuk.fromJson(element));
            });
            currentPage++;
          }
      totalSurat = bd['total'];
        } else {
          return false;
        }
      }
      
      int currentPage2 = 1;
      isNextPageAvailable = true;
      
      while (isNextPageAvailable) {
        var response2 = await http.get(
          Uri.parse("https://simponik.kedirikota.go.id/api/outbox?id=$id&param=all&page=$currentPage2"),
          headers: requestHeaders,
        );
        
        if (response2.statusCode == 200) {
          final bd2 = jsonDecode(response2.body);
          List data2 = bd2['outbox'];
          if (data2.isEmpty) {
            isNextPageAvailable = false;
          } else {
            data2.forEach((element) {
              allSuratKeluar.add(SuratKeluar.fromJson(element));
            });
            currentPage2++;
          }
      totalSuratKeluar = bd2['total'];
        } else {
          return false;
        }
      }
      
      // Setelah mendapatkan semua data, Anda dapat melakukan proses sesuai kebutuhan
      suratMasuk.addAll(allSuratMasuk);
      suratKeluar.addAll(allSuratKeluar);
      
      totalProses = suratMasuk.where((item) => item.state != "SELESAI").length;
      totalSelesai = suratMasuk.where((item) => item.state == "SELESAI").length;
      totalUnread = suratMasuk.where((item) => item.isbaca != "1").length;
      totalUnread2 = suratKeluar.where((item) => item.isbaca != "1").length;
      totalUnkonf = suratKeluar.where((item) => item.state != "DISETUJUI").length;

      setState(() {});
      return true;
    } else {
      return false;
    }
  } catch (e) {
    print(e);
    return false;
  }
}

}

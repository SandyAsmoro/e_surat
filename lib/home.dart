import 'dart:convert';

import 'package:e_surat/models/dbsuratmasuk.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

import 'models/suratmasuk.dart';

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
  List<SuratMasuk> suratMasuk = [];
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
      backgroundColor: Color.fromARGB(255, 27, 0, 71),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            height: 80,
          ),
          SizedBox(
            child: Image.asset("assets/icon/icon.png"),
            height: 80,
          ),
          Container(
            height: 65,
            padding: const EdgeInsets.all(0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text('E-Surat'.toUpperCase(),
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
                            DataCell(Text("Total Belum Dibaca")),
                            DataCell(Text("${totalUnread}")),
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
          final bd = jsonDecode(response.body);
          List data = bd['inbox'];
          // print(data);
          data.forEach((element) {
            suratMasuk.add(SuratMasuk.fromJson(element));
          });
          // totalSurat =
          //     (jsonDecode(response.body) as Map<String, dynamic>)["totalSurat"];
          totalSurat = data.length;
          // totalProses = (jsonDecode(response.body)
          //     as Map<String, dynamic>)["totalProses"];
          // totalSelesai = (jsonDecode(response.body)
          //     as Map<String, dynamic>)["totalSelesai"];
          // totalUnread = (jsonDecode(response.body)
          //     as Map<String, dynamic>)["totalUnread"];
          // totalUnkonf = (jsonDecode(response.body)
          //     as Map<String, dynamic>)["totalUnkonf"];
          totalProses = data.length;
          totalSelesai = data.length;
          totalUnread = data.length;
          totalUnkonf = data.length;

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

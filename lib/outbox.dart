import 'dart:convert';

import 'package:e_surat/detailsk.dart';
import 'package:e_surat/models/suratkeluar.dart';
import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

const color1 = Color.fromARGB(255, 27, 0, 71);
const color2 = Color(0xFF488FB1);
const color3 = Color(0xFF4FD3C4);
const color4 = Color(0xFFC1F8CF);

class Outbox extends StatefulWidget {
  const Outbox({Key? key}) : super(key: key);

  @override
  _OutboxState createState() => _OutboxState();
}

class _OutboxState extends State<Outbox> {
  String token = "";
  String id = "";
  int currentPage = 0;
  late int totalPages;
  final RefreshController _refreshController =
      RefreshController(initialRefresh: true);
  List<SuratKeluar> suratKeluar = [];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Outbox"),
        backgroundColor: color1,
      ),
      body: SmartRefresher(
        controller: _refreshController,
        enablePullUp: true,
        onRefresh: () async {
          suratKeluar.clear();
          final result = await getSurat(isRefreshed: true);
          if (result == true) {
            _refreshController.refreshCompleted();
          } else {
            _refreshController.refreshFailed();
          }
        },
        onLoading: () async {
          final result = await getSurat();
          if (result == true) {
            _refreshController.loadComplete();
          } else {
            _refreshController.loadFailed();
          }
        },
        footer: CustomFooter(
          builder: (context, mode) {
            Widget body;
            if (mode == LoadStatus.loading) {
              body = CircularProgressIndicator();
            } else if (mode == LoadStatus.failed) {
              body = Text("Load Failed!Click retry!");
            } else if (mode == LoadStatus.canLoading) {
              body = Text("release to load more");
            } else {
              body = Text("No more Data");
            }
            return Container(
              height: 55.0,
              child: Center(
                child: body,
              ),
            );
          },
        ),
        child: ListView.separated(
            itemBuilder: (context, index) {
              return ListTile(
                leading: (suratKeluar[index].isbaca == "1")
                    ? Icon(
                        Icons.mark_email_read_outlined,
                        color: Colors.green,
                      )
                    : Icon(
                        Icons.mark_email_unread_outlined,
                        color: Colors.red,
                      ),
                title: Text("${suratKeluar[index].perihal}"),
                subtitle: Text("${suratKeluar[index].sUserName}"),
                trailing: Text("${suratKeluar[index].tglSurat}"),
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => Detailsk(
                            sk: suratKeluar[index],
                          )));
                },
              );
            },
            separatorBuilder: (context, index) => Divider(),
            itemCount: suratKeluar.length),
      ),
    );
  }

  Future<bool> getSurat({bool isRefreshed = false}) async {
    try {
      SharedPreferences pref = await SharedPreferences.getInstance();
      setState(() {
        token = pref.getString("token")!;
        id = pref.getString("id")!;
      });
      if (token != null) {
        if (isRefreshed) {
          currentPage = 0;
        }
        Map<String, String> requestHeaders = {
          'Authorization': token,
        };
        var response = await http.get(
            Uri.parse(
                "https://simponik.kedirikota.go.id/api/outbox?id=$id&param=all"),
            // "https://sigap.kedirikota.go.id/apiesuratpkl/public/surat_keluar?page=${currentPage}"),
            headers: requestHeaders);
        if (response.statusCode == 200) {
          final bd = jsonDecode(response.body);
          List data = bd['outbox'];
          // List data =
          //     (jsonDecode(response.body) as Map<String, dynamic>)["data"];
          data.forEach((element) {
            suratKeluar.add(SuratKeluar.fromJson(element));
          });
          currentPage++;
          totalPages = data.length;
          // totalPages =
          //     (jsonDecode(response.body) as Map<String, dynamic>)["totalPage"];
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

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:e_surat/models/suratmasuk.dart';
import 'package:e_surat/detailsm.dart';

const color1 = Color(0xFF533E85);
const color2 = Color(0xFF488FB1);
const color3 = Color(0xFF4FD3C4);
const color4 = Color(0xFFC1F8CF);

class Inbox extends StatefulWidget {
  const Inbox({Key? key}) : super(key: key);

  @override
  _InboxState createState() => _InboxState();
}

class _InboxState extends State<Inbox> {
  String token = "";
  int currentPage = 0;
  late int totalPages;
  final RefreshController _refreshController =
      RefreshController(initialRefresh: true);
  List<SuratMasuk> suratMasuk = [];

  @override
  void initState() {
    super.initState();
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
        title: Text("Inbox"),
        backgroundColor: color1,
      ),
      body: SmartRefresher(
        controller: _refreshController,
        enablePullUp: true,
        onRefresh: () async {
          suratMasuk.clear();
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
              // print("status surat ${index}: ${suratMasuk[index].baca}");
              return ListTile(
                leading: (suratMasuk[index].isbaca == "1")
                    ? Icon(
                        Icons.mark_email_read_outlined,
                        color: Colors.green,
                      )
                    : Icon(
                        Icons.mark_email_unread_outlined,
                        color: Colors.red,
                      ),
                title: Text("${suratMasuk[index].perihal}"),
                subtitle: Text("${suratMasuk[index].dari}"),
                trailing: Text("${suratMasuk[index].tglSurat}"),
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => Detailsm(
                            sm: suratMasuk[index],
                          )));
                  //     .then((value) {
                  //   setState(() {
                  //     suratMasuk.clear();
                  //     getSurat(isRefreshed: true);
                  //   });
                  // });
                },
              );
            },
            separatorBuilder: (context, index) => Divider(),
            itemCount: suratMasuk.length),
      ),
    );
  }

  Future<bool> getSurat({bool isRefreshed = false}) async {
    try {
      SharedPreferences pref = await SharedPreferences.getInstance();
      setState(() {
        token = pref.getString("token")!;
        print("token inbox");
        print(token);
      });
      if (token != '') {
        if (isRefreshed) {
          currentPage = 0;
        }
        ;
        Map<String, String> requestHeaders = {
          'Authorization': token,
        };
        final response = await http.get(
            Uri.parse(
                "https://simponik.kedirikota.go.id/api/inbox?id=496&param=all"),
            // "https://sigap.kedirikota.go.id/apiesuratpkl/public/surat_masuk?page=${currentPage}"),
            headers: requestHeaders);
        print("response :");
        print(response);
        if (response.statusCode == 200) {
          // print("response.statusCode");
          // print(response.statusCode);
          print(jsonDecode(response.body));
          // print(response.body);
          List data =
              (jsonDecode(response.body) as Map<String, dynamic>)["data"];
          print(data);
          data.forEach((element) {
            suratMasuk.add(SuratMasuk.fromJson(element));
          });
          // print(data);
          currentPage++;
          print(data[0]);
          totalPages =
              (jsonDecode(response.body) as Map<String, dynamic>)["totalPage"];
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

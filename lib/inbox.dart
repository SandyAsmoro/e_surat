import 'dart:convert';

import 'package:e_surat/detailsm.dart';
import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

import 'models/suratmasuk.dart';

const color1 = Color.fromARGB(255, 27, 0, 71);
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
  String id = "";
  int currentPage = 1;
  int totalPages = 0;
  final RefreshController _refreshController =
      RefreshController(initialRefresh: true);
  late List<SuratMasuk> suratMasuk;
  late List<SuratMasuk> displayedSuratMasuk;
  late TextEditingController searchController;

  @override
  void initState() {
    super.initState();
    suratMasuk = [];
    displayedSuratMasuk = [];
    searchController = TextEditingController();
    getSurat();
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Surat Masuk"),
        backgroundColor: color1,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: searchController,
              onChanged: (value) {
                searchSuratMasuk(value);
              },
              decoration: InputDecoration(
                labelText: 'Cari',
              ),
            ),
          ),
          Expanded(
            child: SmartRefresher(
              controller: _refreshController,
              enablePullUp: true,
              onRefresh: () async {
                suratMasuk.clear();
                currentPage = 1;
                await getSurat(isRefreshed: true);
                _refreshController.refreshCompleted();
              },
              onLoading: () async {
                if (currentPage < totalPages) {
                  currentPage++;
                  await getSurat();
                  _refreshController.loadComplete();
                } else {
                  _refreshController.loadNoData();
                }
              },
              footer: CustomFooter(
                builder: (context, mode) {
                  Widget body;
                  if (mode == LoadStatus.idle) {
                    body = CircularProgressIndicator();
                  } else if (mode == LoadStatus.failed) {
                    body = Text("Load Failed! Click retry!");
                  } else if (mode == LoadStatus.canLoading) {
                    body = Text("Release to load more");
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
                    leading: (displayedSuratMasuk[index].isbaca == "1")
                        ? Icon(
                            Icons.mark_email_read,
                            color: Colors.green,
                          )
                        : Icon(
                            Icons.mark_email_unread,
                            color: Colors.red,
                          ),
                    title: Text("${displayedSuratMasuk[index].perihal}"),
                    subtitle: Text("${displayedSuratMasuk[index].sUserName}"),
                    trailing: Text("${displayedSuratMasuk[index].tglSurat}"),
                    onTap: () {
                      Navigator.of(context)
                          .push(MaterialPageRoute(
                            builder: (context) => Detailsm(
                              sm: displayedSuratMasuk[index],
                            ),
                          ))
                          .then((value) {
                        _refreshController.requestRefresh();
                      });
                    },
                  );
                },
                separatorBuilder: (context, index) => Divider(),
                itemCount: displayedSuratMasuk.length,
              ),
            ),
          ),
        ],
      ),
    );
  }

  void sortDataDesc() {
    suratMasuk.sort((a, b) =>
        DateTime.parse(b.tglSurat).compareTo(DateTime.parse(a.tglSurat)));
  }

  Future<void> getSurat({bool isRefreshed = false}) async {
    try {
      SharedPreferences pref = await SharedPreferences.getInstance();
      setState(() {
        token = pref.getString("token")!;
        id = pref.getString("id")!;
      });
      if (token != '') {
        if (isRefreshed) {
          currentPage = 1;
          suratMasuk.clear();
          displayedSuratMasuk.clear();
        }
        Map<String, String> requestHeaders = {
          'Authorization': token,
        };
        var response = await http.get(
          Uri.parse(
            "https://simponik.kedirikota.go.id/api/inbox?id=$id&param=all&page=$currentPage",
          ),
          headers: requestHeaders,
        );
        if (response.statusCode == 200) {
          final Map<String, dynamic> bd = jsonDecode(response.body);
          final List<dynamic> suratMasukList = bd['inbox'];
          List<SuratMasuk> data = [];
          for (var item in suratMasukList) {
            data.add(SuratMasuk.fromJson(item));
          }

          totalPages = int.parse(response.headers['x-wp-totalpages'] ?? '0');

          if (isRefreshed) {
            setState(() {
              suratMasuk = data;
              displayedSuratMasuk = data;
            });
          } else {
            setState(() {
              suratMasuk.addAll(data);
              displayedSuratMasuk.addAll(data);
            });
          }
          sortDataDesc();
        }
      }
    } catch (e) {
      print(e);
    }
  }

  void searchSuratMasuk(String query) {
    setState(() {
      displayedSuratMasuk = suratMasuk.where((surat) {
        final perihalLower = surat.perihal.toLowerCase();
        final queryLower = query.toLowerCase();
        return perihalLower.contains(queryLower);
      }).toList();
    });
  }
}

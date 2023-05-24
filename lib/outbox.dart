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
  int currentPage = 1;
  int totalPages = 0;
  final RefreshController _refreshController =
      RefreshController(initialRefresh: true);
  late List<SuratKeluar> suratKeluar;
  late List<SuratKeluar> displayedSuratKeluar;
  late TextEditingController searchController;

  @override
  void initState() {
    super.initState();
    suratKeluar = [];
    displayedSuratKeluar = [];
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
        title: Text("Surat Keluar"),
        backgroundColor: color1,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: searchController,
              onChanged: (value) {
                searchSuratKeluar(value);
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
                suratKeluar.clear();
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
                    leading: (displayedSuratKeluar[index].isbaca == "1")
                        ? Icon(
                            Icons.mark_email_read,
                            color: Colors.green,
                          )
                        : Icon(
                            Icons.mark_email_unread,
                            color: Colors.red,
                          ),
                    title: Text("${displayedSuratKeluar[index].perihal}"),
                    subtitle: Text("${displayedSuratKeluar[index].sUserName}"),
                    trailing: Text("${displayedSuratKeluar[index].tglSurat}"),
                    onTap: () {
                      Navigator.of(context)
                          .push(MaterialPageRoute(
                            builder: (context) => Detailsk(
                              sk: displayedSuratKeluar[index],
                            ),
                          ))
                          .then((value) {
                        _refreshController.requestRefresh();
                      });
                    },
                  );
                },
                separatorBuilder: (context, index) => Divider(),
                itemCount: displayedSuratKeluar.length,
              ),
            ),
          ),
        ],
      ),
    );
  }
  // @override
  // Widget build(BuildContext context) {
  //   return Scaffold(
  //     appBar: AppBar(
  //       title: Text("Surat Keluar"),
  //       backgroundColor: color1,
  //     ),
  //     body: SmartRefresher(
  //       controller: _refreshController,
  //       enablePullUp: true,
  //       onRefresh: () async {
  //         suratKeluar.clear();
  //         final result = await getSurat(isRefreshed: true);
  //         if (result == true) {
  //           setState(() {});
  //           _refreshController.refreshCompleted();
  //         } else {
  //           _refreshController.refreshFailed();
  //         }
  //       },
  //       // onLoading: () async {
  //       //   final result = await getSurat();
  //       //   if (result == true) {
  //       //     _refreshController.loadComplete();
  //       //   } else {
  //       //     _refreshController.loadFailed();
  //       //   }
  //       // },
  //       footer: CustomFooter(
  //         builder: (context, mode) {
  //           Widget body;
  //           if (mode == LoadStatus) {
  //             body = CircularProgressIndicator();
  //           } else if (mode == LoadStatus.failed) {
  //             body = Text("Load Failed!Click retry!");
  //           } else if (mode == LoadStatus.canLoading) {
  //             body = Text("release to load more");
  //           } else {
  //             body = Text("No more Data");
  //           }
  //           return Container(
  //             height: 55.0,
  //             child: Center(
  //               child: body,
  //             ),
  //           );
  //         },
  //       ),
  //       child: ListView.separated(
  //           itemBuilder: (context, index) {
  //             return ListTile(
  //               leading: (suratKeluar[index].isbaca == "1")
  //                   ? Icon(
  //                       Icons.mark_email_read,
  //                       color: Colors.green,
  //                     )
  //                   : Icon(
  //                       Icons.mark_email_unread,
  //                       color: Colors.red,
  //                     ),
  //               title: Text("${suratKeluar[index].perihal}"),
  //               subtitle: Text("${suratKeluar[index].sUserName}"),
  //               trailing: Text("${suratKeluar[index].tglSurat}"),
  //               onTap: () {
  //                 Navigator.of(context)
  //                     .push(MaterialPageRoute(
  //                         builder: (context) => Detailsk(
  //                               sk: suratKeluar[index],
  //                             )))
  //                     .then((value) {
  //                   _refreshController.requestRefresh();
  //                 });
  //               },
  //             );
  //           },
  //           separatorBuilder: (context, index) => Divider(),
  //           itemCount: suratKeluar.length),
  //     ),
  //   );
  // }

  void sortDataDesc() {
    suratKeluar.sort((a, b) =>
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
          suratKeluar.clear();
          displayedSuratKeluar.clear();
        }
        Map<String, String> requestHeaders = {
          'Authorization': token,
        };
        var response = await http.get(
            Uri.parse(
                "https://simponik.kedirikota.go.id/api/outbox?id=$id&param=all"),
            headers: requestHeaders);
        if (response.statusCode == 200) {
          final Map<String, dynamic> bd = jsonDecode(response.body);
          final List<dynamic> suratKeluarList = bd['outbox'];
          List<SuratKeluar> data = [];
          for (var item in suratKeluarList) {
            data.add(SuratKeluar.fromJson(item));
          }

          totalPages = int.parse(response.headers['x-wp-total'] ?? '0');

          if (isRefreshed) {
            setState(() {
              suratKeluar = data;
              displayedSuratKeluar = data;
            });
          } else {
            setState(() {
              suratKeluar.addAll(data);
              displayedSuratKeluar.addAll(data);
            });
          }
          sortDataDesc();
        }
      }
    } catch (e) {
      print(e);
    }
  }

    void searchSuratKeluar(String query) {
    setState(() {
      displayedSuratKeluar = suratKeluar.where((surat) {
        final perihalLower = surat.perihal.toLowerCase();
        final queryLower = query.toLowerCase();
        return perihalLower.contains(queryLower);
      }).toList();
    });
  }
  //       // if (response.statusCode == 200) {
  //         // final bd = jsonDecode(response.body);
  //         // List data = bd['outbox'];
  //         // // List data =
  //         // //     (jsonDecode(response.body) as Map<String, dynamic>)["data"];
  //         // data.forEach((element) {
  //         //   suratKeluar.add(SuratKeluar.fromJson(element));
  //         //   sortDataDesc();
  //         // });
  //         // currentPage++;
  //         totalPages = data.length;
  //         // totalPages =
  //         //     (jsonDecode(response.body) as Map<String, dynamic>)["totalPage"];
  //         setState(() {});
  //         return true;
  //       } else {
  //         return false;
  //       }
  //     } else {
  //       return false;
  //     }
  //   } catch (e) {
  //     print(e);
  //     return false;
  //   }
  // }
}

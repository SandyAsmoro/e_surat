import 'dart:convert';

import 'package:e_surat/disposk.dart';
import 'package:e_surat/models/disposisisk.dart';
import 'package:e_surat/models/suratkeluar.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:shared_preferences/shared_preferences.dart';

const color1 = Color.fromARGB(255, 27, 0, 71);
class Detailsk extends StatefulWidget {
  final SuratKeluar sk;
  const Detailsk({Key? key, required this.sk}) : super(key: key);

  @override
  State<Detailsk> createState() => _DetailskState();
}

class _DetailskState extends State<Detailsk> {
  String token = "";
  String id_user = "";
  String isbaca = "";
  String tglbaca = "";
  int currentPage = 0;
  late int totalPages;
  String konf = "";
  final RefreshController _refreshController =
      RefreshController(initialRefresh: true);

  List<Disposisisk> disposisisk = [];

  @override
  void initState() {
    super.initState();
    setBaca();
    konf = widget.sk.state;
  }

  @override
  void dispose() {
    // ignore: todo
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Detail Surat Keluar"),
        backgroundColor: Color.fromARGB(255, 27, 0, 71),
      ),
      body: Column(
        children: [
          SizedBox(
            height: 10,
          ),
          Card(
            clipBehavior: Clip.antiAlias,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            shadowColor: Colors.black,
            elevation: 10,
            child: Container(
              decoration: BoxDecoration(
                  gradient: LinearGradient(colors: [
                Color.fromARGB(255, 27, 0, 71),
                Color.fromARGB(255, 188, 48, 201),
              ], stops: [
                0.2,
                0.9
              ], begin: Alignment.topLeft, end: Alignment.bottomRight)),
              padding: EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Nomor Surat",
                    style: TextStyle(color: Colors.white, fontSize: 9),
                  ),
                  Text(
                    "${widget.sk.noSurat}",
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ),
                  Divider(),
                  Text(
                    "Perihal",
                    style: TextStyle(color: Colors.white, fontSize: 9),
                  ),
                  Text(
                    "${widget.sk.perihal}",
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ),
                  Divider(),
                  Text(
                    "Tanggal Surat",
                    style: TextStyle(color: Colors.white, fontSize: 9),
                  ),
                  Text(
                    "${widget.sk.tglSurat}",
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ),
                  Divider(),
                  // Text(
                  //   "${widget.sm.ttd}",
                  //   style: TextStyle(color: Colors.white, fontSize: 16),
                  // ),
                  // Text(
                  //   "Tanda Tangan",
                  //   style: TextStyle(color: Colors.white, fontSize: 9),
                  // ),
                ],
              ),
            ),
          ),
          // Expanded(

          //   child: Container(
          //     height: 150,
          //     width: 350,
          //     decoration: const BoxDecoration(
          //         color: Color.fromARGB(255, 27, 0, 71),
          //         borderRadius: BorderRadius.only(
          //             topRight: Radius.circular(15),
          //             topLeft: Radius.circular(15),
          //             bottomLeft: Radius.circular(15),
          //             bottomRight: Radius.circular(15))),
          //     child: ListView(
          //       padding: const EdgeInsets.all(10),
          //       children: [
          //         SizedBox(
          //           width: 350.0,
          //           height: 48.0,
          //           child: Card(
          //             color: Color.fromARGB(255, 255, 255, 255),
          //             child: Text(
          //               textAlign: TextAlign.center,
          //               "Nomor Surat :\n${widget.sk.noSurat}",
          //               style: TextStyle(
          //                 fontWeight: FontWeight.w500,
          //                 color: Colors.black,
          //                 fontSize: 16,
          //               ),
          //             ),
          //           ),
          //         ),
          //         SizedBox(
          //           width: 350.0,
          //           height: 48.0,
          //           child: Card(
          //             color: Color.fromARGB(255, 255, 255, 255),
          //             child: Text(
          //               textAlign: TextAlign.center,
          //               "Perihal ${widget.sk.perihal}",
          //               style: TextStyle(
          //                 fontWeight: FontWeight.w500,
          //                 color: Colors.black,
          //                 fontSize: 16,
          //               ),
          //             ),
          //           ),
          //         ),
          //         SizedBox(
          //           width: 350.0,
          //           height: 48.0,
          //           child: Card(
          //             color: Color.fromARGB(255, 255, 255, 255),
          //             child: Text(
          //               textAlign: TextAlign.center,
          //               "Kepada ${widget.sk.rUserName}",
          //               style: TextStyle(
          //                 fontWeight: FontWeight.w500,
          //                 color: Colors.black,
          //                 fontSize: 16,
          //               ),
          //             ),
          //           ),
          //         ),
          //         SizedBox(
          //           width: 350.0,
          //           height: 48.0,
          //           child: Card(
          //             color: Color.fromARGB(255, 255, 255, 255),
          //             child: Text(
          //               textAlign: TextAlign.center,
          //               "Tanggal Surat ${widget.sk.tglSurat}",
          //               style: TextStyle(
          //                 fontWeight: FontWeight.w500,
          //                 color: Colors.black,
          //                 fontSize: 16,
          //               ),
          //             ),
          //           ),
          //         ),
          // SizedBox(
          //   width: 350.0,
          //   height: 48.0,
          //   child: Card(
          //     color: Color.fromARGB(255, 255, 255, 255),
          //     child: Text(
          //       textAlign: TextAlign.center,
          //      "TTD ${widget.sk.ttd}",
          //       style: TextStyle(
          //         fontWeight: FontWeight.w500,
          //         color: Colors.black,
          //         fontSize: 16,
          //       ),
          //     ),
          //   ),
          // ),
          //       ],
          //     ),
          //   ),
          // ),
          // Divider(),
          (konf == "DISETUJUI")
              ? Center(
                  child: ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: color1,
                  ),
                  onPressed: () {
                    print("Disposisi pressed ${widget.sk.id}");
                    Navigator.of(context)
                        .push(MaterialPageRoute(
                            builder: (context) => Disposk(
                                  dispo: widget.sk,
                                )))
                        .then((value) {
                      setState(() {
                        disposisisk.clear();
                        getDispo(isRefreshed: true);
                      });
                    });
                  },
                  icon: Icon(Icons.send_to_mobile_outlined),
                  label: Text("Disposisi"),
                ))
              : Center(
                  child: ElevatedButton.icon(
                  onPressed: () async {
                    var response = await http.post(
                        Uri.parse(
                            "https://simponik.kedirikota.go.id/api/outbox?id=${widget.sk.id}"),
                        // "https://sigap.kedirikota.go.id/apiesuratpkl/public/surat_keluar/konfirmasi"),
                        body: ({
                          "id_skwf": widget.sk.id,
                        }));
                    if (response.statusCode == 200) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text("Konfirmasi Berhasil"),
                          margin: EdgeInsets.all(30),
                          behavior: SnackBarBehavior.floating,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(50),
                          ),
                        ),
                      );
                      setState(() {
                        konf = "1";
                      });
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text("Server Error"),
                          margin: EdgeInsets.all(30),
                          behavior: SnackBarBehavior.floating,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(50),
                          ),
                        ),
                      );
                    }
                  },
                  icon: Icon(Icons.check),
                  label: Text("Konfirmasi"),
                )),
          Divider(),
          Text("Riwayat Disposisi Surat"),
          Divider(),
          Expanded(
            child: SmartRefresher(
              controller: _refreshController,
              enablePullUp: true,
              onRefresh: () async {
                disposisisk.clear();
                final result = await getDispo(isRefreshed: true);
                if (result == true) {
                  _refreshController.refreshCompleted();
                } else {
                  _refreshController.refreshFailed();
                }
              },
              // onLoading: () async {
              //   final result = await getDispo();
              //   if (result == true) {
              //     _refreshController.loadComplete();
              //   } else {
              //     _refreshController.loadFailed();
              //   }
              // },
              footer: CustomFooter(
                builder: (context, mode) {
                  Widget body;
                  if (mode == LoadStatus) {
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
                    leading: Text("${disposisisk[index].state}"),
                    title: Text("Dari ${disposisisk[index].sUser}"),
                    subtitle: Text("${disposisisk[index].catatan}"),
                    trailing: Text("Kepada ${disposisisk[index].rUser}"),
                  );
                },
                separatorBuilder: (context, index) => Divider(),
                itemCount: disposisisk.length,
              ),
            ),
          )
        ],
      ),
    );
  }

  Future setBaca() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    setState(() {
      // token = pref.getString("token")!;
      id_user = pref.getString("id")!;
    });
    var response = await http.post(
        Uri.parse("https://simponik.kedirikota.go.id/api/readoutbox"),
        // "https://sigap.kedirikota.go.id/apiesuratpkl/public/surat_keluar/baca"),
        body: ({
          "sk_id": widget.sk.id,
          "user_id": id_user,
        }));
    // print(id_user);
    // print(widget.sk.id);
    if (response.statusCode == 200) {
      final body = jsonDecode(response.body);
      print("body :");
      print(body);

      // SharedPreferences pref = await SharedPreferences.getInstance();
      // pref.setString("isbaca", body['isbaca']);
      // pref.setString("tgl_baca", body['tgl_baca']);
      // setState(() {
      //   isbaca = pref.getString("isbaca")!;
      //   tglbaca = pref.getString("tgl_baca")!;
      //   print("isBaca");
      //   print(isbaca);
      // });
      // return true;
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Server Error"),
          margin: EdgeInsets.all(30),
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(50),
          ),
        ),
      );
    }
  }

  Future<bool> getDispo({bool isRefreshed = false}) async {
    try {
      SharedPreferences pref = await SharedPreferences.getInstance();
      setState(() {
        token = pref.getString("token")!;
        id_user = pref.getString("id")!;
      });
      // print(currentPage);
      if (token != '') {
        if (isRefreshed) {
          currentPage = 0;
        }
        Map<String, String> requestHeaders = {
          'Authorization': token,
        };
        var response = await http.get(
            Uri.parse(
                "https://simponik.kedirikota.go.id/api/outboxdetail?id=${widget.sk.id}"),
            // "https://sigap.kedirikota.go.id/apiesuratpkl/public/listdisposk?idsrt=${widget.sk.idSrt}&page=${currentPage}"),
            headers: requestHeaders);

        // print(response.body);
        if (response.statusCode == 200) {
          final bd = jsonDecode(response.body);
          List data = bd['detailsurat'];
          // List data =
          // (jsonDecode(response.body) as Map<String, dynamic>)["data"];
          data.forEach((element) {
            disposisisk.add(Disposisisk.fromJson(element));
          });
          currentPage++;
          totalPages = data.length;
          // totalPages =
          // (jsonDecode(response.body) as Map<String, dynamic>)["totalPage"];
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

import 'dart:convert';

import 'package:e_surat/disposk.dart';
import 'package:e_surat/models/disposisisk.dart';
import 'package:e_surat/models/suratkeluar.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Detailsk extends StatefulWidget {
  final SuratKeluar sk;
  const Detailsk({Key? key, required this.sk}) : super(key: key);

  @override
  State<Detailsk> createState() => _DetailskState();
}

class _DetailskState extends State<Detailsk> {
  String token = "";
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
    konf = widget.sk.konf;
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
      ),
      body: Column(
        children: [
          Text("Nomor Surat ${widget.sk.noSurat}"),
          Text("Perihal ${widget.sk.perihal}"),
          Text("Kepada ${widget.sk.kepada}"),
          Text("Tanggal Surat ${widget.sk.tglSurat}"),
          Text("TTD ${widget.sk.ttd}"),
          Divider(),
          (konf == "1")
              ? Center(
              child: ElevatedButton.icon(
                onPressed: () {
                  print("Disposisi pressed ${widget.sk.idSrt}");
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
                          "https://sigap.kedirikota.go.id/apiesuratpkl/public/surat_keluar/konfirmasi"),
                      body: ({
                        "id_skwf": widget.sk.idSkwf,
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
              onLoading: () async {
                final result = await getDispo();
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
                    leading: Text("${disposisisk[index].nmstatus}"),
                    title: Text("Dari ${disposisisk[index].pengirim}"),
                    subtitle: Text("${disposisisk[index].catatan}"),
                    trailing: Text("Kepada ${disposisisk[index].penerima}"),
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
    var response = await http.post(
        Uri.parse(
            "https://sigap.kedirikota.go.id/apiesuratpkl/public/surat_keluar/baca"),
        body: ({
          "id_skwf": widget.sk.idSkwf,
        }));
    if (response.statusCode == 200) {
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
                "https://sigap.kedirikota.go.id/apiesuratpkl/public/listdisposk?idsrt=${widget.sk.idSrt}&page=${currentPage}"),
            headers: requestHeaders);

        // print(response.body);
        if (response.statusCode == 200) {
          List data =
          (jsonDecode(response.body) as Map<String, dynamic>)["data"];
          data.forEach((element) {
            disposisisk.add(Disposisisk.fromJson(element));
          });
          currentPage++;
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

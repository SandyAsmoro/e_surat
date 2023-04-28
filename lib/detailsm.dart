import 'dart:convert';
import 'package:e_surat/models/disposisism.dart';
import 'package:e_surat/models/suratmasuk.dart';
import 'package:e_surat/pdfview.dart';
import 'package:e_surat/php_unserialize.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:e_surat/disposm.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:intl/intl.dart';
import 'models/ruserlog.dart';
import 'models/suserlog.dart';

const color1 = Color.fromARGB(255, 27, 0, 71);
const color2 = Color.fromARGB(255, 27, 0, 71);
const color3 = Color.fromARGB(255, 188, 48, 201);
const color4 = Color(0xFFC1F8CF);

class Detailsm extends StatefulWidget {
  final SuratMasuk sm;
  const Detailsm({Key? key, required this.sm}) : super(key: key);

  @override
  State<Detailsm> createState() => _DetailsmState();
}

class _DetailsmState extends State<Detailsm> {
  String token = "";
  String id_user = "";
  String files = "";
  // late String _response1 = "";
  int currentPage = 0;
  late int totalPages;
  String konf = "";
  final RefreshController _refreshController =
      RefreshController(initialRefresh: true);
  List<Disposisism> disposisism = [];
  List<SUserLog> slog = [];
  List<RUserLog> rlog = [];

  @override
  void initState() {
    super.initState();
    setBaca();
    // getFIle();
    konf = widget.sm.state;
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
        title: Text("Detail Surat Masuk"),
        backgroundColor: color1,
      ),
      body: Column(
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
                    "${widget.sm.noSurat}",
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ),
                  Divider(),
                  Text(
                    "Perihal",
                    style: TextStyle(color: Colors.white, fontSize: 9),
                  ),
                  Text(
                    "${widget.sm.perihal}",
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ),
                  Divider(),
                  Text(
                    "Dari",
                    style: TextStyle(color: Colors.white, fontSize: 9),
                  ),
                  Text(
                    "${widget.sm.dari}",
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ),
                  Divider(),
                  Text(
                    "Tanggal Surat",
                    style: TextStyle(color: Colors.white, fontSize: 9),
                  ),
                  Text(
                    "${widget.sm.tglSurat}",
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
          Divider(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Center(
                child: ElevatedButton.icon(
                    onPressed: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => Pdfview(
                                linkPdf: files,
                              )));
                    },
                    icon: Icon(Icons.attach_file),
                    label: Text("File Surat"),
                    style: ElevatedButton.styleFrom(primary: color1)),
              ),
              // (konf == "1")
              //     ? Center(
              //         child: ElevatedButton.icon(
              //         onPressed: () {
              //           // print("Disposisi pressed");
              //           Navigator.of(context)
              //               .push(MaterialPageRoute(
              //                   builder: (context) => Disposm(
              //                         dispo: widget.sm,
              //                       )))
              //               .then((value) {
              //             setState(() {
              //               disposisism.clear();
              //               getDispo(isRefreshed: true);
              //             });
              //           });
              //         },
              //         icon: Icon(Icons.send_to_mobile_outlined),
              //         label: Text("Disposisi"),
              //         style: ElevatedButton.styleFrom(primary: color1),
              //       ))
              //     :
                  // : Center(
                  //     child: ElevatedButton.icon(
                  //     onPressed: () async {
                  //       var response = await http.post(
                  //           Uri.parse(
                  //               "https://simponik.kedirikota.go.id/api/inboxdetail?id=${widget.sm.id}"), //bingung
                  //           // "https://sigap.kedirikota.go.id/apiesuratpkl/public/surat_masuk/konfirmasi"),
                  //           body: ({
                  //             "id_sm": widget.sm.id,
                  //           }));
                  //       if (response.statusCode == 200) {
                  //         ScaffoldMessenger.of(context).showSnackBar(
                  //           SnackBar(
                  //             content: Text("Konfirmasi Berhasil"),
                  //             margin: EdgeInsets.all(30),
                  //             behavior: SnackBarBehavior.floating,
                  //             shape: RoundedRectangleBorder(
                  //               borderRadius: BorderRadius.circular(50),
                  //             ),
                  //           ),
                  //         );
                  //         setState(() {
                  //           konf = "1";
                  //         });
                  //       } else {
                  //         ScaffoldMessenger.of(context).showSnackBar(
                  //           SnackBar(
                  //             content: Text("Server Error01"),
                  //             margin: EdgeInsets.all(30),
                  //             behavior: SnackBarBehavior.floating,
                  //             shape: RoundedRectangleBorder(
                  //               borderRadius: BorderRadius.circular(50),
                  //             ),
                  //           ),
                  //         );
                  //       }
                  //     },
                  //     icon: Icon(Icons.check),
                  //     label: Text("Konfirmasi"),
                  //     style: ElevatedButton.styleFrom(primary: color1),
                  //   )),
                  // (konf == "1")
                  //     ? Center(
                  //         child: ElevatedButton.icon(
                  //         onPressed: () {
                  //           showDialog(
                  //             context: context,
                  //             builder: (context) {
                  //               return AlertDialog(
                  //                 title: Text("PERHATIAN!!"),
                  //                 content: Text(
                  //                     "Apakah anda yakin menyelesaikan disposisi?"),
                  //                 actions: [
                  //                   TextButton(
                  //                       onPressed: () {
                  //                         Navigator.of(context).pop();
                  //                       },
                  //                       child: Text("No")),
                  //                   TextButton(
                  //                       onPressed: () async {
                  //                         var response = await http.post(
                  //                             Uri.parse(
                  //                                 "https://simponik.kedirikota.go.id/api/inbox?id=${widget.sm.id}"),
                  //                             // "https://sigap.kedirikota.go.id/apiesuratpkl/public/surat_masuk/finish"),
                  //                             body: ({
                  //                               "catatan": "Dilaksanakan",
                  //                               // "penerima": jsonEncode(seletedBawahan),
                  //                               "token": token,
                  //                               "id_srt": widget.sm.id
                  //                             }));
                  //                         // print(response.body);
                  //                         if (response.statusCode == 200) {
                  //                           ScaffoldMessenger.of(context)
                  //                               .showSnackBar(
                  //                             SnackBar(
                  //                               content: Text(
                  //                                   "Penyelesaian Surat Berhasil"),
                  //                               margin: EdgeInsets.all(30),
                  //                               behavior:
                  //                                   SnackBarBehavior.floating,
                  //                               shape: RoundedRectangleBorder(
                  //                                 borderRadius:
                  //                                     BorderRadius.circular(50),
                  //                               ),
                  //                             ),
                  //                           );
                  //                           Navigator.pop(context);
                  //                         } else {
                  //                           ScaffoldMessenger.of(context)
                  //                               .showSnackBar(
                  //                             SnackBar(
                  //                               content: Text("Server Error02"),
                  //                               margin: EdgeInsets.all(30),
                  //                               behavior:
                  //                                   SnackBarBehavior.floating,
                  //                               shape: RoundedRectangleBorder(
                  //                                 borderRadius:
                  //                                     BorderRadius.circular(50),
                  //                               ),
                  //                             ),
                  //                           );
                  //                         }
                  //                       },
                  //                       child: Text("Yes"))
                  //                 ],
                  //               );
                  //             },
                  //           ).then((value) {
                  //             setState(() {
                  //               disposisism.clear();
                  //               getDispo(isRefreshed: true);
                  //             });
                  //           });
                  //         },
                  //         icon: Icon(Icons.check_circle_outline_rounded),
                  //         label: Text("Selesai"),
                  //         style: ElevatedButton.styleFrom(primary: color1),
                  //       ))
                  // Center(
                  //     child: ElevatedButton.icon(
                  //     onPressed: () {
                  //       // print("Disposisi pressed");
                  //     },
                  //     icon: Icon(Icons.check_circle_outline_rounded),
                  //     label: Text("Selesai"),
                  //     style: ElevatedButton.styleFrom(primary: Colors.grey),
                  //   )),
            ],
          ),
          Divider(),
          Text("Riwayat Disposisi Surat"),
          Divider(),
          Expanded(
            child: SmartRefresher(
              controller: _refreshController,
              enablePullUp: true,
              onRefresh: () async {
                disposisism.clear();
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
                    // print(disposisism[index]);
                    // return ListTile(
                    //   leading: Text("${disposisism[index].nmstatus}"),
                    //   title: Text("${disposisism[index].catatan}"),
                    //   subtitle: Text("Dari ${disposisism[index].pengirim}"),
                    //   trailing: Text(
                    //       "Kepada ${disposisism[index].penerima}\n${DateFormat('yyyy-MM-dd  kk:mm').format(disposisism[index].tglProses)}"),
                    // );
                    return Card(
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
                          begin: Alignment.topCenter,
                          end: Alignment.bottomRight,
                          stops: [0.1, 1],
                        )),
                        padding: EdgeInsets.all(12),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  disposisism[index].state,
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 16),
                                ),
                                Spacer(),
                                Text(
                                  DateFormat('kk:mm / yyyy-MM-dd')
                                      .format(disposisism[index].tglProses),
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 16),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Text(
                              "Dari",
                              style:
                                  TextStyle(color: Colors.white, fontSize: 12),
                            ),
                            Text(
                              slog[index].name,
                              style:
                                  TextStyle(color: Colors.white, fontSize: 16),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Text(
                              "Catatan",
                              style:
                                  TextStyle(color: Colors.white, fontSize: 12),
                            ),
                            Text(
                              disposisism[index].catatan,
                              style:
                                  TextStyle(color: Colors.white, fontSize: 16),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Text(
                              "Kepada",
                              style:
                                  TextStyle(color: Colors.white, fontSize: 12),
                            ),
                            Text(
                              rlog[index].name,
                              style:
                                  TextStyle(color: Colors.white, fontSize: 16),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                  separatorBuilder: (context, index) => Divider(),
                  itemCount: disposisism.length),
            ),
          )
          //
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
        Uri.parse("https://simponik.kedirikota.go.id/api/readinbox"),
        // "https://sigap.kedirikota.go.id/apiesuratpkl/public/surat_masuk/baca"),
        body: ({
          "sm_id": widget.sm.id,
          "user_id": id_user,
        }));
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      print("data :");
      print(data);
      //   setState(() {
      //     // isbaca = data['myValue'];
      // });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Server Error03"),
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
                "https://simponik.kedirikota.go.id/api/inboxdetail?id=${widget.sm.id}"),
            headers: requestHeaders);

        if (response.statusCode == 200) {
          final bd = jsonDecode(response.body);
          List data = bd['detailsurat'];
          print("data :");
          print(data);

          data.forEach((element) {
            disposisism.add(Disposisism.fromJson(element));
            var object = Php.unserialize(element['s_user_log']);
            slog.add(SUserLog.fromJson(object));
            var ob = element['r_user_log'];
            if (ob == "" || ob == null) {
              // ob = "a:1:{s:4:\"name\";s:4:\"null\";}";
              ob =
                  "a:33:{s:2:\"id\";s:4:\"4824\";s:3:\"nip\";s:4:\"0000\";s:3:\"nik\";s:4:\"0000\";s:4:\"name\";s:1:\"-\";s:8:\"username\";s:6:\"kadin1\";s:8:\"password\";s:64:\"8c6976e5b5410415bde908bd4dee15dfb167a9c873fc4bb8a81f6f2ab448a918\";s:12:\"tempat_lahir\";N;s:13:\"tanggal_lahir\";N;s:2:\"jk\";N;s:6:\"alamat\";N;s:5:\"no_hp\";s:12:\"081249991377\";s:5:\"email\";N;s:4:\"foto\";N;s:15:\"kedudukan_hukum\";s:5:\"Aktif\";s:17:\"jenis_kepegawaian\";N;s:9:\"gol_ruang\";N;s:11:\"gol_pangkat\";N;s:13:\"jenis_jabatan\";s:18:\"Jabatan Struktural\";s:12:\"nama_jabatan\";s:12:\"KEPALA DINAS\";s:6:\"eselon\";s:4:\"II.a\";s:11:\"nama_eselon\";s:23:\"PIMPINAN TINGGI PRATAMA\";s:11:\"plt_jabatan\";N;s:9:\"plt_jenis\";N;s:8:\"plt_skpd\";N;s:11:\"plt_skpd_id\";N;s:7:\"skpd_id\";s:3:\"998\";s:10:\"created_at\";s:19:\"2023-02-01 22:29:20\";s:10:\"updated_at\";s:19:\"2023-02-13 10:02:53\";s:7:\"nm_skpd\";s:14:\"OPD UJI COBA 1\";s:6:\"bidang\";N;s:10:\"unit_kerja\";s:14:\"OPD UJI COBA 1\";s:5:\"roles\";s:1:\"9\";s:10:\"roles_name\";s:10:\"Kepala OPD\";}";
              print("ob :");
              print(ob);
            }
            var object2 = Php.unserialize(ob);
            rlog.add(RUserLog.fromJson(object2));
            print("object2 :");
            print(object2);
          });

          // data.forEach((element) {
          //   disposisism.add(Disposisism.fromJson(element));
          // });
          List data2 = bd['files'];
          data2.forEach((element) {
            files = element['full_path_file'];
          });

          currentPage++;
          totalPages = data.length;
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

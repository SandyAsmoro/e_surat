import 'dart:convert';

import 'package:e_surat/models/suratmasuk.dart';
import 'package:e_surat/models/userdisposm.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:multi_select_flutter/multi_select_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

const color1 = Color(0xFF533E85);
const color2 = Color(0xFF488FB1);
const color3 = Color(0xFF4FD3C4);
const color4 = Color(0xFFC1F8CF);

class Disposm extends StatefulWidget {
  final SuratMasuk dispo;
  const Disposm({Key? key, required this.dispo}) : super(key: key);

  @override
  State<Disposm> createState() => _DisposmState();
}

class _DisposmState extends State<Disposm> {
  String token = "";
  String id = "";
  List<Userdisposm> bawahan = [];
  List<Userdisposm?> seletedBawahan = [];
  var catatanController = TextEditingController();

  Future getBawahan() async {
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
        var response = await http.get(
            Uri.parse(
                "https://simponik.kedirikota.go.id/api/inbox?id=$id&param=all"),
                // "https://sigap.kedirikota.go.id/apiesuratpkl/public/userdisposm"),
            headers: requestHeaders);
        if (response.statusCode == 200) {
          List data =
          (jsonDecode(response.body) as Map<String, dynamic>)["data"];
          data.forEach((element) {
            bawahan.add(Userdisposm.fromJson(element));
          });

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

  @override
  void initState() {
    super.initState();
    getBawahan();
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
        title: Text("Disposisi Surat Masuk"),
        backgroundColor: color1,
      ),
      body: Column(
        children: [
          Text("Perihal ${widget.dispo.perihal}"),
          SizedBox(
            height: 15,
          ),
          Center(
            child: SizedBox(
              width: double.infinity,
              height: 130.0,
              child: SingleChildScrollView(
                child: MultiSelectDialogField<Userdisposm?>(
                  title: Text("Bawahan"),
                  buttonText: Text("Disposisi ke"),
                  buttonIcon: Icon(Icons.expand_more),
                  searchable: true,
                  items: bawahan
                      .map((e) => MultiSelectItem<Userdisposm?>(e, e.nama))
                      .toList(),
                  listType: MultiSelectListType.LIST,
                  onConfirm: (values) {
                    seletedBawahan = values;
                  },
                  // height: 400.0,
                ),
              ),
            ),
          ),
          SizedBox(
            height: 15,
          ),
          TextFormField(
            controller: catatanController,
            decoration: InputDecoration(
                labelText: "Isi Disposisi",
                border: OutlineInputBorder(),
                suffixIcon: Icon(Icons.textsms_outlined)),
          ),
          SizedBox(
            height: 15,
          ),
          Center(
              child: ElevatedButton.icon(
                onPressed: () async {
                  if (catatanController.text.isNotEmpty) {
                    var response = await http.post(
                        Uri.parse(
                            "https://simponik.kedirikota.go.id/api/inbox?id=$id&param=all"),
                            // "https://sigap.kedirikota.go.id/apiesuratpkl/public/surat_masuk/disposisi"),
                        body: ({
                          "catatan": catatanController.text,
                          "penerima": jsonEncode(seletedBawahan),
                          "token": token,
                          "no_surat": widget.dispo.noSurat
                        }));
                    // print(response.body);
                    if (response.statusCode == 200) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text("Disposisi Berhasil"),
                          margin: EdgeInsets.all(30),
                          behavior: SnackBarBehavior.floating,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(50),
                          ),
                        ),
                      );
                      Navigator.pop(context);
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
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text("Isi disposisi tidak boleh kosong!!"),
                        margin: EdgeInsets.all(30),
                        behavior: SnackBarBehavior.floating,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(50),
                        ),
                      ),
                    );
                  }
                },
                icon: Icon(Icons.send_to_mobile_outlined),
                label: Text("Disposisi"),
                style: ElevatedButton.styleFrom(primary: Colors.deepPurple),
              ))
        ],
      ),
    );
  }
}

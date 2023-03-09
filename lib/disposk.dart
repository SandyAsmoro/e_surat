import 'dart:convert';

import 'package:e_surat/models/suratkeluar.dart';
import 'package:e_surat/models/userdisposm.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:multi_select_flutter/multi_select_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Disposk extends StatefulWidget {
  final SuratKeluar dispo;
  const Disposk({Key? key, required this.dispo}) : super(key: key);

  @override
  State<Disposk> createState() => _DisposkState();
}

class _DisposkState extends State<Disposk> {
  String token = "";
  List<Userdisposm> bawahan = [];
  List<Userdisposm?> seletedBawahan = [];
  var catatanController = TextEditingController();

  Future getBawahan() async {
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
                "https://sigap.kedirikota.go.id/apiesuratpkl/public/userdisposk"),
            headers: requestHeaders);
        print(response.body);
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
        title: Text("Disposisi Surat Keluar"),
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
                            "https://sigap.kedirikota.go.id/apiesuratpkl/public/surat_keluar/disposisi"),
                        body: ({
                          "catatan": catatanController.text,
                          "penerima": jsonEncode(seletedBawahan),
                          "token": token,
                          "id_srt": widget.dispo.idSrt
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
                  // Navigator.of(context).push(MaterialPageRoute(
                  //     builder: (context) => Disposm(
                  //           dispo: widget.sm,
                  //         )));
                },
                icon: Icon(Icons.send_to_mobile_outlined),
                label: Text("Disposisi"),
              ))
          // Text("data : ${bawahan[1].nama}")
        ],
      ),
    );
  }
}

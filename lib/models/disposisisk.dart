// To parse this JSON data, do
//
//     final userdisposk = userdisposkFromJson(jsonString);

import 'dart:convert';

Disposisisk userdisposkFromJson(String str) =>
    Disposisisk.fromJson(json.decode(str));

String userdisposkToJson(Disposisisk data) => json.encode(data.toJson());

class Disposisisk {
  Disposisisk({
    required this.pengirim,
    required this.jabatanPengirim,
    required this.penerima,
    required this.jabatanPenerima,
    required this.catatan,
    required this.nmstatus,
    required this.tglProses,
  });

  String pengirim;
  String jabatanPengirim;
  String penerima;
  String jabatanPenerima;
  String catatan;
  String nmstatus;
  DateTime tglProses;

  factory Disposisisk.fromJson(Map<String, dynamic> json) => Disposisisk(
    pengirim: json["pengirim"],
    jabatanPengirim: json["jabatan_pengirim"],
    penerima: json["penerima"],
    jabatanPenerima: json["jabatan_penerima"],
    catatan: json["catatan"],
    nmstatus: json["nmstatus"],
    tglProses: DateTime.parse(json["tgl_proses"]),
  );

  Map<String, dynamic> toJson() => {
    "pengirim": pengirim,
    "jabatan_pengirim": jabatanPengirim,
    "penerima": penerima,
    "jabatan_penerima": jabatanPenerima,
    "catatan": catatan,
    "nmstatus": nmstatus,
    "tgl_proses": tglProses.toIso8601String(),
  };
}

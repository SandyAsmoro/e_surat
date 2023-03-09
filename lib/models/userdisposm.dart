// To parse this JSON data, do
//
//     final userdisposm = userdisposmFromJson(jsonString);

import 'dart:convert';

Userdisposm userdisposmFromJson(String str) =>
    Userdisposm.fromJson(json.decode(str));

String userdisposmToJson(Userdisposm data) => json.encode(data.toJson());

class Userdisposm {
  Userdisposm({
    required this.idUser,
    required this.nama,
    required this.jabatan,
    required this.esel,
    required this.idSatker,
    required this.idJabatan,
  });

  String idUser;
  String nama;
  String jabatan;
  String esel;
  String idSatker;
  String idJabatan;

  factory Userdisposm.fromJson(Map<String, dynamic> json) => Userdisposm(
    idUser: json["id_user"],
    nama: json["nama"],
    jabatan: json["jabatan"],
    esel: json["esel"],
    idSatker: json["id_satker"],
    idJabatan: json["id_jabatan"],
  );

  Map<String, dynamic> toJson() => {
    "id_user": idUser,
    "nama": nama,
    "jabatan": jabatan,
    "esel": esel,
    "id_satker": idSatker,
    "id_jabatan": idJabatan,
  };
}

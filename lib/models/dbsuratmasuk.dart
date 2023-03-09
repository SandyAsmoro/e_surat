// To parse this JSON data, do
//
//     final dbsuratmasuk = dbsuratmasukFromJson(jsonString);

import 'dart:convert';

Dbsuratmasuk dbsuratmasukFromJson(String str) =>
    Dbsuratmasuk.fromJson(json.decode(str));

String dbsuratmasukToJson(Dbsuratmasuk data) => json.encode(data.toJson());

class Dbsuratmasuk {
  Dbsuratmasuk({
    required this.totalSurat,
    required this.totalUnread,
    required this.totalUnkonf,
    required this.totalSelesai,
  });

  int totalSurat;
  int totalUnread;
  int totalUnkonf;
  int totalSelesai;

  factory Dbsuratmasuk.fromJson(Map<String, dynamic> json) => Dbsuratmasuk(
    totalSurat: json["totalSurat"],
    totalUnread: json["totalUnread"],
    totalUnkonf: json["totalUnkonf"],
    totalSelesai: json["totalSelesai"],
  );

  Map<String, dynamic> toJson() => {
    "totalSurat": totalSurat,
    "totalUnread": totalUnread,
    "totalUnkonf": totalUnkonf,
    "totalSelesai": totalSelesai,
  };
}

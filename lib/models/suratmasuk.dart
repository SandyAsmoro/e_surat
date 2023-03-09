// To parse this JSON data, do
//
//     final suratMasuk = suratMasukFromJson(jsonString);

import 'dart:convert';

SuratMasuk suratMasukFromJson(String str) =>
    SuratMasuk.fromJson(json.decode(str));

String suratMasukToJson(SuratMasuk data) => json.encode(data.toJson());

class SuratMasuk {
  SuratMasuk({
    required this.rank,
    required this.idSrt,
    required this.idSmwf,
    required this.noSurat,
    required this.tglSurat,
    required this.perihal,
    required this.noAgenda,
    required this.dari,
    required this.ttd,
    required this.idKat,
    required this.kategori,
    required this.idSifat,
    required this.sifat,
    required this.state,
    required this.tglTerima,
    required this.start,
    required this.baca,
    required this.konf,
    required this.idstatus,
    required this.nmstatus,
    required this.pengirim,
    required this.jabatanPengirim,
    required this.tglProses,
    required this.catatan,
    required this.tahun,
    required this.fileSurat,
  });

  String rank;
  String idSrt;
  String idSmwf;
  String noSurat;
  String tglSurat;
  String perihal;
  String noAgenda;
  String dari;
  String ttd;
  String idKat;
  String kategori;
  String idSifat;
  String sifat;
  String state;
  DateTime tglTerima;
  DateTime start;
  String baca;
  String konf;
  String idstatus;
  String nmstatus;
  String pengirim;
  String jabatanPengirim;
  DateTime tglProses;
  String catatan;
  String tahun;
  String fileSurat;

  factory SuratMasuk.fromJson(Map<String, dynamic> json) => SuratMasuk(
    rank: json["rank"],
    idSrt: json["id_srt"],
    idSmwf: json["id_smwf"],
    noSurat: json["no_surat"],
    tglSurat: json["tgl_surat"],
    perihal: json["perihal"],
    noAgenda: json["no_agenda"],
    dari: json["dari"],
    ttd: json["ttd"],
    idKat: json["id_kat"],
    kategori: json["kategori"],
    idSifat: json["id_sifat"],
    sifat: json["sifat"],
    state: json["state"],
    tglTerima: DateTime.parse(json["tgl_terima"]),
    start: DateTime.parse(json["_start"]),
    baca: json["baca"],
    konf: json["konf"],
    idstatus: json["idstatus"],
    nmstatus: json["nmstatus"],
    pengirim: json["pengirim"],
    jabatanPengirim: json["jabatan_pengirim"],
    tglProses: DateTime.parse(json["tgl_proses"]),
    catatan: json["catatan"],
    tahun: json["tahun"],
    fileSurat: json["file_surat"],
  );

  Map<String, dynamic> toJson() => {
    "rank": rank,
    "id_srt": idSrt,
    "id_smwf": idSmwf,
    "no_surat": noSurat,
    "tgl_surat": tglSurat,
    // "${tglSurat.year.toString().padLeft(4, '0')}-${tglSurat.month.toString().padLeft(2, '0')}-${tglSurat.day.toString().padLeft(2, '0')}",
    "perihal": perihal,
    "no_agenda": noAgenda,
    "dari": dari,
    "ttd": ttd,
    "id_kat": idKat,
    "kategori": kategori,
    "id_sifat": idSifat,
    "sifat": sifat,
    "state": state,
    "tgl_terima":
    "${tglTerima.year.toString().padLeft(4, '0')}-${tglTerima.month.toString().padLeft(2, '0')}-${tglTerima.day.toString().padLeft(2, '0')}",
    "_start": start.toIso8601String(),
    "baca": baca,
    "konf": konf,
    "idstatus": idstatus,
    "nmstatus": nmstatus,
    "pengirim": pengirim,
    "jabatan_pengirim": jabatanPengirim,
    "tgl_proses": tglProses.toIso8601String(),
    "catatan": catatan,
    "tahun": tahun,
    "file_surat": fileSurat,
  };
}

// To parse this JSON data, do
//
//     final suratMasuk = suratMasukFromJson(jsonString);

import 'dart:convert';

SuratMasuk suratMasukFromJson(String str) =>
    SuratMasuk.fromJson(json.decode(str));

String suratMasukToJson(SuratMasuk data) => json.encode(data.toJson());

class SuratMasuk {
  String id;
  String? tahun;
  String? skpdId;
  String tglSurat;
  String? noSurat;
  String perihal;
  String state;
  String? kategori;
  String? sifat;
  String? dari;
  String? sUserName;
  String? rUserName;
  String? rUserId;
  String? rState;
  String? catatan;
  String? isbaca;
  String? tglBaca;
  String? createdAt;
  String? terima;
  String? kirim;
  String? namaSkpd;

  SuratMasuk(
      {required this.id,
      this.tahun,
      this.skpdId,
      required this.tglSurat,
      this.noSurat,
      required this.perihal,
      required this.state,
      this.kategori,
      this.sifat,
      this.dari,
      this.sUserName,
      this.rUserName,
      this.rUserId,
      this.rState,
      this.catatan,
      required this.isbaca,
      this.tglBaca,
      this.createdAt,
      this.terima,
      this.kirim,
      this.namaSkpd});

  factory SuratMasuk.fromJson(Map<String, dynamic> json) {
    return SuratMasuk(
      id: json["id"],
      tahun: json["tahun"],
      skpdId: json["skpd_id"],
      tglSurat: json["tgl_surat"],
      noSurat: json["no_surat"],
      perihal: json["perihal"],
      state: json["state"],
      kategori: json["kategori"],
      sifat: json["sifat"],
      dari: json["dari"],
      sUserName: json["s_user_name"],
      rUserName: json["r_user_name"],
      rUserId: json["r_user_id"],
      rState: json["r_state"],
      catatan: json["catatan"],
      isbaca: json["isbaca"],
      tglBaca: json["tgl_baca"],
      createdAt: json["created_at"],
      terima: json["terima"],
      kirim: json["kirim"],
      namaSkpd: json["nama_skpd"],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['tahun'] = this.tahun;
    data['skpd_id'] = this.skpdId;
    data['tgl_surat'] = this.tglSurat;
    data['no_surat'] = this.noSurat;
    data['perihal'] = this.perihal;
    data['state'] = this.state;
    data['kategori'] = this.kategori;
    data['sifat'] = this.sifat;
    data['dari'] = this.dari;
    data['s_user_name'] = this.sUserName;
    data['r_user_name'] = this.rUserName;
    data['r_user_id'] = this.rUserId;
    data['r_state'] = this.rState;
    data['catatan'] = this.catatan;
    data['isbaca'] = this.isbaca;
    data['tgl_baca'] = this.tglBaca;
    data['created_at'] = this.createdAt;
    data['terima'] = this.terima;
    data['kirim'] = this.kirim;
    data['nama_skpd'] = this.namaSkpd;
    return data;
  }
}

// id
// tahun
// skpdId
// tglSurat
// noSurat
// perihal
// state
// kategori
// sifat
// dari
// sUserName
// rUserName
// rUserId
// rState
// catatan
// isbaca
// tglBaca
// createdAt
// terima
// kirim
// namaSkpd
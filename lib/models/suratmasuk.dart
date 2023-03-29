// To parse this JSON data, do
//
//     final suratMasuk = suratMasukFromJson(jsonString);

import 'dart:convert';

SuratMasuk suratMasukFromJson(String str) =>
    SuratMasuk.fromJson(json.decode(str));

String suratMasukToJson(SuratMasuk data) => json.encode(data.toJson());

class SuratMasuk {
  final String id;
  final String? tahun;
  final String? skpdId;
  final String? tglSurat;
  final String? noSurat;
  final String? perihal;
  final String state;
  final String? kategori;
  final String? sifat;
  final String? dari;
  final String? sUserName;
  final String? rUserName;
  final String? rUserId;
  final String rState;
  final String? catatan;
  final String isbaca;
  final String tglBaca;
  final String createdAt;
  final String? terima;
  final String? kirim;
  final String? namaSkpd;

  SuratMasuk(
      {required this.id,
      this.tahun,
      this.skpdId,
      this.tglSurat,
      this.noSurat,
      this.perihal,
      required this.state,
      this.kategori,
      this.sifat,
      this.dari,
      this.sUserName,
      this.rUserName,
      this.rUserId,
      required this.rState,
      this.catatan,
      required this.isbaca,
      required this.tglBaca,
      required this.createdAt,
      this.terima,
      this.kirim,
      this.namaSkpd});

  factory SuratMasuk.fromJson(Map<String, dynamic> json) {
    return SuratMasuk(
      id: json['id'],
      tahun: json['tahun']?.join('') ?? "NA",
      skpdId: json['skpd_id']?.join('') ?? "NA",
      tglSurat: json['tgl_surat']?.join('') ?? "NA",
      noSurat: json['no_surat']?.join('') ?? "NA",
      perihal: json['perihal']?.join('') ?? "NA",
      state: json['state'],
      kategori: json['kategori']?.join('') ?? "NA",
      sifat: json['sifat']?.join('') ?? "NA",
      dari: json['dari']?.join('') ?? "NA",
      sUserName: json['s_user_name']?.join('') ?? "NA",
      rUserName: json['r_user_name']?.join('') ?? "NA",
      rUserId: json['r_user_id']?.join('') ?? "NA",
      rState: json['r_state'],
      catatan: json['catatan']?.join('') ?? "NA",
      isbaca: json['isbaca'],
      tglBaca: json['tgl_baca'],
      createdAt: json['created_at'],
      terima: json['terima']?.join('') ?? "NA",
      kirim: json['kirim']?.join('') ?? "NA",
      namaSkpd: json['nama_skpd']?.join('') ?? "NA",
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

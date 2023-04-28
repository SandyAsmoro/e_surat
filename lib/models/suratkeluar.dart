// To parse this JSON data, do
//
//     final suratKeluar = suratKeluarFromJson(jsonString);

import 'dart:convert';

SuratKeluar suratKeluarFromJson(String str) =>
    SuratKeluar.fromJson(json.decode(str));

String suratKeluarToJson(SuratKeluar data) => json.encode(data.toJson());

class SuratKeluar {
  String id;
  String? tahun;
  String? skpdId;
  String tglSurat;
  String? noSurat;
  String? perihal;
  String state;
  String? kategori;
  String? sifat;
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

  SuratKeluar({
    required this.id,
    this.tahun,
    this.skpdId,
    required this.tglSurat,
    this.noSurat,
    this.perihal,
    required this.state,
    this.kategori,
    this.sifat,
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
    this.namaSkpd,
  });

  factory SuratKeluar.fromJson(Map<String, dynamic> json) {
    return SuratKeluar(
      id: json['id'],
      tahun: json['tahun'],
      skpdId: json['skpd_id'],
      tglSurat: json['tgl_surat'],
      noSurat: json['no_surat'],
      perihal: json['perihal'],
      state: json['state'],
      kategori: json['kategori'],
      sifat: json['sifat'],
      sUserName: json['s_user_name'],
      rUserName: json['r_user_name'],
      rUserId: json['r_user_id'],
      rState: json['r_state'],
      catatan: json['catatan'],
      isbaca: json['isbaca'],
      tglBaca: json['tgl_baca'],
      createdAt: json['created_at'],
      terima: json['terima'],
      kirim: json['kirim'],
      namaSkpd: json['nama_skpd'],
    );
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['tahun'] = tahun;
    _data['skpd_id'] = skpdId;
    _data['tgl_surat'] = tglSurat;
    _data['no_surat'] = noSurat;
    _data['perihal'] = perihal;
    _data['state'] = state;
    _data['kategori'] = kategori;
    _data['sifat'] = sifat;
    _data['s_user_name'] = sUserName;
    _data['r_user_name'] = rUserName;
    _data['r_user_id'] = rUserId;
    _data['r_state'] = rState;
    _data['catatan'] = catatan;
    _data['isbaca'] = isbaca;
    _data['tgl_baca'] = tglBaca;
    _data['created_at'] = createdAt;
    _data['terima'] = terima;
    _data['kirim'] = kirim;
    _data['nama_skpd'] = namaSkpd;
    return _data;
  }
}




// class SuratKeluar {
//   SuratKeluar({
//     required this.rank,
//     required this.idSrt,
//     required this.idSkwf,
//     required this.noSurat,
//     required this.tglSurat,
//     required this.perihal,
//     required this.noAgenda,
//     required this.kepada,
//     required this.ttd,
//     required this.idKat,
//     required this.kategori,
//     required this.idSifat,
//     required this.sifat,
//     required this.state,
//     required this.start,
//     required this.baca,
//     required this.konf,
//     required this.idstatus,
//     required this.nmstatus,
//     required this.pengirim,
//     required this.jabatanPengirim,
//     required this.tglProses,
//     required this.catatan,
//     required this.tahun,
//   });

//   String rank;
//   String idSrt;
//   String idSkwf;
//   String noSurat;
//   String tglSurat;
//   String perihal;
//   String noAgenda;
//   String kepada;
//   String ttd;
//   String idKat;
//   String kategori;
//   String idSifat;
//   String sifat;
//   String state;
//   DateTime start;
//   String baca;
//   String konf;
//   String idstatus;
//   String nmstatus;
//   String pengirim;
//   String jabatanPengirim;
//   DateTime tglProses;
//   String catatan;
//   String tahun;

//   factory SuratKeluar.fromJson(Map<String, dynamic> json) => SuratKeluar(
//     rank: json["rank"],
//     idSrt: json["id_srt"],
//     idSkwf: json["id_skwf"],
//     noSurat: json["no_surat"],
//     tglSurat: json["tgl_surat"],
//     perihal: json["perihal"],
//     noAgenda: json["no_agenda"],
//     kepada: json["kepada"],
//     ttd: json["ttd"],
//     idKat: json["id_kat"],
//     kategori: json["kategori"],
//     idSifat: json["id_sifat"],
//     sifat: json["sifat"],
//     state: json["state"],
//     start: DateTime.parse(json["_start"]),
//     baca: json["baca"],
//     konf: json["konf"],
//     idstatus: json["idstatus"],
//     nmstatus: json["nmstatus"],
//     pengirim: json["pengirim"],
//     jabatanPengirim: json["jabatan_pengirim"],
//     tglProses: DateTime.parse(json["tgl_proses"]),
//     catatan: json["catatan"],
//     tahun: json["tahun"],
//   );

//   Map<String, dynamic> toJson() => {
//     "rank": rank,
//     "id_srt": idSrt,
//     "id_skwf": idSkwf,
//     "no_surat": noSurat,
//     "tgl_surat": tglSurat,
//     "perihal": perihal,
//     "no_agenda": noAgenda,
//     "kepada": kepada,
//     "ttd": ttd,
//     "id_kat": idKat,
//     "kategori": kategori,
//     "id_sifat": idSifat,
//     "sifat": sifat,
//     "state": state,
//     "_start": start.toIso8601String(),
//     "baca": baca,
//     "konf": konf,
//     "idstatus": idstatus,
//     "nmstatus": nmstatus,
//     "pengirim": pengirim,
//     "jabatan_pengirim": jabatanPengirim,
//     "tgl_proses": tglProses.toIso8601String(),
//     "catatan": catatan,
//     "tahun": tahun,
//   };
// }

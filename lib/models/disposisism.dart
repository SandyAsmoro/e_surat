// To parse this JSON data, do
//
//     final disposisism = disposisismFromJson(jsonString);

import 'dart:convert';

Disposisism disposisismFromJson(String str) =>
    Disposisism.fromJson(json.decode(str));

String disposisismToJson(Disposisism data) => json.encode(data.toJson());

class Disposisism {
  Disposisism({
    this.id,
    this.tahun,
    this.skpdId,
    this.noAgenda,
    this.noSurat,
    this.tglSurat,
    this.perihal,
    this.ttd,
    required this.dari,
    this.kategori,
    this.sifat,
    required this.penerima,
    this.tglTerima,
    this.tglDeadline,
    required this.state,
    required this.tglDoing,
    this.tglArsip,
    required this.keterangan,
    this.ketAgenda,
    this.ketNotulen,
    this.userId,
    this.logUser,
    this.logUserKirim,
    this.skId,
    this.createdAt,
    this.updatedAt,
  });
  String? id;
  String? tahun;
  String? skpdId;
  String? noAgenda;
  String? noSurat;
  String? tglSurat;
  String? perihal;
  String? ttd;
  late String dari;
  String? kategori;
  String? sifat;
  late String penerima;
  String? tglTerima;
  String? tglDeadline;
  late String state;
  late DateTime tglDoing;
  String? tglArsip;
  late String keterangan;
  String? ketAgenda;
  String? ketNotulen;
  String? userId;
  String? logUser;
  String? logUserKirim;
  String? skId;
  String? createdAt;
  String? updatedAt;
  
  Disposisism.fromJson(Map<String, dynamic> json){
    id = json['id'];
    tahun = json['tahun'];
    skpdId = json['skpd_id'];
    noAgenda = json['no_agenda'];
    noSurat = json['no_surat'];
    tglSurat = json['tgl_surat'];
    perihal = json['perihal'];
    ttd = json['ttd'];
    dari = json['dari'];
    kategori = json['kategori'];
    sifat = json['sifat'];
    penerima = json['penerima']?.join(',');
    tglTerima = json['tgl_terima'];
    tglDeadline = null;
    state = json['state'];
    tglDoing = json['tgl_doing'];
    tglArsip = null;
    keterangan = json['keterangan'];
    ketAgenda = null;
    ketNotulen = null;
    userId = json['user_id'];
    logUser = json['log_user'];
    logUserKirim = json['log_user_kirim'];
    skId = json['sk_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['tahun'] = tahun;
    _data['skpd_id'] = skpdId;
    _data['no_agenda'] = noAgenda;
    _data['no_surat'] = noSurat;
    _data['tgl_surat'] = tglSurat;
    _data['perihal'] = perihal;
    _data['ttd'] = ttd;
    _data['dari'] = dari;
    _data['kategori'] = kategori;
    _data['sifat'] = sifat;
    _data['penerima'] = penerima;
    _data['tgl_terima'] = tglTerima;
    _data['tgl_deadline'] = tglDeadline;
    _data['state'] = state;
    _data['tgl_doing'] = tglDoing;
    _data['tgl_arsip'] = tglArsip;
    _data['keterangan'] = keterangan;
    _data['ket_agenda'] = ketAgenda;
    _data['ket_notulen'] = ketNotulen;
    _data['user_id'] = userId;
    _data['log_user'] = logUser;
    _data['log_user_kirim'] = logUserKirim;
    _data['sk_id'] = skId;
    _data['created_at'] = createdAt;
    _data['updated_at'] = updatedAt;
    return _data;
  }
}

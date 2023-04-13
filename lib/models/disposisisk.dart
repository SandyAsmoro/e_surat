// To parse this JSON data, do
//
//     final userdisposk = userdisposkFromJson(jsonString);

import 'dart:convert';

Disposisisk userdisposkFromJson(String str) =>
    Disposisisk.fromJson(json.decode(str));

String userdisposkToJson(Disposisisk data) => json.encode(data.toJson());

class Disposisisk {
  Disposisisk({
    required this.id,
    required this.skId,
    required this.sUser,
    required this.sSkpd,
    required this.sUserLog,
    this.rUser,
    this.rSkpd,
    this.rUserLog,
    required this.state,
    required this.tglProses,
    required this.isbaca,
    this.tglBaca,
    required this.catatan,
    required this.createdAt,
    required this.updatedAt,
  });
  late final String id;
  late final String skId;
  late final String sUser;
  late final String sSkpd;
  late final String sUserLog;
  late final String? rUser;
  late final String? rSkpd;
  late final String? rUserLog;
  late final String state;
  late final String tglProses;
  late final String isbaca;
  late final String? tglBaca;
  late final String catatan;
  late final String createdAt;
  late final String updatedAt;
  
  Disposisisk.fromJson(Map<String, dynamic> json){
    id = json['id'];
    skId = json['sk_id'];
    sUser = json['s_user'];
    sSkpd = json['s_skpd'];
    sUserLog = json['s_user_log'];
    rUser = null;
    rSkpd = null;
    rUserLog = null;
    state = json['state'];
    tglProses = json['tgl_proses'];
    isbaca = json['isbaca'];
    tglBaca = null;
    catatan = json['catatan'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['sk_id'] = skId;
    _data['s_user'] = sUser;
    _data['s_skpd'] = sSkpd;
    _data['s_user_log'] = sUserLog;
    _data['r_user'] = rUser;
    _data['r_skpd'] = rSkpd;
    _data['r_user_log'] = rUserLog;
    _data['state'] = state;
    _data['tgl_proses'] = tglProses;
    _data['isbaca'] = isbaca;
    _data['tgl_baca'] = tglBaca;
    _data['catatan'] = catatan;
    _data['created_at'] = createdAt;
    _data['updated_at'] = updatedAt;
    return _data;
  }
}
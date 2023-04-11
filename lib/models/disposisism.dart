// To parse this JSON data, do
//
//     final disposisism = disposisismFromJson(jsonString);

import 'dart:convert';

Disposisism disposisismFromJson(String str) =>
    Disposisism.fromJson(json.decode(str));

String disposisismToJson(Disposisism data) => json.encode(data.toJson());

class Disposisism {
  Disposisism({
    required this.id,
    required this.smId,
    required this.sUser,
    this.sSkpd,
    this.sUserLog,
    required this.rUser,
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
  late final String smId;
  late final String sUser;
  late final String? sSkpd;
  late final String? sUserLog;
  late final String rUser;
  late final String? rSkpd;
  late final String? rUserLog;
  late final String state;
  late final DateTime tglProses;
  late final String isbaca;
  late final String? tglBaca;
  late final String catatan;
  late final String createdAt;
  late final String updatedAt;

  Disposisism.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    smId = json['sm_id'];
    sUser = json['s_user'];
    sSkpd = json['s_skpd'];
    sUserLog = json['s_user_log'];
    rUser = json['r_user']?? 'null';
    rSkpd = json['r_skpd'];
    rUserLog = json['r_user_log'];
    state = json['state'];
    tglProses = DateTime.parse(json["tgl_proses"]);
    isbaca = json['isbaca'];
    tglBaca = json['tgl_baca'];
    catatan = json['catatan'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['sm_id'] = smId;
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

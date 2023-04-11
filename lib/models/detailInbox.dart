class AutoGenerate {
  AutoGenerate({
    required this.id,
    required this.tahun,
    required this.skpdId,
    required this.noAgenda,
    required this.noSurat,
    required this.tglSurat,
    required this.perihal,
    required this.ttd,
    required this.dari,
    required this.kategori,
    required this.sifat,
    required this.penerima,
    required this.tglTerima,
    this.tglDeadline,
    required this.state,
    required this.tglDoing,
    this.tglArsip,
    required this.keterangan,
    this.ketAgenda,
    this.ketNotulen,
    required this.userId,
    required this.logUser,
    required this.logUserKirim,
    required this.skId,
    required this.createdAt,
    required this.updatedAt,
  });
  late final String id;
  late final String tahun;
  late final String skpdId;
  late final String noAgenda;
  late final String noSurat;
  late final String tglSurat;
  late final String perihal;
  late final String ttd;
  late final String dari;
  late final String kategori;
  late final String sifat;
  late final String penerima;
  late final String tglTerima;
  late final String? tglDeadline;
  late final String state;
  late final String tglDoing;
  late final String? tglArsip;
  late final String keterangan;
  late final String? ketAgenda;
  late final String? ketNotulen;
  late final String userId;
  late final String logUser;
  late final String logUserKirim;
  late final String skId;
  late final String createdAt;
  late final String updatedAt;
  
  AutoGenerate.fromJson(Map<String, dynamic> json){
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
    penerima = json['penerima'];
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
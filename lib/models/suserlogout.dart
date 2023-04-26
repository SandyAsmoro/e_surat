import 'dart:convert';

SUserLogOut disposisismFromJson(String str) =>
    SUserLogOut.fromJson(json.decode(str));

String disposisismToJson(SUserLogOut _data) => json.encode(_data.toJson());

class SUserLogOut {
  SUserLogOut({
    this.jabatanSkpd,
    this.jabatanSkpdPlt,
    this.id,
    this.nip,
    this.nik,
    required this.name,
    this.username,
    this.password,
    this.tempatLahir,
    this.tanggalLahir,
    this.jk,
    this.alamat,
    this.noHp,
    this.email,
    this.foto,
    this.kedudukanHukum,
    this.jenisKepegawaian,
    this.golRuang,
    this.golPangkat,
    this.jenisJabatan,
    this.namaJabatan,
    this.eselon,
    this.namaEselon,
    this.eselonOrder,
    this.pltJabatan,
    this.pltJenis,
    this.pltSkpd,
    this.pltSkpdId,
    this.skpdId,
    this.createdAt,
    this.updatedAt,
    this.nmSkpd,
    this.bidang,
    this.unitKerja,
    this.roles,
    this.rolesName,
  });
  late final String? jabatanSkpd;
  late final String? jabatanSkpdPlt;
  late final String? id;
  late final String? nip;
  late final String? nik;
  late final String name;
  late final String? username;
  late final String? password;
  late final String? tempatLahir;
  late final String? tanggalLahir;
  late final String? jk;
  late final String? alamat;
  late final String? noHp;
  late final String? email;
  late final String? foto;
  late final String? kedudukanHukum;
  late final String? jenisKepegawaian;
  late final String? golRuang;
  late final String? golPangkat;
  late final String? jenisJabatan;
  late final String? namaJabatan;
  late final String? eselon;
  late final String? namaEselon;
  late final String? eselonOrder;
  late final String? pltJabatan;
  late final String? pltJenis;
  late final String? pltSkpd;
  late final String? pltSkpdId;
  late final String? skpdId;
  late final String? createdAt;
  late final String? updatedAt;
  late final String? nmSkpd;
  late final String? bidang;
  late final String? unitKerja;
  late final String? roles;
  late final String? rolesName;
  
  SUserLogOut.fromJson(Map<dynamic, dynamic> json){
    jabatanSkpd = json['jabatan_skpd'];
    jabatanSkpdPlt = json['jabatan_skpd_plt'];
    id = json['id'];
    nip = json['nip'];
    nik = json['nik'];
    name = json['name'];
    username = json['username'];
    password = json['password'];
    tempatLahir = json['tempat_lahir'];
    tanggalLahir = json['tanggal_lahir'];
    jk = json['jk'];
    alamat = json['alamat'];
    noHp = json['no_hp'];
    email = json['email'];
    foto = json['foto'];
    kedudukanHukum = json['kedudukan_hukum'];
    jenisKepegawaian = json['jenis_kepegawaian'];
    golRuang = json['gol_ruang'];
    golPangkat = json['gol_pangkat'];
    jenisJabatan = json['jenis_jabatan'];
    namaJabatan = json['nama_jabatan'];
    eselon = json['eselon'];
    namaEselon = json['nama_eselon'];
    eselonOrder = json['eselon_order'];
    pltJabatan = json['plt_jabatan'];
    pltJenis = json['plt_jenis'];
    pltSkpd = json['plt_skpd'];
    pltSkpdId = json['plt_skpd_id'];
    skpdId = json['skpd_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    nmSkpd = json['nm_skpd'];
    bidang = json['bidang'];
    unitKerja = json['unit_kerja'];
    roles = json['roles'];
    rolesName = json['roles_name'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['jabatan_skpd'] = jabatanSkpd;
    _data['jabatan_skpd_plt'] = jabatanSkpdPlt;
    _data['id'] = id;
    _data['nip'] = nip;
    _data['nik'] = nik;
    _data['name'] = name;
    _data['username'] = username;
    _data['password'] = password;
    _data['tempat_lahir'] = tempatLahir;
    _data['tanggal_lahir'] = tanggalLahir;
    _data['jk'] = jk;
    _data['alamat'] = alamat;
    _data['no_hp'] = noHp;
    _data['email'] = email;
    _data['foto'] = foto;
    _data['kedudukan_hukum'] = kedudukanHukum;
    _data['jenis_kepegawaian'] = jenisKepegawaian;
    _data['gol_ruang'] = golRuang;
    _data['gol_pangkat'] = golPangkat;
    _data['jenis_jabatan'] = jenisJabatan;
    _data['nama_jabatan'] = namaJabatan;
    _data['eselon'] = eselon;
    _data['nama_eselon'] = namaEselon;
    _data['eselon_order'] = eselonOrder;
    _data['plt_jabatan'] = pltJabatan;
    _data['plt_jenis'] = pltJenis;
    _data['plt_skpd'] = pltSkpd;
    _data['plt_skpd_id'] = pltSkpdId;
    _data['skpd_id'] = skpdId;
    _data['created_at'] = createdAt;
    _data['updated_at'] = updatedAt;
    _data['nm_skpd'] = nmSkpd;
    _data['bidang'] = bidang;
    _data['unit_kerja'] = unitKerja;
    _data['roles'] = roles;
    _data['roles_name'] = rolesName;
    return _data;
  }
}
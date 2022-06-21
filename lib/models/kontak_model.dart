class KontakModel {
  String id;
  String nama;
  String nomor;

  KontakModel({
    this.id,
    this.nama,
    this.nomor,
  });

  KontakModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    nama = json['nama'];
    nomor = json['nomor'];
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'nama': nama,
      'nomor': nomor,
    };
  }
}


class SuCo {
  String chiTiet;
  String hinhAnh;
  String id;
  bool khanCap;
  String loaiSuCo;
  int ngayBatDau;
  int ngayTiepNhan;
  int ngayXuLy;
  String trangThai;
  String vitriP;

  SuCo({
    required this.chiTiet,
    required this.hinhAnh,
    required this.id,
    required this.khanCap,
    required this.loaiSuCo,
    required this.ngayBatDau,
    required this.ngayTiepNhan,
    required this.ngayXuLy,
    required this.trangThai,
    required this.vitriP,
  });

  factory SuCo.fromJson(Map<String, dynamic> json) {
    return SuCo(
      chiTiet: json['chiTiet'],
      hinhAnh: json['hinhAnh'],
      id: json['id'],
      khanCap: json['khanCap'],
      loaiSuCo: json['loaiSuCo'],
      ngayBatDau: json['ngayBatDau'],
      ngayTiepNhan: json['ngayTiepNhan'],
      ngayXuLy: json['ngayXuLy'],
      trangThai: json['trangThai'],
      vitriP: json['vitriP'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'chiTiet': chiTiet,
      'hinhAnh': hinhAnh,
      'id': id,
      'khanCap': khanCap,
      'loaiSuCo': loaiSuCo,
      'ngayBatDau': ngayBatDau,
      'ngayTiepNhan': ngayTiepNhan,
      'ngayXuLy': ngayXuLy,
      'trangThai': trangThai,
      'vitriP': vitriP,
    };
  }
}

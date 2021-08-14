class Semester {
  final int HocKy;
  final int NamHoc;
  final int HocKyID;
  final String NgayBatDau;
  final String sNgayBatDau;
  final String NgayKetThuc;
  final String sNgayKetThuc;
  final String TenHocKy;
  final bool LaHocKyPhu;
  final bool LaHocKyHienHanh;

  Semester(
      {this.HocKy,
      this.NamHoc,
      this.HocKyID,
      this.NgayBatDau,
      this.sNgayBatDau,
      this.NgayKetThuc,
      this.sNgayKetThuc,
      this.TenHocKy,
      this.LaHocKyPhu,
      this.LaHocKyHienHanh});

  factory Semester.fromJson(Map<String, dynamic> json) {
    return Semester(
        HocKy: json['HocKy'],
        NamHoc: json['NamHoc'],
        HocKyID: json['HocKyID'],
        NgayBatDau: json['NgayBatDau'],
        sNgayBatDau: json['sNgayBatDau'],
        NgayKetThuc: json['NgayKetThuc'],
        sNgayKetThuc: json['sNgayKetThuc'],
        TenHocKy: json['TenHocKy'],
        LaHocKyPhu: json['LaHocKyPhu'],
        LaHocKyHienHanh: json['LaHocKyHienHanh']);
  }

  String toString() {
    return "Hoc Ky: " +
        HocKy.toString() +
        " Nam Hoc: " +
        NamHoc.toString() +
        " Hoc Ky ID: " +
        HocKyID.toString() +
        " Ngay bat dau: " +
        NgayBatDau.toString() +
        " Ngay bat dau s" +
        sNgayBatDau.toString() +
        " Ngay ket thuc: " +
        NgayKetThuc.toString() +
        " Ngay ket thuc s " +
        sNgayKetThuc.toString() +
        " Ten Hoc Ky: " +
        TenHocKy +
        " La Hoc Ky Phu: " +
        LaHocKyPhu.toString() +
        " La Hoc Ky Hien Hanh: " +
        LaHocKyHienHanh.toString();
  }
}

class Schedule {
  final String MaMH;
  final String Nhom;
  final String Phong;
  final int SoTiet;
  final String TenMonHoc;
  final int Thu;
  final int TietBatDau;
  final String ToTH;
  final String Tuan;

  Schedule({
    this.MaMH,
    this.Nhom,
    this.Phong,
    this.SoTiet,
    this.TenMonHoc,
    this.Thu,
    this.TietBatDau,
    this.ToTH,
    this.Tuan,
  });

  factory Schedule.fromJson(Map<String, dynamic> json) {
    return Schedule(
      MaMH: json["MaMH"],
      Nhom: json["Nhom"],
      Phong: json["Phong"],
      SoTiet: json["SoTiet"],
      TenMonHoc: json["TenMonHoc"],
      Thu: json["Thu"],
      TietBatDau: json["TietBatDau"],
      ToTH: json["ToTH"],
      Tuan: json["Tuan"],
    );
  }

  String toString() {
    return "Ma MH: " +
        MaMH +
        " Nhom: " +
        Nhom +
        " So Tiet: " +
        SoTiet.toString() +
        " Ten Mon Hoc: " +
        TenMonHoc +
        " Thu: " +
        Thu.toString() +
        " Tiet bat dau: " +
        TietBatDau.toString() +
        " To TH: " +
        ToTH.toString() +
        " Tuan: " +
        Tuan.toString();
  }
}

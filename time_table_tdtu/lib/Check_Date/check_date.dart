import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class PreDate {
  static PreDate preDate;
  String date;
  String thu;

  PreDate();

  void setDate(String date) {
    if (this.date == null) {
      this.date = currentDate();
    }
    this.date = date;
  }

  String getDate() {
    return this.date;
  }

  String currentDate() {
    String date = DateFormat('dd/MM/yyyy').format(DateTime.now());
    this.date = date;
    return date;
  }

  String getThu() {
    int weekday = DateFormat('dd/MM/yyyy').parse(this.date).weekday;
    switch (weekday) {
      case 1:
        return "Thứ Hai";
      case 2:
        return "Thứ Ba";
      case 3:
        return "Thứ Tư";
      case 4:
        return "Thứ Năm";
      case 5:
        return "Thứ Sáu";
      case 6:
        return "Thứ Bảy";
      case 7:
        return "Chủ Nhật";
    }
  }

  PreDate getInstance() {
    if (preDate == null) {
      preDate = PreDate();
      preDate.currentDate();
    }
    return preDate;
  }
}

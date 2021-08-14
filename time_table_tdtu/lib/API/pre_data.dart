import 'package:flutter/scheduler.dart';
import 'package:intl/intl.dart';
import 'package:time_table_tdtu/API/GetSchedule.dart';
import 'package:time_table_tdtu/API/Schedule.dart';
import 'package:time_table_tdtu/API/pre_data_semester.dart';

import 'Semester.dart';

class PreData {
  Semester semester;

  PreData({this.semester}) : assert(semester == null);

  String findWeekDate(DateTime dateTime) {
    var start_date = DateFormat('d/M/yy')
        .parse(CurrentSemester().getInstance().getSemester().sNgayBatDau);
    // var endDate = DateFormat('d/M/yy').format(dateTime);
    // var end_date = DateFormat('dd/MM/yyyy').parse(endDate);
    var end_date = dateTime;
    // print("start_date: $start_date");
    // print("end date: $dateTime");
    int count = end_date.difference(start_date).inDays ~/ 7 + 2;
    // print("count ${count}");
    return count.toString();
  }

  List<String> preWeek(String week) {
    List<String> _week_list = week.split('');
    List<String> _week_convert = [];
    for (int index = 0; index < _week_list.length; index++) {
      if (_week_list[index] != '-') {
        int week = index + 2;
        _week_convert.add(week.toString());
      }
    }
    return _week_convert;
  }

  //lay thu
  String getThu(DateTime weekday) {
    // int weekday = DateFormat('dd/MM/yyyy').parse(this.date).weekday;
    switch (weekday.weekday) {
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

  String getTimeStar(int intShfit) {
    switch (intShfit) {
      case 1:
        return "06:50";
      case 2:
        return "09:25";
      case 3:
        return "12:30";
      case 4:
        return "15:05";
      case 5:
        return "17:47";
    }
  }

  //tim ngay tuan tien trong tuan
  DateTime firstDay(String day) {
    DateTime _day = DateFormat('dd/MM/yyyy').parse(day);
    return _day.subtract(Duration(days: _day.weekday - 1));
  }

  DateTime lastDay(String day) {
    DateTime _day = DateFormat('dd/MM/yyyy').parse(day);
    return _day.add(Duration(days: DateTime.daysPerWeek - _day.weekday));
  }

  List<Schedule> _checkdata(List<Schedule> data) {
    List<Schedule> listRemove = [];
    data.forEach((element) {
      element.Tuan == null ? listRemove.add(element) : null;
    });
    listRemove.forEach((element) {
      data.remove(element);
    });
    return data;
  }

  //format date to string
  String formatToString(DateTime date) {
    return DateFormat('dd/MM/yyyy').format(date);
  }

  //lay tat ca cac ngay trong hoc ky
  List<String> getAllDateFollowWeek() {
    Semester semester = CurrentSemester().getInstance().getSemester();
    List<String> listDateWeek = [];
    String week =
        findWeekDate(DateFormat('dd/MM/yyyy').parse(semester.sNgayKetThuc));
    DateTime dateStart = DateFormat('dd/MM/yyyy').parse(semester.sNgayBatDau);
    for (int index = 0; index < int.parse(week); index++) {
      DateTime startDate = dateStart.add(Duration(days: 7 * index));
      String first =
          DateFormat('dd/MM').format(firstDay(formatToString(startDate)));
      String dateEnd =
          DateFormat('dd/MM').format(lastDay(formatToString(startDate)));
      listDateWeek.add("Từ ngày ${first} đến ${dateEnd}");
    }
    return listDateWeek;
  }

  int getShift(int tietBatDau) {
    if ((tietBatDau >= 1) & (tietBatDau <= 3)) {
      return 1;
    } else if ((tietBatDau >= 4) & (tietBatDau <= 6)) {
      return 2;
    } else if ((tietBatDau >= 7) & (tietBatDau <= 9)) {
      return 3;
    } else if ((tietBatDau >= 10) & (tietBatDau <= 12)) {
      return 4;
    } else
      return 5;
  }

  //co the khong dung
  DateTime dayStartWeek(int week) {
    DateTime startDate = DateFormat('dd/MM/yyyy')
        .parse(CurrentSemester().getInstance().getSemester().sNgayBatDau);

    return startDate.subtract(Duration(days: -7 * (week - 1)));
  }

  //tim ngay day tien trong tuan
  DateTime firstDayOfWeek(String date) {
    DateTime firstDay = DateFormat('dd/MM/yyyy').parse(date);
    return firstDay.subtract(Duration(days: firstDay.weekday - 1));
  }

  //check shift
  // Double testRun(int tietBatDau, int soTiet) {}
  //lay mon hoc mot thu
  List<Schedule> getScheduleFolowDayofWeek(
      int dayWeekend, List<Schedule> dataOfWeek) {
    List<Schedule> _courceOfDay = [];
    for (Schedule _schedule in dataOfWeek) {
      if (_schedule.Thu == dayWeekend) {
        _courceOfDay.add(_schedule);
      }
    }
    _courceOfDay.isEmpty
        ? null
        : _courceOfDay.sort((a, b) => a.TietBatDau.compareTo(b.TietBatDau));
    return _courceOfDay;
  }

  //lay mon hoc trong mot tuan
  List<Schedule> getScheduleFolowWeek(String date, List<Schedule> data) {
    List<Schedule> _data = _checkdata(data); //kiem tra co tuan rong khong
    DateTime _firstDay = firstDay(date); //lay ngay dau tien trong tuan
    String week = findWeekDate(_firstDay); //lay tuan trong hoc ky

    List<Schedule> _courceDayWeek = [];
    for (Schedule _schedule in _data) {
      if (preWeek(_schedule.Tuan).contains(week)) {
        _courceDayWeek.add(_schedule);
      }
    }
    _courceDayWeek.isEmpty ? null : _courceDayWeek;
    return _courceDayWeek;
  }

  //lay mon hoc trong mot ngay
  List<Schedule> getScheduleFolowDate(String _date, List<Schedule> data) {
    if (data == null) {
      return null;
    }
    DateTime date = DateFormat('dd/MM/yyyy').parse(_date);

    String week = findWeekDate(date);
    int dateWeek = date.weekday;
    List<Schedule> _cource = [];
    List<Schedule> _data = _checkdata(data); //kiem tra co tuan rong khong

    for (Schedule _schedule in _data) {
      // print(_schedule);
      // print(preWeek(_schedule.Tuan));
      if ((preWeek(_schedule.Tuan).contains(week) == true) &
          ((dateWeek + 1) == _schedule.Thu)) {
        _cource.add(_schedule);
      }
    }
    _cource.isEmpty
        ? null
        : _cource.sort((a, b) => a.TietBatDau.compareTo(b.TietBatDau));

    return _cource;
  }

  //kiem tra mon hoc trong mot ca
  // ignore: missing_return
  List<Schedule> checkScheduleInDay(List<Schedule> data) {
    List<Schedule> _dataCource = [];
    data.firstWhere((element) => element.TietBatDau == 1) != null
        ? _dataCource.add(data.firstWhere((element) => element.TietBatDau == 1))
        : _dataCource.add(null);
    data.firstWhere((element) => element.TietBatDau == 4) != null
        ? _dataCource.add(data.firstWhere((element) => element.TietBatDau == 4))
        : _dataCource.add(null);
    data.firstWhere((element) => element.TietBatDau == 7) != null
        ? _dataCource.add(data.firstWhere((element) => element.TietBatDau == 7))
        : _dataCource.add(null);
    data.firstWhere((element) => element.TietBatDau == 10) != null
        ? _dataCource
            .add(data.firstWhere((element) => element.TietBatDau == 10))
        : _dataCource.add(null);
    data.firstWhere((element) => element.TietBatDau == 13) != null
        ? _dataCource
            .add(data.firstWhere((element) => element.TietBatDau == 13))
        : _dataCource.add(null);
  }

  // List<String> getAllSemester(List<Semester> data) {
  //   print(data);
  //   return null;
  // }

  String checkNameCource(Schedule _cource) {
    return _cource.ToTH != null
        ? "Thực hành ${_cource.TenMonHoc}"
        : _cource.TenMonHoc;
  }
}

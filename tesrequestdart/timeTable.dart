import 'dart:math';
import 'package:http/http.dart';
import 'package:intl/intl.dart';
import 'GetTimeTable.dart';
import 'Semester.dart';
import 'GetSchedule.dart';
import 'Schedule.dart';

void main() async {
  GetTimeTable getTimeTable = new GetTimeTable();
  Future<List<Semester>> data = getTimeTable.fetchSemester();
  print("<<<<<<<<<<<<<<<<<<<<>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>");
  List<Semester> list = await data;
  print(list[5].toString());
  // Semester SEEMESTER = list[5];
  print("");
  print("=============================================");
  print("");

  GetSchedule getSchedule = new GetSchedule();
  Future<List<Schedule>> __data_schedule__ = getSchedule.getScheduleData();
  List<Schedule> __list_schedule__ = await __data_schedule__;

  // var date_start = DateFormat('d/M/yy').parse(list[5].sNgayBatDau);
  // print(date_start.weekday);

  // var date_test = DateFormat('d/M/yy').parse("19/08/2020");
  // print("date test: $date_test");
  // var count_Date = date_test.difference(date_start);
  // print(count_Date.inDays ~/ 7 + 1);

  // var date_end = DateFormat('d/M/yy').parse(list[5].sNgayKetThuc);
  // print(date_end.weekday);

  // int number_of_week() {
  //   var date_start = DateFormat('M/d/yy').parse(list[5].sNgayBatDau);
  //   print(date_start);
  //   return null;
  // }
  // String stringDate = ("26/05/2020");
  // DateTime date = DateFormat('dd/MM/yyyy').parse(stringDate);
  // print(date);

  // String week = __list_schedule__[5].Tuan;
  // List<String> weekConvert = [];
  // print(week);
  // List<String> listWeek = week.split('');
  // print(listWeek);
  // int index = 0;
  // bool flag = false;

  // while (index < listWeek.length) {
  //   if (listWeek[index] != '-') {
  //     weekConvert.add(index.toString());
  //     index += 1;
  //   } else {
  //     print('run');
  //     index += 1;
  //   }
  // }

  // print(weekConvert);

  // String week = "6";
  // DateTime dateStart = DateFormat('dd/MM/yyyy').parse("30/09/2020");
  // DateTime dateEnd = DateFormat('dd/MM/yyyy').parse(list[5].sNgayKetThuc);
  // int countDate = dateEnd.difference(dateStart).inDays;
  // print("date start: $dateStart");
  // DateTime checkDate = dateStart.add(Duration(days: 2));
  // print("check day ${DateFormat('dd/MM').format(checkDate).toString()}");
  // String test = DateFormat('dd/MM/yyyy').format(checkDate).toString();
  // DateTime formatTest = DateFormat('dd/MM/yyyy').parse(test);
  // print(formatTest);

  // DateTime dateStart = DateFormat('dd/MM/yyyy').parse(list[5].sNgayBatDau);
  // DateTime dateEnd = DateFormat('dd/MM/yyyy').parse(list[5].sNgayKetThuc);
  // int week = dateEnd.difference(dateStart).inDays ~/ 7 + 1;
  // print(week);
  // String dateFormat = DateFormat('dd/MM').format(dateStart);
  // print(dateFormat);
  // List<DateTime> listDateWeek = [];
  // for (int index = 0; index < week; index++) {
  //   DateTime startDate = dateStart.add(Duration(days: 7 * index));
  //   print("date start ${startDate.add(Duration(days: startDate.weekday - 1))}");
  //   print(
  //       "date end ${startDate.add(Duration(days: DateTime.daysPerWeek - startDate.weekday))}");
  //   print("=================================================================");
  //   DateTime endDate = dateStart
  //       .add(Duration(days: (DateTime.daysPerWeek - dateStart.weekday)));
  //   print(endDate);

  String _week(DateTime dateTime) {
    var start_date = DateFormat('d/M/yy').parse(list[5].sNgayBatDau);
    // var endDate = DateFormat('d/M/yy').format(dateTime);
    // var end_date = DateFormat('dd/MM/yyyy').parse(endDate);
    var end_date = dateTime;
    // print("start_date: $start_date");
    // print("end date: $dateTime");
    int count = end_date.difference(start_date).inDays ~/ 7 + 2;
    // print("count ${count}");
    return count.toString();
  }

  DateTime firstDay(String day) {
    DateTime _day = DateFormat('dd/MM/yyyy').parse(day);
    return _day.subtract(Duration(days: _day.weekday - 1));
  }

  DateTime lastDay(String day) {
    DateTime _day = DateFormat('dd/MM/yyyy').parse(day);
    return _day.add(Duration(days: DateTime.daysPerWeek - _day.weekday));
  }

  // Semester semester = list[5];
  // List<String> listDateWeek = [];
  // String week = _week(DateFormat('dd/MM/yyyy').parse(semester.sNgayKetThuc));
  // DateTime dateStart = DateFormat('dd/MM/yyyy').parse(semester.sNgayBatDau);
  // for (int index = 0; index < int.parse(week); index++) {
  //   DateTime startDate = dateStart.add(Duration(days: 7 * index));
  //   String test = DateFormat('dd/MM/yyyy').format(startDate);
  //   String first = DateFormat('dd/MM').format(firstDay(test));
  //   // String dateEnd = DateFormat('dd/MM').format(lastDay(startDate.toString()));
  //   // listDateWeek.add("${first} => ${dateEnd}");
  //   // print("${first} => ${dateEnd}");
  //   print("$first");
  // }

  int week = 8;
  DateTime dateTime = DateFormat('dd/MM/yyyy').parse(list[5].sNgayBatDau);
  DateTime newDate = dateTime.subtract(Duration(days: -7 * (week - 1)));
  print(dateTime);
  print(newDate);
  // print(listDateWeek);
}

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_picker/flutter_picker.dart';
import 'package:intl/intl.dart';
import 'package:time_table_tdtu/API/GetSchedule.dart';
import 'package:time_table_tdtu/API/Schedule.dart';
import 'package:time_table_tdtu/API/Semester.dart';
import 'package:time_table_tdtu/API/pre_data.dart';
import 'package:time_table_tdtu/API/pre_data_semester.dart';
import 'package:time_table_tdtu/Check_Date/check_date.dart';
import 'package:time_table_tdtu/style/style.dart';
import 'package:time_table_tdtu/style/styles.dart';

class CourceWeek extends StatefulWidget {
  @required
  // List<Semester> data;
  List<Schedule> dataSchedule;
  CourceWeek(this.dataSchedule);
  @override
  _CourceWeekState createState() => _CourceWeekState();
}

class _CourceWeekState extends State<CourceWeek> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    // Semester _semester =
    //     CurrentSemester().getInstance().semesterCurrent(widget.data);
    return Column(
      children: [
        InkWell(
          child: Container(
            width: size.width,
            child: Padding(
              padding:
                  const EdgeInsets.only(top: 8.0, right: 8.0, bottom: 10.0),
              child: Text(
                showDayInWeek(),
                style: styleTextDateSchedule,
                textAlign: TextAlign.end,
              ),
            ),
          ),
          onTap: () => _showPicker(context),
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Padding(
            //   padding: const EdgeInsets.only(top: 35.0, left: 5.0),
            //   child: buildShiftDefault(size),
            // ),
            Container(
              // color: Colors.black12,
              // color: Colors.amberAccent,
              height: size.height * .85,
              width: size.width * .92,
              child:
                  // buildShiftDefault(size),
                  ListView(
                scrollDirection: Axis.horizontal,
                children: buildAllWeek(size, widget.dataSchedule),
              ),
            ),
          ],
        ),
      ],
    );
    // return buildShiftDefault(size);
  }

  String showDayInWeek() {
    Semester semester = CurrentSemester().getInstance().getSemester();
    String start = DateFormat('dd/MM')
        .format(PreData().firstDay(PreDate().getInstance().getDate()));
    String end = DateFormat('dd/MM')
        .format(PreData().lastDay(PreDate().getInstance().getDate()));
    return "Từ ngày $start đến $end";
  }

  _showPicker(BuildContext context) {
    List<Widget> _childrent = [];
    for (String day in PreData().getAllDateFollowWeek()) {
      _childrent.add(Text(day));
    }

    DateTime date =
        DateFormat('dd/MM/yyyy').parse(PreDate().getInstance().currentDate());
    int week = int.parse(PreData().findWeekDate(date));

    // print("Run");
    Size size = MediaQuery.of(context).size;
    showCupertinoModalPopup(
        context: context,
        builder: (_) => Container(
              height: size.height * .4,
              width: size.width,
              color: pickerColor.withOpacity(0.9),
              child: CupertinoPicker(
                itemExtent: 50,
                children: _childrent,
                onSelectedItemChanged: (int value) {
                  setState(() {
                    String newDate = DateFormat('dd/MM/yyyy')
                        .format(PreData().dayStartWeek(value + 1));
                    PreDate().getInstance().setDate(newDate);
                  });
                },
                scrollController:
                    FixedExtentScrollController(initialItem: week),
              ),
            ));
  }

  Container buildShiftDefault(Size size) {
    double defaultSizeWidth = size.width * .07;
    double defaultSizeHeight = size.height * .6;
    double sizeHeightMoning = defaultSizeHeight / 2;
    double sizeHeightAfternoon = defaultSizeHeight / 2;
    return Container(
      // color: Colors.cyanAccent.withOpacity(80),
      // height: defaultSizeHeight * 1.25,
      child: Column(
        children: [
          Container(
            alignment: Alignment.center,
            height: sizeHeightMoning / 2,
            width: defaultSizeWidth,
            child: Text(
              "Ca 1",
              style: TextStyle(
                color: textColorShiftDefault,
                fontSize: 20.0,
                fontStyle: FontStyle.italic,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Container(
            alignment: Alignment.center,
            height: sizeHeightMoning / 2,
            width: defaultSizeWidth,
            child: Text(
              "Ca 2",
              style: TextStyle(
                color: textColorShiftDefault,
                fontSize: 20.0,
                fontStyle: FontStyle.italic,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Container(
            alignment: Alignment.center,
            height: sizeHeightMoning / 2,
            width: defaultSizeWidth,
            child: Text(
              "Ca 3",
              style: TextStyle(
                color: textColorShiftDefault,
                fontSize: 20.0,
                fontStyle: FontStyle.italic,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Container(
            alignment: Alignment.center,
            height: sizeHeightMoning / 2,
            width: defaultSizeWidth,
            child: Text(
              "Ca 4",
              style: TextStyle(
                color: textColorShiftDefault,
                fontSize: 20.0,
                fontStyle: FontStyle.italic,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Container(
            alignment: Alignment.center,
            height: sizeHeightMoning / 2,
            width: defaultSizeWidth,
            child: Text(
              "Ca 5",
              style: TextStyle(
                color: textColorShiftDefault,
                fontSize: 20.0,
                fontStyle: FontStyle.italic,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }

  List<Widget> buildAllWeek(Size size, List<Schedule> data) {
    DateTime date = PreData().firstDayOfWeek(PreDate().getInstance().getDate());
    List<Widget> _courceOfWeek = [];

    //lay ngay dau tien trong tuan
    for (int i = 0; i <= 6; i++) {
      DateTime _nextDay = date.add(Duration(days: i));
      String _dateString = DateFormat('dd/MM/yyyy').format(_nextDay);

      List<Schedule> _data = [];
      _data = PreData().getScheduleFolowDate(_dateString, data);
      // print("day: $_nextDay");
      // print("data: $_data");
      _courceOfWeek.add(buildOneDay(size, _data, _nextDay));
    }
    return _courceOfWeek;
  }

  Padding buildOneDay(Size size, List<Schedule> data, DateTime date) {
    double defaultSizeWidth = size.width * .7;
    double defaultSizeHeight = size.height * .6;
    double sizeHeightMoning = defaultSizeHeight / 2;
    double sizeHeightAfternoon = defaultSizeHeight / 2;
    int testShift = 3;

    // List<Schedule> _data = PreData().checkScheduleInDay(data);
    // DateTime _date = DateFormat('dd/MM/yyyy').parse(date);
    Schedule shift1;
    Schedule shift2;
    Schedule shift3;
    Schedule shift4;
    Schedule shift5;

    for (Schedule cource in data) {
      switch (cource.TietBatDau) {
        case 1:
          shift1 = cource;
          break;
        case 4:
          shift2 = cource;
          break;
        case 7:
          shift3 = cource;
          break;
        case 10:
          shift4 = cource;
          break;
        case 13:
          shift5 = cource;
          break;
      }
    }

    return Padding(
      padding: const EdgeInsets.only(left: 10.0),
      child: Container(
        // color: Colors.blueAccent,
        // height: size.height * .06,
        width: size.width * .7,
        child: Column(
          children: [
            Container(
              // color: Colors.red,
              height: size.height * 0.06,
              width: size.width * 0.5,
              child: Column(
                children: [
                  Text(
                    "${DateFormat('dd/MM').format(date).toString()}",
                    style: TextStyle(
                        color: textColorConstants,
                        fontSize: 18.0,
                        fontStyle: FontStyle.italic,
                        fontWeight: FontWeight.bold),
                  ),
                  Text(
                    "${PreData().getThu(date)}",
                    style: TextStyle(
                        color: textColorConstants,
                        fontSize: 18.0,
                        fontStyle: FontStyle.italic,
                        fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ), //ngay va thu

            Container(
              height: sizeHeightMoning,
              width: defaultSizeWidth,
              // color: Colors.black,
              child: Column(
                children: [
                  Flexible(
                    flex: shift1 != null ? shift1.SoTiet : testShift,
                    child: shift1 != null ? shiftCource(shift1) : shiftNull(),
                  ),
                  SizedBox(height: defaultSizeSpaceCourceWeek),
                  Flexible(
                    flex: shift1 != null ? 6 - shift1.SoTiet : 6 - testShift,
                    child: shift2 != null ? shiftCource(shift2) : shiftNull(),
                  )
                ],
              ),
            ), // mon hoc buoi sang
            SizedBox(height: defaultSizeSpaceCourceWeek),
            Container(
              height: sizeHeightAfternoon,
              width: defaultSizeWidth,
              child: Column(
                children: [
                  Flexible(
                    flex: shift3 != null ? shift3.SoTiet : testShift,
                    child: shift3 != null ? shiftCource(shift3) : shiftNull(),
                  ),
                  SizedBox(height: defaultSizeSpaceCourceWeek),
                  Flexible(
                    flex: shift3 != null ? 6 - shift3.SoTiet : 6 - testShift,
                    child: shift4 != null ? shiftCource(shift4) : shiftNull(),
                  ),
                ],
              ),
            ),
            SizedBox(height: defaultSizeSpaceCourceWeek),
            Container(
              height: sizeHeightAfternoon / 2,
              width: defaultSizeWidth,
              child: shift5 != null ? shiftCource(shift5) : shiftNull(),
            )
          ],
        ),
      ),
    );
  }

  Container shiftNull() {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20.0),
        color: Colors.white.withOpacity(0.1),
      ),
    );
  }

//container cua moi mon hoc
  Widget shiftCource(Schedule cource) {
    return Container(
      // width: widget.size.width * .7, //size width a schedule
      width: 500,
      // color: Colors.amberAccent,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16.0), color: boxCourceColor),
      child: Padding(
        padding: const EdgeInsets.only(top: 8.0, left: defaultPadding),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(
                  Icons.adjust,
                  color: textColorShift,
                  size: 20.0,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: Text(
                    "Ca ${PreData().getShift(cource.TietBatDau)}",
                    style: styleTextShiftCource,
                  ),
                ),
                // Container(
                //   // width: widget.size.width * .48,
                //   width: 450,
                //   child: Text(
                //     "Bắt đầu: ${PreData().getTimeStar(PreData().getShift(cource.TietBatDau))}",
                //     style: styleTextTimeStart,
                //     textAlign: TextAlign.end,
                //   ),
                // ),
              ],
            ),
            Text(
              "Môn học: ${PreData().checkNameCource(cource)}",
              style: styleTextNameCource,
              textAlign: TextAlign.start,
            ),
            Text(
              "Phòng: ${cource.Phong}",
              style: styleTextNameCource,
              textAlign: TextAlign.start,
            ),
            Row(
              children: [
                Text(
                  "Nhóm: ${cource.Nhom}",
                  style: styleTextMoreInfor,
                ),
                SizedBox(
                  width: 9,
                ),
                Text(
                  "Số Tiết: ${cource.SoTiet}",
                  style: styleTextMoreInfor,
                  textAlign: TextAlign.start,
                ),
                SizedBox(
                  width: 9,
                ),
                cource.ToTH != null
                    ? Text(
                        "Tổ: ${cource.ToTH}",
                        style: styleTextMoreInfor,
                      )
                    : SizedBox(),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

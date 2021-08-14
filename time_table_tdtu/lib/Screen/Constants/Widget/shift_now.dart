import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:time_table_tdtu/API/GetSchedule.dart';
import 'package:time_table_tdtu/API/Schedule.dart';
import 'package:time_table_tdtu/API/Semester.dart';
import 'package:time_table_tdtu/API/pre_data.dart';
import 'package:time_table_tdtu/API/pre_data_semester.dart';
import 'package:time_table_tdtu/Check_Date/check_date.dart';
import 'package:time_table_tdtu/style/style.dart';

class ShiftNow extends StatefulWidget {
  final Size size;
  List<Schedule> scheduleIn;

  ShiftNow(this.size, this.scheduleIn);

  @override
  _ShiftNowState createState() => _ShiftNowState();
}

class _ShiftNowState extends State<ShiftNow> {
  List<Widget> getWidgetCource(List<Schedule> _data) {
    List<Widget> childrent = [];
    Schedule cource;
    String date = PreDate().getInstance().getDate();

    List<Schedule> _cource = PreData().getScheduleFolowDate(date, _data);
    for (cource in _cource) {
      childrent.add(shiftCource(cource));
      childrent.add(SizedBox(
        width: 10,
      ));
    }
    return childrent;
  }

  Widget shiftCource(Schedule cource) {
    return Container(
      width: widget.size.width * .7, //size width a schedule
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
                Container(
                  width: widget.size.width * .48,
                  child: Text(
                    "Bắt đầu: ${PreData().getTimeStar(PreData().getShift(cource.TietBatDau))}",
                    style: styleTextTimeStart,
                    textAlign: TextAlign.end,
                  ),
                ),
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
            Container(
              width: widget.size.width * .65,
              height: widget.size.height * 0.0321,
              alignment: Alignment.topRight,
              child: TextButton(
                style: TextButton.styleFrom(
                  textStyle: styleTextCheckLearned,
                ),
                child: Text("Bấm vào đây nếu bạn nghỉ học."),
                onPressed: () => {},
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      //size of list schedule
      // height: widget.size.height * 0.25,
      width: widget.size.width,

      // color: Colors.black12,
      alignment: Alignment.bottomLeft,
      padding: EdgeInsets.only(left: defaultPadding, top: 10.0, bottom: 18.0),
      child: Column(
        children: [
          buildDateShift(context),
          SizedBox(
            height: 10.0,
          ),
          buildShift(widget.scheduleIn),
        ],
      ),
    );
  }

  Container buildShift(List<Schedule> schedule) {
    return getWidgetCource(schedule).isNotEmpty
        ? Container(
            //size height of a shift
            height: widget.size.height * 0.16,
            width: widget.size.width,
            // color: Colors.redAccent,
            child: ListView(
                scrollDirection: Axis.horizontal,
                children: getWidgetCource(schedule)),
          )
        : containerNullCource();
  }

  Container containerNullCource() {
    return Container(
      height: widget.size.height * .1,
      width: widget.size.width,
      alignment: Alignment.topCenter,
      child: Padding(
        padding: const EdgeInsets.only(top: 30.0),
        child: Text(
          "Hôm nay không có môn học!",
          style: styleTextNoneCource,
        ),
      ),
    );
  }

  InkWell buildDateShift(var context) {
    return InkWell(
      onTap: () => showCupertinoModalPopup(
        context: context,
        builder: (context) => Container(
          height: widget.size.height * 0.5,
          color: pickerColor.withOpacity(0.9),
          child: Column(
            children: [
              Container(
                height: widget.size.height * 0.35,
                child: CupertinoDatePicker(
                  initialDateTime: DateFormat('dd/MM/yyyy')
                      .parse(PreDate().getInstance().getDate()),
                  maximumYear: DateFormat('dd/MM/yyyy')
                              .parse(CurrentSemester()
                                  .getInstance()
                                  .getSemester()
                                  .sNgayKetThuc)
                              .year !=
                          DateFormat('dd/MM/yyyy')
                              .parse(CurrentSemester()
                                  .getInstance()
                                  .getSemester()
                                  .sNgayBatDau)
                              .year
                      ? DateFormat('dd/MM/yyyy')
                          .parse(CurrentSemester()
                              .getInstance()
                              .getSemester()
                              .sNgayKetThuc)
                          .year
                      : null,
                  minimumYear: DateFormat('dd/MM/yyyy')
                      .parse(CurrentSemester()
                          .getInstance()
                          .getSemester()
                          .sNgayBatDau)
                      .year,
                  mode: CupertinoDatePickerMode.date,
                  onDateTimeChanged: (value) {
                    setState(() {
                      PreDate()
                          .getInstance()
                          .setDate(DateFormat('dd/MM/yyyy').format(value));
                    });
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 10.0),
                child: CupertinoButton(
                  color: pickerColor,
                  child: Text(
                    "OK",
                    style: TextStyle(color: textColorCourse, fontSize: 19.0),
                  ),
                  onPressed: () => Navigator.of(context).pop(),
                ),
              ),
            ],
          ),
        ),
      ),
      child: Container(
        // width: widget.size.width * 0.65,
        alignment: Alignment.topRight,
        child: Padding(
          padding: const EdgeInsets.only(right: defaultPadding),
          child: Text(
            "${PreDate().getInstance().getThu()}, ${PreDate().getInstance().getDate()}",
            style: styleTextDateSchedule,
          ),
        ),
      ),
    );
  }
}

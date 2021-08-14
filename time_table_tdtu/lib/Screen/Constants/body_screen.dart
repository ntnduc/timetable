import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:intl/intl.dart';
import 'package:time_table_tdtu/API/GetSchedule.dart';

import 'package:time_table_tdtu/API/GetSemester.dart';
import 'package:time_table_tdtu/API/Semester.dart';
import 'package:time_table_tdtu/API/pre_data.dart';
import 'package:time_table_tdtu/API/pre_data_semester.dart';
import 'package:time_table_tdtu/Screen/Constants/Widget/cource_week.dart';

import 'package:time_table_tdtu/Screen/Constants/Widget/shift_now.dart';
import 'package:time_table_tdtu/style/styles.dart';

class BodyScreen extends StatefulWidget {
  AsyncSnapshot<List<Semester>> snapshot;
  BodyScreen(this.snapshot);

  @override
  _BodyScreenState createState() => _BodyScreenState();
}

class _BodyScreenState extends State<BodyScreen> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    //build lai cho nay cho dep
    //load toan bo du lieu
    if (widget.snapshot.connectionState == ConnectionState.waiting) {
      return Container(
        child: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }
    //kiem tra co loi khong
    else if (widget.snapshot.hasError) {
      return Container(
        child: Center(
          child: Text("Connect wrong!"),
        ),
      );
    }
    //lay duoc data
    //phan build cho body cua man hinh
    else {
      Semester semester =
          CurrentSemester().getInstance().semesterCurrent(widget.snapshot.data);
      return SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: size.height * .2,
              width: size.width,
              // color: Colors.black38,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: size.height * .08,
                    width: 40,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 28.0),
                    child: Text(
                      "Timetable",
                      style: TextStyle(
                        fontSize: 46.0,
                        color: textColorHeader,
                        fontStyle: FontStyle.italic,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 40.0),
                    child: buildHeader(context),
                  )
                ],
              ),
            ),
            // SizedBox(
            //   height: size.height * .01,
            // ),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: FutureBuilder(
                future: GetSchedule()
                    .getScheduleData(semester.NamHoc, semester.HocKy),
                builder: (context, data) => buildBody(size, data),
              ),
            ),
          ],
        ),
      );
    }
  }

  Widget buildBody(Size size, AsyncSnapshot data) {
    if (data.connectionState == ConnectionState.waiting) {
      return Container(
        child: Center(
          child: CircularProgressIndicator(),
        ),
      );
    } else if (data.hasError) {
      print(data.error);
      return Container(
        child: Center(
          child: Text("Loi"),
        ),
      );
    } else {
      return SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Container(
          child: Column(
            children: <Widget>[
              ShiftNow(size, data.data),
              CourceWeek(data.data),
            ],
          ),
        ),
      );
    }
  }

  Container buildHeader(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      width: size.width,
      height: size.height * .05,
      child: buildIconButton(widget.snapshot, context),
    );
  }

  IconButton buildIconButton(
      AsyncSnapshot<List<Semester>> snapshot, BuildContext context) {
    if (snapshot.connectionState == ConnectionState.waiting) {
      return IconButton(icon: CircularProgressIndicator());
    }
    return IconButton(
      alignment: Alignment.topLeft,
      icon: Text(
        "Học kỳ hiện tại ${CurrentSemester().getInstance().semesterCurrent(snapshot.data).TenHocKy}",
        style: TextStyle(
          fontSize: 17.0,
          color: textColorConstants,
          fontStyle: FontStyle.italic,
          fontWeight: FontWeight.bold,
        ),
      ),
      onPressed: () => _showPicker(context, snapshot),
    );
  }

  void _showPicker(BuildContext context, AsyncSnapshot snapshot) {
    List<Widget> _children = [];
    Size size = MediaQuery.of(context).size;
    for (Semester _semester in snapshot.data.take(10)) {
      _children.add(Text(_semester.TenHocKy));
    }
    int initItem = 0;

    if (CurrentSemester().getInstance().getSemester() != null) {
      while ((initItem < snapshot.data.length) & (initItem < 14)) {
        if (snapshot.data[initItem] ==
            CurrentSemester().getInstance().getSemester()) {
          break;
        } else {
          initItem = initItem + 1;
        }
      }
      if (initItem == 13) {
        initItem = 0;
      }
    }

    showCupertinoModalPopup(
      context: context,
      builder: (_) => Container(
        height: size.height * 0.4,
        width: size.width,
        child: CupertinoPicker(
          itemExtent: 50,
          backgroundColor: pickerColor,
          onSelectedItemChanged: (int value) {
            setState(() {
              CurrentSemester().getInstance().setSemester(snapshot.data[value]);
            });
          },
          children: _children,
          scrollController: FixedExtentScrollController(initialItem: initItem),
        ),
      ),
    );
  }
}

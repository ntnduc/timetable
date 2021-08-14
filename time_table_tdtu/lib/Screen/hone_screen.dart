import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:time_table_tdtu/API/GetSemester.dart';
import 'package:time_table_tdtu/Screen/Constants/body_screen.dart';
import 'package:time_table_tdtu/Screen/Constants/drawer.dart';
import 'package:time_table_tdtu/style/styles.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      drawer: DrawerInfor(),
      // appBar: buildAppBar(size),
      body: FutureBuilder(
        future: GetSemester().fetchSemester(),
        builder: (context, snapshot) => Stack(
          children: [
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: textColorGradient,
                ),
              ),
            ),
            Container(
              // color: Colors.amberAccent,
              child: BodyScreen(snapshot),
            ),
          ],
        ),
      ),
    );
  }

  AppBar buildAppBar(Size size) {
    return AppBar(
        toolbarHeight: 80.0,
        elevation: 0,
        backgroundColor: backgroundColor,
        title: Container(
          alignment: Alignment.bottomLeft,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 25.0),
                child: Text(
                  "Time Table",
                  style: TextStyle(
                    color: textColorHeader,
                    fontSize: 25.0,
                  ),
                  textAlign: TextAlign.start,
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 10.0),
                child: Text(
                  "Hi, Wellcome!",
                  style: TextStyle(
                    color: textColorHeader,
                    fontSize: 20.0,
                  ),
                  textAlign: TextAlign.start,
                ),
              ),
              SizedBox(
                height: 10,
              ),
            ],
          ),
        ));
  }
}

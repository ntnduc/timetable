import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:time_table_tdtu/Screen/hone_screen.dart';
import 'package:time_table_tdtu/style/styles.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          textTheme:
              Theme.of(context).textTheme.apply(bodyColor: textColorHeader)),
      title: "Time Table TDTU",
      home: HomeScreen(),
    );
  }
}

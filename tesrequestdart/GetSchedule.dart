import 'dart:convert';
import 'Schedule.dart';
import 'package:http/http.dart' as http;

class GetSchedule {
  String KEY = "e491aabdbb4725f8b92540a2d5f7310b";
  var URL_API = {
    "list_semester":
        "http://thoikhoabieudukien.tdtu.edu.vn/API/XemKetQuaDangKy/LoadHocKy",
    "list_schedule":
        "http://mobiservice.tdt.edu.vn/Service1.svc/LayTKBTHeoHocKyService"
  };
  String username = "518h0609";
  String password = "Nhatduc447";

  GetSchedule();

  Map<String, dynamic> _predata(String semester, String year) => {
        "Key": KEY,
        "MSSV": username,
        "MatKhau": password,
        "NamHoc": year,
        "HocKy": semester,
      };

  List<Schedule> __convertToJson(String response) {
    final parsed = json.decode(response).cast<Map<String, dynamic>>();
    final data =
        parsed.map<Schedule>((json) => Schedule.fromJson(json)).toList();
    return data;
  }

  Future<List<Schedule>> getScheduleData() async {
    int __semester__ = 1;
    int __semester_year__ = 2020;
    final response = await http.post(
      URL_API["list_schedule"],
      headers: <String, String>{
        'Content-Type': 'application/json',
      },
      body: jsonEncode(<String, dynamic>{
        'Key': KEY,
        'MSSV': username,
        'MatKhau': password,
        'NamHoc': __semester_year__,
        'HocKy': __semester__,
      }),
    );
    if (response.statusCode == 200) {
      // print(response.body);
      return __convertToJson(response.body);
    } else {
      return null;
    }
  }
}

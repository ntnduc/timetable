import 'dart:convert';
import 'package:http/http.dart' as http;
import 'Semester.dart';

class GetSemester {
  String KEY = "e491aabdbb4725f8b92540a2d5f7310b";
  var URL_API = {
    "list_semester":
        "http://thoikhoabieudukien.tdtu.edu.vn/API/XemKetQuaDangKy/LoadHocKy",
    "list_schedule":
        "http://mobiservice.tdt.edu.vn/Service1.svc/LayTKBTHeoHocKyService"
  };

  List<Semester> SEMESTER_DATA;

  GetSemester();

  List<Semester> parseSemester(String responseBody) {
    final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
    final data =
        parsed.map<Semester>((json) => Semester.fromJson(json)).toList();
    return data;
  }

  Future<List<Semester>> fetchSemester() async {
    final response = await http.get(URL_API["list_semester"]);
    if (response.statusCode == 200) {
      return parseSemester(response.body);
    } else {
      return null;
    }
  }
}

import 'package:time_table_tdtu/API/GetSemester.dart';

import 'Semester.dart';

class CurrentSemester {
  static CurrentSemester _function;
  Semester _semester;

  CurrentSemester getInstance() {
    if (_function == null) {
      _function = new CurrentSemester();
    }
    return _function;
  }

  setPreSemester(List<Semester> _data) {
    //Fix o day
    this._semester =
        _data.firstWhere((element) => element.LaHocKyHienHanh == true);

    // this._semester = _data.firstWhere((element) => element.HocKyID == 106);
  }

  setSemester(Semester semester) {
    this._semester = semester;
  }

  Semester getSemester() {
    print(this._semester);
    return this._semester;
  }

  Semester semesterCurrent(List<Semester> _data) {
    if (this._semester == null) {
      setPreSemester(_data);
    }
    return this._semester;
  }
}

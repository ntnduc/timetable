from prettytable.prettytable import HEADER
from requests.sessions import merge_cookies
from semester import Semester
import requests
import json
from datetime import datetime
from prettytable import PrettyTable
from semester import Semester
from schedule import Schedule
KEY = "b0137f5d2a04529b8f5274bbdbaa194e"[::-1]
URL_API = {
    "list_semester": "http://thoikhoabieudukien.tdtu.edu.vn/API/XemKetQuaDangKy/LoadHocKy",
    "list_schedule": "http://mobiservice.tdt.edu.vn/Service1.svc/LayTKBTHeoHocKyService"
}

username = "518h0609"
password = "Nhatduc447"

def get_all_semesters():
    response = requests.get(url=URL_API["list_semester"])
    semesters = json.loads(response.text)
    semesters = [Semester(id=s['HocKyID'],
                              type=s['HocKy'],
                              year=s['NamHoc'],
                              start=datetime.strptime(s['sNgayBatDau'], '%d/%m/%Y'),
                              end=datetime.strptime(s['sNgayKetThuc'], '%d/%m/%Y')) for s in semesters if s['NamHoc'] >= 2018]
    return semesters

def __prepare_payload(semester, year):
    payload = {
        "Key": KEY,
        "MSSV": username,
        "MatKhau": password,
        "NamHoc": year,
        "HocKy": semester
    }
    return json.dumps(payload)

def get_all_schedules(semester):
    header = {'Content-Type': 'application/json'}
    payload = __prepare_payload(semester.type, semester.year)
    response = requests.post(url=URL_API["list_schedule"], data = payload, headers= header)
    schedules = json.loads(response.text)
    # return list(map(lambda schedule: Schedule(
    #             course_id = schedule['MaMH'],
    #             course_name = schedule['TenMonHoc'],
    #             group = schedule['Nhom'],
    #             subgroup = schedule['ToTH'],
    #             room = schedule['Phong'],
    #             date_of_week = schedule['Thu'],
    #             num_times = schedule['SoTiet'],
    #             begin_time = schedule['TietBatDau'],
    #             weeks = schedule['Tuan'],
    #             semester = semester
    #         ), schedules)) 
    return schedules

semester = get_all_semesters()
semester = semester[5]
# get_all_schedules(semester)
print("semester type: ", semester.type)
print("Semester year: ", semester.year)
data = get_all_schedules(semester)
print(data)

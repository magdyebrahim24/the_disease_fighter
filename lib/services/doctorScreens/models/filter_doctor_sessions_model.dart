class FilterDoctorSessionsModel {
  bool? success;
  List<Sessions>? sessions;
  int? totalSessions;

  FilterDoctorSessionsModel({this.success, this.sessions, this.totalSessions});

  FilterDoctorSessionsModel.fromJson(Map<String, dynamic> json) {
    success = json['Success'];
    if (json['sessions'] != null) {
      sessions = <Sessions>[];
      json['sessions'].forEach((v) {
        sessions!.add(new Sessions.fromJson(v));
      });
    }
    totalSessions = json['total_sessions'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Success'] = this.success;
    if (this.sessions != null) {
      data['sessions'] = this.sessions!.map((v) => v.toJson()).toList();
    }
    data['total_sessions'] = this.totalSessions;
    return data;
  }
}

class Sessions {
  String? amPm;
  String? avatar;
  String? comment;
  String? date;
  String? day;
  String? diagnosis;
  int? doctorId;
  List? files;
  String? gender;
  int? id;
  String? medicines;
  String? name;
  int? patientId;
  String? phone;
  String? time;

  Sessions(
      {this.amPm,
        this.avatar,
        this.comment,
        this.date,
        this.day,
        this.diagnosis,
        this.doctorId,
        this.files,
        this.gender,
        this.id,
        this.medicines,
        this.name,
        this.patientId,
        this.phone,
        this.time});

  Sessions.fromJson(Map<String, dynamic> json) {
    amPm = json['am_pm'];
    avatar = json['avatar'];
    comment = json['comment'];
    date = json['date'];
    day = json['day'];
    diagnosis = json['diagnosis'];
    doctorId = json['doctor_id'];
    if (json['files'] != null) {
      files = <String>[];
      json['files'].forEach((v) {
        files!.add(v.fromJson(v));
      });
    }
    gender = json['gender'];
    id = json['id'];
    medicines = json['medicines'];
    name = json['name'];
    patientId = json['patient_id'];
    phone = json['phone'];
    time = json['time'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['am_pm'] = this.amPm;
    data['avatar'] = this.avatar;
    data['comment'] = this.comment;
    data['date'] = this.date;
    data['day'] = this.day;
    data['diagnosis'] = this.diagnosis;
    data['doctor_id'] = this.doctorId;
    if (this.files != null) {
      data['files'] = this.files!.map((v) => v.toJson()).toList();
    }
    data['gender'] = this.gender;
    data['id'] = this.id;
    data['medicines'] = this.medicines;
    data['name'] = this.name;
    data['patient_id'] = this.patientId;
    data['phone'] = this.phone;
    data['time'] = this.time;
    return data;
  }
}

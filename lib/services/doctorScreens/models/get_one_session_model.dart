class GetOneSessionModel {
  Session? session;
  bool? success;

  GetOneSessionModel({this.session, this.success});

  GetOneSessionModel.fromJson(Map<String, dynamic> json) {
    session =
    json['session'] != null ? new Session.fromJson(json['session']) : null;
    success = json['success'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.session != null) {
      data['session'] = this.session!.toJson();
    }
    data['success'] = this.success;
    return data;
  }
}

class Session {
  String? amPm;
  String? comment;
  String? date;
  String? day;
  Null? diagnosis;
  int? doctorId;
  List? files;
  String? gender;
  int? id;
  Null? medicines;
  String? name;
  String? patientAvatar;
  int? patientId;
  Null? periodId;
  String? phone;
  String? time;

  Session(
      {this.amPm,
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
        this.patientAvatar,
        this.patientId,
        this.periodId,
        this.phone,
        this.time});

  Session.fromJson(Map<String, dynamic> json) {
    amPm = json['am_pm'];
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
    patientAvatar = json['patient_avatar'];
    patientId = json['patient_id'];
    periodId = json['period_id'];
    phone = json['phone'];
    time = json['time'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['am_pm'] = this.amPm;
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
    data['patient_avatar'] = this.patientAvatar;
    data['patient_id'] = this.patientId;
    data['period_id'] = this.periodId;
    data['phone'] = this.phone;
    data['time'] = this.time;
    return data;
  }
}

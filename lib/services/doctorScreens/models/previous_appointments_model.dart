class PreviousAppointmentsModel {
  List<PreviousSessions>? previousSessions;
  bool? success;

  PreviousAppointmentsModel({this.previousSessions, this.success});

  PreviousAppointmentsModel.fromJson(Map<String, dynamic> json) {
    if (json['previous_sessions'] != null) {
      previousSessions = <PreviousSessions>[];
      json['previous_sessions'].forEach((v) {
        previousSessions!.add(new PreviousSessions.fromJson(v));
      });
    }
    success = json['success'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.previousSessions != null) {
      data['previous_sessions'] =
          this.previousSessions!.map((v) => v.toJson()).toList();
    }
    data['success'] = this.success;
    return data;
  }
}

class PreviousSessions {
  String? amPm;
  String? comment;
  String? date;
  String? day;
  String? diagnosis;
  String? doctorAvatar;
  int? doctorId;
  String? doctorName;
  List<String>? files;
  String? gender;
  int? id;
  String? medicines;
  String? name;
  String? patientAvatar;
  int? patientId;
  int? periodId;
  String? phone;
  String? specialization;
  String? time;

  PreviousSessions(
      {this.amPm,
        this.comment,
        this.date,
        this.day,
        this.diagnosis,
        this.doctorAvatar,
        this.doctorId,
        this.doctorName,
        this.files,
        this.gender,
        this.id,
        this.medicines,
        this.name,
        this.patientAvatar,
        this.patientId,
        this.periodId,
        this.phone,
        this.specialization,
        this.time});

  PreviousSessions.fromJson(Map<String, dynamic> json) {
    amPm = json['am_pm'];
    comment = json['comment'];
    date = json['date'];
    day = json['day'];
    diagnosis = json['diagnosis'];
    doctorAvatar = json['doctor_avatar'];
    doctorId = json['doctor_id'];
    doctorName = json['doctor_name'];
    files = json['files'].cast<String>();
    gender = json['gender'];
    id = json['id'];
    medicines = json['medicines'];
    name = json['name'];
    patientAvatar = json['patient_avatar'];
    patientId = json['patient_id'];
    periodId = json['period_id'];
    phone = json['phone'];
    specialization = json['specialization'];
    time = json['time'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['am_pm'] = this.amPm;
    data['comment'] = this.comment;
    data['date'] = this.date;
    data['day'] = this.day;
    data['diagnosis'] = this.diagnosis;
    data['doctor_avatar'] = this.doctorAvatar;
    data['doctor_id'] = this.doctorId;
    data['doctor_name'] = this.doctorName;
    data['files'] = this.files;
    data['gender'] = this.gender;
    data['id'] = this.id;
    data['medicines'] = this.medicines;
    data['name'] = this.name;
    data['patient_avatar'] = this.patientAvatar;
    data['patient_id'] = this.patientId;
    data['period_id'] = this.periodId;
    data['phone'] = this.phone;
    data['specialization'] = this.specialization;
    data['time'] = this.time;
    return data;
  }
}

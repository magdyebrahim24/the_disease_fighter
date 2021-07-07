// class GetOneSessionModel {
//   Session? session;
//   bool? success;
//
//   GetOneSessionModel({this.session, this.success});
//
//   GetOneSessionModel.fromJson(Map<String, dynamic> json) {
//     session =
//         json['session'] != null ? new Session.fromJson(json['session']) : null;
//     success = json['success'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     if (this.session != null) {
//       data['session'] = this.session!.toJson();
//     }
//     data['success'] = this.success;
//     return data;
//   }
// }
//
// class Session {
//   String? amPm;
//   String? comment;
//   String? date;
//   String? day;
//   String? diagnosis;
//   int? doctorId;
//   List? files;
//   String? gender;
//   int? id;
//   String? medicines;
//   String? name;
//   String? patientAvatar;
//   int? patientId;
//   int? periodId;
//   String? phone;
//   String? time;
//
//   Session(
//       {this.amPm,
//       this.comment,
//       this.date,
//       this.day,
//       this.diagnosis,
//       this.doctorId,
//       this.files,
//       this.gender,
//       this.id,
//       this.medicines,
//       this.name,
//       this.patientAvatar,
//       this.patientId,
//       this.periodId,
//       this.phone,
//       this.time});
//
//   Session.fromJson(Map<String, dynamic> json) {
//     amPm = json['am_pm'];
//     comment = json['comment'];
//     date = json['date'];
//     day = json['day'];
//     diagnosis = json['diagnosis'];
//     doctorId = json['doctor_id'];
//     files = json['files'].cast<String>();
//     gender = json['gender'];
//     id = json['id'];
//     medicines = json['medicines'];
//     name = json['name'];
//     patientAvatar = json['patient_avatar'];
//     patientId = json['patient_id'];
//     periodId = json['period_id'];
//     phone = json['phone'];
//     time = json['time'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['am_pm'] = this.amPm;
//     data['comment'] = this.comment;
//     data['date'] = this.date;
//     data['day'] = this.day;
//     data['diagnosis'] = this.diagnosis;
//     data['doctor_id'] = this.doctorId;
//     if (this.files != null) {
//       data['files'] = this.files!.cast<String>();
//     }
//     data['gender'] = this.gender;
//     data['id'] = this.id;
//     data['medicines'] = this.medicines;
//     data['name'] = this.name;
//     data['patient_avatar'] = this.patientAvatar;
//     data['patient_id'] = this.patientId;
//     data['period_id'] = this.periodId;
//     data['phone'] = this.phone;
//     data['time'] = this.time;
//     return data;
//   }
// }

class GetOneSessionModel {
  List<Session>? session;
  bool? success;

  GetOneSessionModel({this.session, this.success});

  GetOneSessionModel.fromJson(Map<String, dynamic> json) {
    if (json['session'] != null) {
      session = <Session>[];
      json['session'].forEach((v) {
        session!.add(new Session.fromJson(v));
      });
    }
    success = json['success'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.session != null) {
      data['session'] = this.session!.map((v) => v.toJson()).toList();
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
  Null diagnosis;
  String? doctorAvatar;
  int? doctorId;
  String? doctorName;
  String? doctorPhone;
  List? files;
  String? gender;
  int? id;
  String? medicines = '';
  String? name;
  String? patientAvatar;
  int? patientId;
  int? periodId;
  String? phone;
  String? specialization;
  String? time;

  Session(
      {this.amPm,
        this.comment,
        this.date,
        this.day,
        this.diagnosis,
        this.doctorAvatar,
        this.doctorId,
        this.doctorName,
        this.doctorPhone,
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

  Session.fromJson(Map<String, dynamic> json) {
    amPm = json['am_pm'];
    comment = json['comment'];
    date = json['date'];
    day = json['day'];
    diagnosis = json['diagnosis'];
    doctorAvatar = json['doctor_avatar'];
    doctorId = json['doctor_id'];
    doctorName = json['doctor_name'];
    doctorPhone = json['doctor_phone'];
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
    data['doctor_phone'] = this.doctorPhone;
    if (this.files != null) {
      data['files'] = this.files!.cast<String>();
    }
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

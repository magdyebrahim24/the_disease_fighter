class MyAppointmentsModel {
  List<FutureAppointments>? futureAppointments;
  List<PreviousAppointments>? previousAppointments;
  bool? success;
  int? totalAppointments;

  MyAppointmentsModel(
      {this.futureAppointments,
      this.previousAppointments,
      this.success,
      this.totalAppointments});

  MyAppointmentsModel.fromJson(Map<String, dynamic> json) {
    if (json['future_appointments'] != null) {
      futureAppointments = <FutureAppointments>[];
      json['future_appointments'].forEach((v) {
        futureAppointments!.add(new FutureAppointments.fromJson(v));
      });
    }
    if (json['previous_appointments'] != null) {
      previousAppointments = <PreviousAppointments>[];
      json['previous_appointments'].forEach((v) {
        previousAppointments!.add(new PreviousAppointments.fromJson(v));
      });
    }
    success = json['success'];
    totalAppointments = json['total_appointments'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.futureAppointments != null) {
      data['future_appointments'] =
          this.futureAppointments!.map((v) => v.toJson()).toList();
    }
    if (this.previousAppointments != null) {
      data['previous_appointments'] =
          this.previousAppointments!.map((v) => v.toJson()).toList();
    }
    data['success'] = this.success;
    data['total_appointments'] = this.totalAppointments;
    return data;
  }
}

class FutureAppointments {
  String? amPm;
  String? comment;
  String? date;
  String? day;
  Null diagnosis;
  String? doctorAvatar;
  int? doctorId;
  String? doctorName;
  List? files;
  String? gender;
  int? id;
  String? medicines = '';
  String? name;
  String? patientAvatar;
  int? patientId;
  int? periodId;
  String? phone;
  String? time;
  String?  docSpecialization;

  FutureAppointments(
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
      this.docSpecialization,
      this.time});

  FutureAppointments.fromJson(Map<String, dynamic> json) {
    amPm = json['am_pm'];
    comment = json['comment'];
    date = json['date'];
    day = json['day'];
    diagnosis = json['diagnosis'];
    doctorAvatar = json['doctor_avatar'];
    doctorId = json['doctor_id'];
    doctorName = json['doctor_name'];
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
    docSpecialization = json['specialization'];

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
    data['specialization'] = this.docSpecialization;

    return data;
  }
}

class PreviousAppointments {
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
  String? time;
  String? docSpecialization;

  PreviousAppointments(
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
      this.docSpecialization,
      this.time});

  PreviousAppointments.fromJson(Map<String, dynamic> json) {
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
    time = json['time'];
    docSpecialization = json['specialization'];

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
    data['time'] = this.time;
    data['specialization'] = this.docSpecialization;

    return data;
  }
}
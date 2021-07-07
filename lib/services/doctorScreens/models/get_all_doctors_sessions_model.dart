class GetAllDoctorsAppointmentsModel {
  List<AllAppointments>? allAppointments;
  List<CurrentAppointments>? currentAppointments;
  List<FutureAppointments>? futureAppointments;
  List<PreviousAppointments>? previousAppointments;
  bool? success;
  int? totalAppointments;

  GetAllDoctorsAppointmentsModel(
      {this.allAppointments,
      this.currentAppointments,
      this.futureAppointments,
      this.previousAppointments,
      this.success,
      this.totalAppointments});

  GetAllDoctorsAppointmentsModel.fromJson(Map<String, dynamic> json) {
    if (json['all_appointments'] != null) {
      allAppointments = <AllAppointments>[];
      json['all_appointments'].forEach((v) {
        allAppointments!.add(new AllAppointments.fromJson(v));
      });
    }
    if (json['current_appointments'] != null) {
      currentAppointments = <CurrentAppointments>[];
      json['current_appointments'].forEach((v) {
        currentAppointments!.add(new CurrentAppointments.fromJson(v));
      });
    }
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
    if (this.allAppointments != null) {
      data['all_appointments'] =
          this.allAppointments!.map((v) => v.toJson()).toList();
    }
    if (this.currentAppointments != null) {
      data['current_appointments'] =
          this.currentAppointments!.map((v) => v.toJson()).toList();
    }
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

class AllAppointments {
  String? amPm;
  String? comment;
  String? date;
  String? day;
  String? diagnosis;
  int? doctorId;
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

  AllAppointments(
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

  AllAppointments.fromJson(Map<String, dynamic> json) {
    amPm = json['am_pm'];
    comment = json['comment'];
    date = json['date'];
    day = json['day'];
    diagnosis = json['diagnosis'];
    doctorId = json['doctor_id'];
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
    data['time'] = this.time;
    return data;
  }
}

class CurrentAppointments {
  String? amPm;
  String? comment;
  String? date;
  String? day;
  String? diagnosis;
  int? doctorId;
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

  CurrentAppointments(
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

  CurrentAppointments.fromJson(Map<String, dynamic> json) {
    amPm = json['am_pm'];
    comment = json['comment'];
    date = json['date'];
    day = json['day'];
    diagnosis = json['diagnosis'];
    doctorId = json['doctor_id'];
    files = json['files'].cast<String>();
    //files = json['files'].cast<String>();
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
    data['time'] = this.time;
    return data;
  }
}

class FutureAppointments {
  String? amPm;
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
  String? patientAvatar;
  int? patientId;
  int? periodId;
  String? phone;
  String? time;

  FutureAppointments(
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

  FutureAppointments.fromJson(Map<String, dynamic> json) {
    amPm = json['am_pm'];
    comment = json['comment'];
    date = json['date'];
    day = json['day'];
    diagnosis = json['diagnosis'];
    doctorId = json['doctor_id'];
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
    data['time'] = this.time;
    return data;
  }
}

class PreviousAppointments {
  String? amPm;
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
  String? patientAvatar;
  int? patientId;
  // ignore: unnecessary_question_mark
  // Null? periodId;
  String? phone;
  String? time;

  PreviousAppointments(
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
      // this.periodId,
      this.phone,
      this.time});

  PreviousAppointments.fromJson(Map<String, dynamic> json) {
    amPm = json['am_pm'];
    comment = json['comment'];
    date = json['date'];
    day = json['day'];
    diagnosis = json['diagnosis'];
    doctorId = json['doctor_id'];
    files = json['files'].cast<String>();
    gender = json['gender'];
    id = json['id'];
    medicines = json['medicines'];
    name = json['name'];
    patientAvatar = json['patient_avatar'];
    patientId = json['patient_id'];
    // periodId = json['period_id'];
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
      data['files'] = this.files!.cast<String>();
    }
    data['gender'] = this.gender;
    data['id'] = this.id;
    data['medicines'] = this.medicines;
    data['name'] = this.name;
    data['patient_avatar'] = this.patientAvatar;
    data['patient_id'] = this.patientId;
    // data['period_id'] = this.periodId;
    data['phone'] = this.phone;
    data['time'] = this.time;
    return data;
  }
}

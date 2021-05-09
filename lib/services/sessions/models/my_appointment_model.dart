// To parse this JSON data, do
//
//     final myAppointmentsModel = myAppointmentsModelFromMap(jsonString);

import 'dart:convert';
class MyAppointmentsModel {
  MyAppointmentsModel({
    this.futureAppointments,
    this.previousAppointments,
    this.success,
    this.totalAppointments,
  });

  List<Appointment>? futureAppointments;
  List<Appointment>? previousAppointments;
  bool? success;
  int? totalAppointments;

  factory MyAppointmentsModel.fromJson(String str) => MyAppointmentsModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory MyAppointmentsModel.fromMap(Map<String, dynamic> json) => MyAppointmentsModel(
    futureAppointments: List<Appointment>.from(json["future_appointments"].map((x) => Appointment.fromMap(x))),
    previousAppointments: List<Appointment>.from(json["previous_appointments"].map((x) => Appointment.fromMap(x))),
    success: json["success"],
    totalAppointments: json["total_appointments"],
  );

  Map<String, dynamic> toMap() => {
    "future_appointments": List<dynamic>.from(futureAppointments!.map((x) => x.toMap())),
    "previous_appointments": List<dynamic>.from(previousAppointments!.map((x) => x.toMap())),
    "success": success,
    "total_appointments": totalAppointments,
  };
}

class Appointment {
  Appointment({
    this.amPm,
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
    this.time,
  });

  String? amPm;
  String? comment;
  DateTime? date;
  String? day;
  String? diagnosis;
  int? doctorId;
  List<String>? files;
  String? gender;
  int? id;
  String? medicines;
  String? name;
  int? patientId;
  String? phone;
  String? time;

  factory Appointment.fromJson(String str) => Appointment.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Appointment.fromMap(Map<String, dynamic> json) => Appointment(
    amPm: json["am_pm"],
    comment: json["comment"],
    date: DateTime.parse(json["date"]),
    day: json["day"],
    diagnosis: json["diagnosis"] == null ? null : json["diagnosis"],
    doctorId: json["doctor_id"],
    files: List<String>.from(json["files"].map((x) => x)),
    gender: json["gender"],
    id: json["id"],
    medicines: json["medicines"] == null ? null : json["medicines"],
    name: json["name"],
    patientId: json["patient_id"],
    phone: json["phone"],
    time: json["time"],
  );

  Map<String, dynamic> toMap() => {
    "am_pm": amPm,
    "comment": comment,
    "date": "${date!.year.toString().padLeft(4, '0')}-${date!.month.toString().padLeft(2, '0')}-${date!.day.toString().padLeft(2, '0')}",
    "day": day,
    "diagnosis": diagnosis == null ? null : diagnosis,
    "doctor_id": doctorId,
    "files": List<dynamic>.from(files!.map((x) => x)),
    "gender": gender,
    "id": id,
    "medicines": medicines == null ? null : medicines,
    "name": name,
    "patient_id": patientId,
    "phone": phone,
    "time": time,
  };
}


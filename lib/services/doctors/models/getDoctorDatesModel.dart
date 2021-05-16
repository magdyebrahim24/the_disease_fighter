class GetDoctorDatesModel {
  List<Dates>? dates;
  bool? success;

  GetDoctorDatesModel({this.dates, this.success});

  GetDoctorDatesModel.fromJson(Map<String, dynamic> json) {
    if (json['dates'] != null) {
      dates = <Dates>[];
      json['dates'].forEach((v) {
        dates!.add(new Dates.fromJson(v));
      });
    }
    success = json['success'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.dates != null) {
      data['dates'] = this.dates!.map((v) => v.toJson()).toList();
    }
    data['success'] = this.success;
    return data;
  }
}

class Dates {
  List<AvailableDates>? availableDates;
  String? day;
  int? doctorId;
  String? endTime;
  int? id;
  String? startTime;

  Dates(
      {this.availableDates,
      this.day,
      this.doctorId,
      this.endTime,
      this.id,
      this.startTime});

  Dates.fromJson(Map<String, dynamic> json) {
    if (json['available_dates'] != null) {
      availableDates = <AvailableDates>[];
      json['available_dates'].forEach((v) {
        availableDates!.add(new AvailableDates.fromJson(v));
      });
    }
    day = json['day'];
    doctorId = json['doctor_id'];
    endTime = json['end_time'];
    id = json['id'];
    startTime = json['start_time'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.availableDates != null) {
      data['available_dates'] =
          this.availableDates!.map((v) => v.toJson()).toList();
    }
    data['day'] = this.day;
    data['doctor_id'] = this.doctorId;
    data['end_time'] = this.endTime;
    data['id'] = this.id;
    data['start_time'] = this.startTime;
    return data;
  }
}

class AvailableDates {
  int? availableDateId;
  int? id;
  bool? isAvailable;
  int? sessionId;
  String? time;

  AvailableDates(
      {this.availableDateId,
      this.id,
      this.isAvailable,
      this.sessionId,
      this.time});

  AvailableDates.fromJson(Map<String, dynamic> json) {
    availableDateId = json['available_date_id'];
    id = json['id'];
    isAvailable = json['is_available'];
    sessionId = json['session_id'];
    time = json['time'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['available_date_id'] = this.availableDateId;
    data['id'] = this.id;
    data['is_available'] = this.isAvailable;
    data['session_id'] = this.sessionId;
    data['time'] = this.time;
    return data;
  }
}

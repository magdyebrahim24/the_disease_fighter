class GetPatientNotificationModel {
  List<Notifications>? notifications;
  bool? success;
  int? totalNotifications;

  GetPatientNotificationModel(
      {this.notifications, this.success, this.totalNotifications});

  GetPatientNotificationModel.fromJson(Map<String, dynamic> json) {
    if (json['notifications'] != null) {
      notifications = <Notifications>[];
      json['notifications'].forEach((v) {
        notifications!.add(new Notifications.fromJson(v));
      });
    }
    success = json['success'];
    totalNotifications = json['total_notifications'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.notifications != null) {
      data['notifications'] =
          this.notifications!.map((v) => v.toJson()).toList();
    }
    data['success'] = this.success;
    data['total_notifications'] = this.totalNotifications;
    return data;
  }
}

class Notifications {
  String? diagnosis;
  String? doctorAvatar;
  String? doctorName;
  String? location;
  bool? seen = false;
  int? sessionId;
  String? specialization;
  String? time;

  Notifications(
      {this.diagnosis,
        this.doctorAvatar,
        this.doctorName,
        this.location,
        this.seen,
        this.sessionId,
        this.specialization,
        this.time});

  Notifications.fromJson(Map<String, dynamic> json) {
    diagnosis = json['diagnosis'];
    doctorAvatar = json['doctor_avatar'];
    doctorName = json['doctor_name'];
    location = json['location'];
    seen = json['seen'];
    sessionId = json['session_id'];
    specialization = json['specialization'];
    time = json['time'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['diagnosis'] = this.diagnosis;
    data['doctor_avatar'] = this.doctorAvatar;
    data['doctor_name'] = this.doctorName;
    data['location'] = this.location;
    data['seen'] = this.seen;
    data['session_id'] = this.sessionId;
    data['specialization'] = this.specialization;
    data['time'] = this.time;
    return data;
  }
}

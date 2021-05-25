class ShowtPatientNotificationModel {
  List<Notifications>? notifications;
  bool? success;
  int? totalNotifications;

  ShowtPatientNotificationModel(
      {this.notifications, this.success, this.totalNotifications});

  ShowtPatientNotificationModel.fromJson(Map<String, dynamic> json) {
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
  String? doctorName;
  bool? seen;
  int? sessionId;
  String? time;

  Notifications({this.doctorName, this.seen, this.sessionId, this.time});

  Notifications.fromJson(Map<String, dynamic> json) {
    doctorName = json['doctor_name'];
    seen = json['seen'];
    sessionId = json['session_id'];
    time = json['time'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['doctor_name'] = this.doctorName;
    data['seen'] = this.seen;
    data['session_id'] = this.sessionId;
    data['time'] = this.time;
    return data;
  }
}

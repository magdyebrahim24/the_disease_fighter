class OneDoctorModel {
  Doctor? doctor;
  bool? success;

  OneDoctorModel({this.doctor, this.success});

  OneDoctorModel.fromJson(Map<String, dynamic> json) {
    doctor =
    json['doctor'] != null ? new Doctor.fromJson(json['doctor']) : null;
    success = json['success'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.doctor != null) {
      data['doctor'] = this.doctor!.toJson();
    }
    data['success'] = this.success;
    return data;
  }
}

class Doctor {
  String? about;
  List<AvailableDates>? availableDates;
  String? avatar;
  String? clinicLocation;
  String? dob;
  String? email;
  String? gender;
  int? id;
  bool? isInFavoriteList;
  String? name;
  String? phone;
  int? specId;
  Specialization? specialization;
  Null xY;

  Doctor(
      {this.about,
        this.availableDates,
        this.avatar,
        this.clinicLocation,
        this.dob,
        this.email,
        this.gender,
        this.id,
        this.isInFavoriteList,
        this.name,
        this.phone,
        this.specId,
        this.specialization,
        this.xY});

  Doctor.fromJson(Map<String, dynamic> json) {
    about = json['about'];
    if (json['available_dates'] != null) {
      availableDates = <AvailableDates>[];
      json['available_dates'].forEach((v) {
        availableDates!.add(new AvailableDates.fromJson(v));
      });
    }
    avatar = json['avatar'];
    clinicLocation = json['clinic_location'];
    dob = json['dob'];
    email = json['email'];
    gender = json['gender'];
    id = json['id'];
    isInFavoriteList = json['is_in_favorite_list'];
    name = json['name'];
    phone = json['phone'];
    specId = json['spec_id'];
    specialization = json['specialization'] != null
        ? new Specialization.fromJson(json['specialization'])
        : null;
    xY = json['x_y'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['about'] = this.about;
    if (this.availableDates != null) {
      data['available_dates'] =
          this.availableDates!.map((v) => v.toJson()).toList();
    }
    data['avatar'] = this.avatar;
    data['clinic_location'] = this.clinicLocation;
    data['dob'] = this.dob;
    data['email'] = this.email;
    data['gender'] = this.gender;
    data['id'] = this.id;
    data['is_in_favorite_list'] = this.isInFavoriteList;
    data['name'] = this.name;
    data['phone'] = this.phone;
    data['spec_id'] = this.specId;
    if (this.specialization != null) {
      data['specialization'] = this.specialization!.toJson();
    }
    data['x_y'] = this.xY;
    return data;
  }
}

class AvailableDates {
  String? day;
  int? doctorId;
  String? endTime;
  int? id;
  String? startTime;

  AvailableDates(
      {this.day, this.doctorId, this.endTime, this.id, this.startTime});

  AvailableDates.fromJson(Map<String, dynamic> json) {
    day = json['day'];
    doctorId = json['doctor_id'];
    endTime = json['end_time'];
    id = json['id'];
    startTime = json['start_time'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['day'] = this.day;
    data['doctor_id'] = this.doctorId;
    data['end_time'] = this.endTime;
    data['id'] = this.id;
    data['start_time'] = this.startTime;
    return data;
  }
}


class Specialization {
  int? id;
  String? image;
  String? name;

  Specialization({this.id, this.image, this.name});

  Specialization.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    image = json['image'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['image'] = this.image;
    data['name'] = this.name;
    return data;
  }
}

class GetAllDoctorsModel {
  List<Doctors>? doctors;
  bool? success;
  int? totalDoctors;

  GetAllDoctorsModel({this.doctors, this.success, this.totalDoctors});

  GetAllDoctorsModel.fromJson(Map<String, dynamic> json) {
    if (json['doctors'] != null) {
      doctors = <Doctors>[];
      json['doctors'].forEach((v) {
        doctors!.add(new Doctors.fromJson(v));
      });
    }
    success = json['success'];
    totalDoctors = json['total_doctors'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.doctors != null) {
      data['doctors'] = this.doctors!.map((v) => v.toJson()).toList();
    }
    data['success'] = this.success;
    data['total_doctors'] = this.totalDoctors;
    return data;
  }
}

class Doctors {
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
  Reviews? reviews;
  int? specId;
  Specialization? specialization;
  Null xY;

  Doctors(
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
      this.reviews,
      this.specId,
      this.specialization,
      this.xY});

  Doctors.fromJson(Map<String, dynamic> json) {
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
    reviews =
        json['reviews'] != null ? new Reviews.fromJson(json['reviews']) : null;
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
    if (this.reviews != null) {
      data['reviews'] = this.reviews!.toJson();
    }
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

class Reviews {
  List<String>? avatars;
  int? noPatients;
  int? rates;

  Reviews({this.avatars, this.noPatients, this.rates});

  Reviews.fromJson(Map<String, dynamic> json) {
    avatars = json['avatars'].cast<String>();
    noPatients = json['no.patients'];
    rates = json['rates'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['avatars'] = this.avatars;
    data['no.patients'] = this.noPatients;
    data['rates'] = this.rates;
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

class TopDoctorsModel {
  bool? success;
  List<Specializations>? specializations;
  List<TopDoctors>? topDoctors;
  int? totalSpecializations;
  int? totalTopDoctors;

  TopDoctorsModel(
      {this.success,
      this.specializations,
      this.topDoctors,
      this.totalSpecializations,
      this.totalTopDoctors});

  TopDoctorsModel.fromJson(Map<String, dynamic> json) {
    success = json['Success'];
    if (json['specializations'] != null) {
      specializations = <Specializations>[];
      json['specializations'].forEach((v) {
        specializations!.add(new Specializations.fromJson(v));
      });
    }
    if (json['top_doctors'] != null) {
      topDoctors = <TopDoctors>[];
      json['top_doctors'].forEach((v) {
        topDoctors!.add(new TopDoctors.fromJson(v));
      });
    }
    totalSpecializations = json['total_specializations'];
    totalTopDoctors = json['total_top_doctors'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Success'] = this.success;
    if (this.specializations != null) {
      data['specializations'] =
          this.specializations!.map((v) => v.toJson()).toList();
    }
    if (this.topDoctors != null) {
      data['top_doctors'] = this.topDoctors!.map((v) => v.toJson()).toList();
    }
    data['total_specializations'] = this.totalSpecializations;
    data['total_top_doctors'] = this.totalTopDoctors;
    return data;
  }
}

class Specializations {
  int? id;
  String? image;
  String? name;

  Specializations({this.id, this.image, this.name});

  Specializations.fromJson(Map<String, dynamic> json) {
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

class TopDoctors {
  String? about;
  List<AvailableDates>? availableDates;
  String? avatar;
  String? clinicLocation;
  String? dob;
  String? email;
  String? gender;
  int? id;
  String? name;
  String? phone;
  Reviews? reviews;
  int? specId;
  List? specialization;

  TopDoctors(
      {this.about,
      this.availableDates,
      this.avatar,
      this.clinicLocation,
      this.dob,
      this.email,
      this.gender,
      this.id,
      this.name,
      this.phone,
      this.reviews,
      this.specId,
      this.specialization});

  TopDoctors.fromJson(Map<String, dynamic> json) {
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
    name = json['name'];
    phone = json['phone'];
    reviews =
        json['reviews'] != null ? new Reviews.fromJson(json['reviews']) : null;
    specId = json['spec_id'];
    if (json['specialization'] != null) {
      specialization = <Specializations>[];
      json['specialization'].forEach((v) {
        specialization!.add(new Specializations.fromJson(v));
      });
    }
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
    data['name'] = this.name;
    data['phone'] = this.phone;
    if (this.reviews != null) {
      data['reviews'] = this.reviews!.toJson();
    }
    data['spec_id'] = this.specId;
    if (this.specialization != null) {
      data['specialization'] =
          this.specialization!.map((v) => v.toJson()).toList();
    }
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

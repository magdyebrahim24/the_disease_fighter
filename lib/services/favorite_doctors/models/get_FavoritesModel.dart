class FavoriteDoctorsModel {
  List<Doctors>? doctors;
  bool? success;

  FavoriteDoctorsModel({this.doctors, this.success});

  FavoriteDoctorsModel.fromJson(Map<String, dynamic> json) {
    if (json['doctors'] != null) {
      doctors = <Doctors>[];
      json['doctors'].forEach((v) {
        doctors!.add(Doctors.fromJson(v));
      });
    }
    success = json['success'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.doctors != null) {
      data['doctors'] = this.doctors!.map((v) => v.toJson()).toList();
    }
    data['success'] = this.success;
    return data;
  }
}

class Doctors {
  String? avatar;
  String? clinicLocation;
  int? id;
  String? name;
  Reviews? reviews;

  Doctors({this.avatar, this.clinicLocation, this.id, this.name, this.reviews});

  Doctors.fromJson(Map<String, dynamic> json) {
    avatar = json['avatar'];
    clinicLocation = json['clinic_location'];
    id = json['id'];
    name = json['name'];
    reviews =
        json['reviews'] != null ? new Reviews.fromJson(json['reviews']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['avatar'] = this.avatar;
    data['clinic_location'] = this.clinicLocation;
    data['id'] = this.id;
    data['name'] = this.name;
    if (this.reviews != null) {
      data['reviews'] = this.reviews!.toJson();
    }
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

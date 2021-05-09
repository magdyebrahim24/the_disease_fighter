import 'dart:convert';
GetAllDoctorsModel getAllDoctorsModelFromJson(String str) => GetAllDoctorsModel.fromJson(json.decode(str));
String getAllDoctorsModelToJson(GetAllDoctorsModel data) => json.encode(data.toJson());

class GetAllDoctorsModel {
  GetAllDoctorsModel({
     this.specializations,
    this.doctors,
    this.success,
     this.totalDoctors,
    this.totalSpecializations,
  });

  List<Specialization> ?specializations;
   List<Doctor>? doctors;
   bool ?success;
  int ?totalDoctors;
  int? totalSpecializations;

  factory GetAllDoctorsModel.fromJson(Map<String, dynamic> json) => GetAllDoctorsModel(
    specializations: List<Specialization>.from(json["Specializations"].map((x) => Specialization.fromJson(x))),
    doctors: List<Doctor>.from(json["doctors"].map((x) => Doctor.fromJson(x))),
    success: json["success"],
    totalDoctors: json["total_doctors"],
    totalSpecializations: json["total_specializations"],
  );

  Map<String, dynamic> toJson() => {
    "Specializations": List<dynamic>.from(specializations!.map((x) => x.toJson())),
    "doctors": List<dynamic>.from(doctors!.map((x) => x.toJson())),
    "success": success,
    "total_doctors": totalDoctors,
    "total_specializations": totalSpecializations,
  };
}

class Doctor {
  Doctor({
     this.about,
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
    this.specialization,
  });

   String ?about;
 List<AvailableDate> ?availableDates;
  String? avatar;
  String ?clinicLocation;
   DateTime? dob;
  String ?email;
    String ?gender;
   int? id;
  String? name;
   String? phone;
   Reviews? reviews;
   int? specId;
   List<Specialization> ?specialization;

  factory Doctor.fromJson(Map<String, dynamic> json) => Doctor(
    about: json["about"],
    availableDates: List<AvailableDate>.from(json["available_dates"].map((x) => AvailableDate.fromJson(x))),
    avatar: json["avatar"],
    clinicLocation: json["clinic_location"],
    dob: DateTime.parse(json["dob"]),
    email: json["email"],
    gender: json["gender"],
    id: json["id"],
    name: json["name"],
    phone: json["phone"],
    reviews: Reviews.fromJson(json["reviews"]),
    specId: json["spec_id"],
    specialization: List<Specialization>.from(json["specialization"].map((x) => Specialization.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "about": about,
    "available_dates": List<dynamic>.from(availableDates!.map((x) => x.toJson())),
    "avatar": avatar,
    "clinic_location": clinicLocation,
    "dob": "${dob!.year.toString().padLeft(4, '0')}-${dob!.month.toString().padLeft(2, '0')}-${dob!.day.toString().padLeft(2, '0')}",
    "email": email,
    "gender": gender,
    "id": id,
    "name": name,
    "phone": phone,
    "reviews": reviews!.toJson(),
    "spec_id": specId,
    "specialization": List<dynamic>.from(specialization!.map((x) => x.toJson())),
  };
}

class AvailableDate {
  AvailableDate({
     this.day,
     this.doctorId,
     this.endTime,
     this.id,
    this.startTime,
  });

  String ?day;
   int ?doctorId;
 String ?endTime;
   int ?id;
  String ?startTime;

  factory AvailableDate.fromJson(Map<String, dynamic> json) => AvailableDate(
    day: json["day"],
    doctorId: json["doctor_id"],
    endTime: json["end_time"],
    id: json["id"],
    startTime: json["start_time"],
  );

  Map<String, dynamic> toJson() => {
    "day": day,
    "doctor_id": doctorId,
    "end_time": endTime,
    "id": id,
    "start_time": startTime,
  };
}
class Reviews {
  Reviews({
     this.avatars,
     this.noPatients,
     this.rates,
  });

   List<String> ?avatars;
  int ?noPatients;
  int ?rates;

  factory Reviews.fromJson(Map<String, dynamic> json) => Reviews(
    avatars: List<String>.from(json["avatars"].map((x) => x)),
    noPatients: json["no.patients"],
    rates: json["rates"],
  );

  Map<String, dynamic> toJson() => {
    "avatars": List<dynamic>.from(avatars!.map((x) => x)),
    "no.patients": noPatients,
    "rates": rates,
  };
}

class Specialization {
  Specialization({
    this.id,
   this.image,
     this.name,
  });

  int ?id;
   String ?image;
  String? name;

  factory Specialization.fromJson(Map<String, dynamic> json) => Specialization(
    id: json["id"],
    image: json["image"],
    name: json["name"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "image": image,
    "name": name,
  };
}

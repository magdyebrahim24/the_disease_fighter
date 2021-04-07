import 'package:flutter/foundation.dart';

class DoctorModel {
  @required
  final id;
  @required
  final doctorName;
  @required
  final email;
  @required
  final phoneNum;
  @required
  final address;
  @required
  final doctorImg;
  @required
  final pecialty;
  @required
  final gender;
  @required
  final rate;
  @required
  final about;

  DoctorModel({
    this.id,
    this.doctorName,
    this.email,
    this.phoneNum,
    this.address,
    this.doctorImg,
    this.pecialty,
    this.gender,
    this.rate,
    this.about,
  });

  factory DoctorModel.fromMap(Map<String, dynamic> map) {
    return DoctorModel(
      id: map['id'],
      doctorName: map['doctor_name'],
      email: map['email'],
      phoneNum: map['phone_num'],
      address: map['address'],
      doctorImg: map['doctor_img'],
      pecialty: map['pecialty'],
      gender: map['gender'],
      rate: map['rate'],
      about: map['about'],
    );
  }

  Map<String, dynamic> toMap() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['doctor_name'] = this.doctorName;
    data['email'] = this.email;
    data['phone_num'] = this.phoneNum;
    data['address'] = this.address;
    data['doctor_img'] = this.doctorImg;
    data['pecialty'] = this.pecialty;
    data['gender'] = this.gender;
    data['rate'] = this.rate;
    data['about'] = this.about;
    return data;
  }
}

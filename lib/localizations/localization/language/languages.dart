import 'package:flutter/material.dart';

abstract class Languages {
  static Languages? of(BuildContext context) {
    return Localizations.of<Languages>(context, Languages);
  }

  Map get setting;

  Map get changePassword;

  String get introSkip;

  List get introInformation;

  Map get signIn;

  Map get forgetPasswordScreen;

  Map get signUp;

  Map get signUpPatientInfo;

  Map get signUpDoctorInfo;

  Map get notificationScreen;

  Map get rateScreen;

  Map get patientHome;

  Map get allClinicsScreen;

  Map get doctorDetails;

  Map get drawer;

  String get search;

  Map get bookAppointment;

  Map get allDoctors;

  Map get patientAppointments;

  Map get previousAppointmentDetails;

  Map get favoriteDoctors;

  Map get aboutScreen;

  Map get termsOfUse;

  Map get patientProfile;

  Map get doctorHome;

  Map get doctorUpcomingMeeting;

  Map get doctorStartMeeting;

  Map get doctorProfile;
}

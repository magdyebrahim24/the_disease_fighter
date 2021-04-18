import 'package:flutter/material.dart';
import 'package:the_disease_fighter/layout/doctor-screens/doctor_home/doctor_home.dart';
import 'package:the_disease_fighter/layout/patient_screens/patient_home/home.dart';
import 'package:the_disease_fighter/layout/sign/sign_in/sign_in.dart';

void main() => runApp(
      MyApp(),
    );

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'The Disease Fighter',
      theme: ThemeData(
        primaryColor: Colors.white,
        fontFamily: 'Rubik',
      ),
      debugShowCheckedModeBanner: false,
      home: Home(),
    );
  }
}


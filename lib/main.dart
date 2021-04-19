import 'package:flutter/material.dart';
import 'package:the_disease_fighter/layout/splash/splash.dart';

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
      home: Splash(),
    );
  }
}


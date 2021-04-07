import 'package:flutter/material.dart';
import 'layout/splash/splash.dart';

void main() => runApp(
      MyApp(),
    );

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'The Medical Solution',
      theme: ThemeData(
        primaryColor: Colors.white,
        fontFamily: 'Rubik',
      ),
      debugShowCheckedModeBanner: false,
      home: Splash(),
    );
  }
}


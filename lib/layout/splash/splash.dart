import 'dart:async';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:the_disease_fighter/layout/doctor-screens/doctor_home/doctor_home.dart';
import 'package:the_disease_fighter/layout/introduction/intro_page.dart';
import 'package:the_disease_fighter/layout/patient_screens/patient_home/home.dart';
import 'package:the_disease_fighter/layout/sign/sign_in/sign_in.dart';

class Splash extends StatefulWidget {
  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<Splash> with TickerProviderStateMixin {
  // AnimationController controller;
  // Animation<double> animation;


  Future checkFirstSeen() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final _intro = (prefs.getBool('intro') ?? false);
    final _isDoctor = (prefs.getBool('isDoctor') ?? false);
    final _token = prefs.getString('access_token') ?? '';

    if (_intro) {
      if(_token != ''){
        if(_isDoctor){
          Navigator.of(context)
              .pushReplacement(MaterialPageRoute(builder: (context) => DoctorHome()));
        }else{
          Navigator.of(context)
              .pushReplacement(MaterialPageRoute(builder: (context) => Home()));
        }
      }else{
        Navigator.of(context)
            .pushReplacement(MaterialPageRoute(builder: (context) => SignIn()));
      }
    } else {
      await prefs.setBool('intro', true);
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => IntroPage()));
    }
  }

  @override
  initState() {
    // controller =
    //     AnimationController(duration: Duration(milliseconds: 400), vsync: this);
    // animation = Tween<double>(begin: 0, end: 300).animate(controller);
    // controller.forward();

    Timer(Duration(seconds: 3), checkFirstSeen);
    super.initState();
  }

  @override
  void dispose() {
    // controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: 65,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage(
                'assets/logo.png',
              ),
              // fit: BoxFit.cover,
            ),
          ),
        ),
      ),
      // body: AnimatedBuilder(
      //   animation: animation,
      //   builder: (BuildContext context, Widget child) {
      //     return Container(
      //       margin: EdgeInsets.only(top: animation.value),
      //       width: MediaQuery.of(context).size.width,
      //       height: 65,
      //       alignment: Alignment.center,
      //       decoration: BoxDecoration(
      //         image: DecorationImage(
      //           image: AssetImage(
      //             'assets/logo.png',
      //           ),
      //           // fit: BoxFit.cover,
      //         ),
      //       ),
      //     );
      //   },
      // ),
    );
  }
}

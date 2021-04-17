import 'dart:async';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:the_disease_fighter/layout/introduction/intro_page.dart';
import 'package:the_disease_fighter/layout/sign/sign_in/sign_in.dart';

class Splash extends StatefulWidget {
  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<Splash> with TickerProviderStateMixin {
  // AnimationController controller;
  // Animation<double> animation;

  // void _getIntroBool() async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   prefs.setBool('intro', false);
  //   bool intro = prefs.getBool('intro');
  //   if (intro != null || intro == true) {
  //     Navigator.pushReplacement(
  //       context,
  //       MaterialPageRoute(
  //         builder: (context) => SignIn(),
  //       ),
  //     );
  //   } else {
  //     Navigator.pushReplacement(
  //       context,
  //       MaterialPageRoute(
  //         builder: (context) => IntroPage(),
  //       ),
  //     );
  //   }
  // }

  Future checkFirstSeen() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool _intro = (prefs.getBool('intro') ?? false);

    if (_intro) {
      Navigator.of(context)
          .pushReplacement(MaterialPageRoute(builder: (context) => SignIn()));
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

    Timer(
        Duration(seconds: 3),
        () => Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => SignIn())));
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

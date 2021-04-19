import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:the_disease_fighter/layout/doctor-screens/doctor_home/doctor_home.dart';
import 'package:the_disease_fighter/layout/patient_screens/patient_home/home.dart';
import 'package:the_disease_fighter/layout/sign/sign-up/sign_up.dart';
import 'package:the_disease_fighter/material/bottons/roundedBtn.dart';
import 'package:the_disease_fighter/material/bottons/socialBtn.dart';
import 'package:the_disease_fighter/material/constants.dart';
import 'package:the_disease_fighter/material/widgets/txt_field.dart';

import 'forget_password/forget_password.dart';

class SignIn extends StatefulWidget {
  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  String email = '';
  String password = '';
  String errorMessage = '';

  _getEmail(String email) {
    setState(() {
      this.email = email.trim();
    });
  }

  _getPassword(String password) {
    setState(() {
      this.password = password.trim();
    });
  }

  onSubmitSignIn() {
    if (email == '' || password == '') {
      setState(() {
        errorMessage = 'Email Or Password are empty';
      });
    } else if (email == 'doctor') {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => DoctorHome(),
        ),
      );
    } else {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => Home(),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Container(
          width: MediaQuery.of(context).size.width,
          color: Color(0xffF4F4F4),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: 10,
              ),
              // logo
              Container(
                margin: EdgeInsets.all(25),
                width: 200,
                height: 70,
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
              Container(
                width: MediaQuery.of(context).size.width,
                padding: EdgeInsets.symmetric(
                    horizontal: MediaQuery.of(context).size.width * .05,
                    vertical: 30),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                      topRight: Radius.circular(50),
                      topLeft: Radius.circular(50)),
                  color: Colors.white,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(top: 25, bottom: 30),
                      child: Text(
                        'Welcome back!',
                        style: TextStyle(fontSize: 32, color: darkBlueColor),
                      ),
                    ),
                    TxtField(
                      labelText: 'Email Address',
                      hintText: 'Enter your email',
                      inputTextFunction: _getEmail,
                      textInputType: TextInputType.emailAddress,
                    ),
                    SizedBox(
                      height: 7,
                    ),
                    TxtField(
                      labelText: 'Password',
                      hintText: 'Enter your password',
                      inputTextFunction: _getPassword,
                      obSecure: true,
                      textInputType: TextInputType.visiblePassword,
                    ),
                    errorMessage != ''
                        ? Text(
                            errorMessage,
                            style: TextStyle(color: Colors.red.withOpacity(.6)),
                          )
                        : SizedBox(),
                    Align(
                      alignment: Alignment.centerRight,
                      child: Padding(
                        padding: EdgeInsets.only(bottom: 30, right: 5),
                        child: InkWell(
                            onTap: () => Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => ForgetPassword(),
                                  ),
                                ),
                            child: Text(
                              'Forgot Password',
                              style: TextStyle(color: subTextColor),
                            )),
                      ),
                    ),
                    RoundedButton(
                      fun: onSubmitSignIn,
                      text: 'Sign In',
                    ),
                    Align(
                      alignment: Alignment.center,
                      child: Padding(
                        padding: EdgeInsets.only(top: 30, bottom: 10),
                        child: InkWell(
                            onTap: () {},
                            child: Text(
                              'Or Sign In With',
                              style: TextStyle(color: subTextColor),
                            )),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SocialButton(
                          onTap: () {},
                          icon: FontAwesomeIcons.google,
                          iconColor: Colors.blue,
                        ),
                        SocialButton(
                          onTap: () {},
                          icon: FontAwesomeIcons.facebookF,
                          iconColor: darkBlueColor.withOpacity(.8),
                        ),
                        SocialButton(
                          onTap: () {},
                          icon: FontAwesomeIcons.twitter,
                          iconColor: primaryColor,
                        ),
                      ],
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 35, bottom: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Don’t have an account ? ',
                            style: TextStyle(color: subTextColor),
                          ),
                          InkWell(
                              onTap: () => Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => SignUp(),
                                  )),
                              child: Text(
                                'SIGN UP',
                                style: TextStyle(
                                    color: darkBlueColor, fontSize: 15),
                              )),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:the_disease_fighter/layout/doctor-screens/doctor_home/doctor_home.dart';
import 'package:the_disease_fighter/layout/patient_screens/patient_home/home.dart';
import 'package:the_disease_fighter/material/inductors/loader_dialog.dart';
import 'package:the_disease_fighter/layout/sign/sign-up/sign_up.dart';
import 'package:the_disease_fighter/material/widgets/materialBanner.dart';
import 'package:the_disease_fighter/services/basicData/controllers/logIn_controller.dart';
import 'package:the_disease_fighter/localizations/localization/language/languages.dart';
import 'package:the_disease_fighter/material/bottons/roundedBtn.dart';
import 'package:the_disease_fighter/material/constants.dart';
import 'package:the_disease_fighter/material/widgets/txt_field.dart';

class SignIn extends StatefulWidget {
  final showLogOutSnackBar;

  SignIn({this.showLogOutSnackBar = false});
  @override
  _SignInState createState() => _SignInState();
}
class _SignInState extends State<SignIn> {
  String? email;
  String? password;
  String errorMessage = '';
  String? _bannerMessage;
  bool _showBanner = false;
  bool _obSecurePassword = true;

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  LoginController _loginController = LoginController();

  Future _userLogin() async {
    _formKey.currentState!.validate();
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      setState(() {
        _showBanner = false;
      });
      LoaderDialog().onLoading(context);
      final data = await _loginController.userLogin(
        email: email,
        password: password,
      );
      if (await data['success'] ?? false) {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        String accessToken = await data['access_token'];
        await prefs.setString('access_token', '$accessToken');
        await prefs.setBool('isDoctor',await data['is_doctor']);
        await prefs.setString('userData',jsonEncode(await data['logged_user']));
        await prefs.setString('userAvatar',await data['logged_user']['avatar']);
        await prefs.setString('userName',await data['logged_user']['name']);

        if (await data['is_doctor'] ?? false) {
          Navigator.pushAndRemoveUntil<dynamic>(
            context,
            MaterialPageRoute(
              builder: (context) => DoctorHome(),
            ),
                (route) => false,
          );
        } else {
          Navigator.pushAndRemoveUntil<dynamic>(
            context,
            MaterialPageRoute(
              builder: (context) => Home(),
            ),
                (route) => false,
          );
        }
      } else if (await data['success'] == false &&
          await data['message'] == 'Fail to sign in , check your internet') {
        setState(() {
          _bannerMessage = data['message'].toString();
          _showBanner = true;
        });
        Navigator.of(context).pop();
      } else {
        setState(() {
          errorMessage = data['message'].toString();
        });
        Navigator.of(context).pop();
      }
    }
  }

  @override
  void initState() {
    widget.showLogOutSnackBar
        ? Future.delayed(Duration.zero, () async {
            snackBarr();
          })
        // ignore: unnecessary_statements
        : null;

    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          Form(
            key: _formKey,
            child: SingleChildScrollView(
              child: Container(
                width: MediaQuery.of(context).size.width,
                color: Color(0xffF4F4F4),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 20,
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
                            horizontal: 20,
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
                                Languages.of(context)!.signIn['welcome'],
                                style: TextStyle(
                                    fontSize: 32, color: darkBlueColor),
                              ),
                            ),
                            TxtField(
                              labelText: Languages.of(context)!.signIn['email'],
                              hintText:
                                  Languages.of(context)!.signIn['emailHint'],
                              inputTextFunction: (String email) {
                                setState(() {
                                  this.email = email.trim();
                                });
                              },
                              textInputType: TextInputType.emailAddress,
                              validatorFun: (value) {
                                if (value.toString().isEmpty) {
                                  return 'Email Required';
                                }
                              },
                            ),
                            SizedBox(
                              height: 7,
                            ),
                            TxtField(
                              labelText:
                                  Languages.of(context)!.signIn['password'],
                              hintText:
                                  Languages.of(context)!.signIn['passwordHint'],
                              inputTextFunction: (String password) {
                                setState(() {
                                  this.password = password.trim();
                                });
                              },
                              obSecure: _obSecurePassword,
                              textInputType: TextInputType.visiblePassword,
                              validatorFun: (value) {
                                if (value.toString().isEmpty) {
                                  return 'Password Required';
                                }
                              },
                              showSuffix: true,
                              showSuffixFun: (){
                                if(_obSecurePassword){
                                  setState(() {
                                    _obSecurePassword = false ;
                                  });
                                }else{
                                  setState(() {
                                    _obSecurePassword = true ;
                                  });
                                }

                              },
                            ),
                            errorMessage != ''
                                ? Text(
                                    errorMessage,
                                    style: TextStyle(
                                        color: Colors.red.withOpacity(.6)),
                                  )
                                : SizedBox(),
                            SizedBox(height: MediaQuery.of(context).size.height * .05,),
                            // Padding(
                            //   padding: EdgeInsets.only(
                            //       bottom: 35, right: 5, left: 5),
                            //   child: Row(
                            //     crossAxisAlignment: CrossAxisAlignment.end,
                            //     mainAxisAlignment: MainAxisAlignment.end,
                            //     children: [
                            //       InkWell(
                            //           onTap: () => Navigator.pushReplacement(
                            //                 context,
                            //                 MaterialPageRoute(
                            //                   builder: (context) =>
                            //                       ForgetPassword(),
                            //                 ),
                            //               ),
                            //           child: Text(
                            //             Languages.of(context)!
                            //                 .signIn['forgetPassword'],
                            //             style: TextStyle(color: subTextColor),
                            //           )),
                            //     ],
                            //   ),
                            // ),
                            RoundedButton(
                              fun: () => _userLogin(),
                              text: Languages.of(context)!
                                  .signIn['signButtonTxt'],
                            ),
                            // Row(
                            //   crossAxisAlignment: CrossAxisAlignment.center,
                            //   mainAxisAlignment: MainAxisAlignment.center,
                            //   children: [
                            //     Padding(
                            //       padding: EdgeInsets.only(top: 30, bottom: 10),
                            //       child: Text(
                            //         Languages.of(context)!.signIn['orSignWith'],
                            //         style: TextStyle(color: subTextColor),
                            //       ),
                            //     ),
                            //   ],
                            // ),
                            // Row(
                            //   mainAxisAlignment: MainAxisAlignment.center,
                            //   children: [
                            //     SocialButton(
                            //       onTap: () {},
                            //       icon: FontAwesomeIcons.google,
                            //       iconColor: Colors.blue,
                            //     ),
                            //     SocialButton(
                            //       onTap: () {},
                            //       icon: FontAwesomeIcons.facebookF,
                            //       iconColor: darkBlueColor.withOpacity(.8),
                            //     ),
                            //     SocialButton(
                            //       onTap: () {},
                            //       icon: FontAwesomeIcons.twitter,
                            //       iconColor: primaryColor,
                            //     ),
                            //   ],
                            // ),
                            Padding(
                              padding: EdgeInsets.only(top: MediaQuery.of(context).size.height * .1, bottom: 10),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    Languages.of(context)!
                                        .signIn['dontHaveAccount'],
                                    style: TextStyle(color: subTextColor),
                                  ),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  InkWell(
                                      onTap: () => Navigator.pushReplacement(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) => SignUp(),
                                          )),
                                      child: Text(
                                        Languages.of(context)!
                                            .signIn['signUpTxt'],
                                        style: TextStyle(
                                            color: darkBlueColor, fontSize: 15),
                                      )),
                                ],
                              ),
                            )
                          ],
                        )),
                  ],
                ),
              ),
            ),
          ),
          _showBanner
              ? SizedBox(
                  height: 135,
                  child: ErrorMaterialBanner(
                    errorMessage: _bannerMessage.toString(),
                    fun: () {
                      setState(() {
                        _showBanner = false;
                      });
                    },
                  ),
                )
              : SizedBox(),
        ],
      ),
    );
  }


  snackBarr() {
    final snackBar = SnackBar(
      content: Row(
        children: [
          Icon(
            Icons.check_circle,
            color: Colors.white,
          ),
          SizedBox(
            width: 10,
          ),
          Text(
            Languages.of(context)!.signIn['loggedOutSuccess'],
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
        ],
      ),
      backgroundColor: primaryColor,
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
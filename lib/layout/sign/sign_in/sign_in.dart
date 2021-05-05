import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:the_disease_fighter/layout/doctor-screens/doctor_home/doctor_home.dart';
import 'package:the_disease_fighter/layout/patient_screens/patient_home/home.dart';
import 'package:the_disease_fighter/material/inductors/loader_dialog.dart';
import 'package:the_disease_fighter/services/basicData/controllers/logOutController.dart';
import 'package:the_disease_fighter/layout/sign/sign-up/sign_up.dart';
import 'package:the_disease_fighter/services/basicData/controllers/logIn_controller.dart';
import 'package:the_disease_fighter/localizations/localization/language/languages.dart';
import 'package:the_disease_fighter/material/bottons/roundedBtn.dart';
import 'package:the_disease_fighter/material/bottons/socialBtn.dart';
import 'package:the_disease_fighter/material/constants.dart';
import 'package:the_disease_fighter/material/widgets/txt_field.dart';
import '../../../services/logged_user/get_user_info_controller.dart';
import 'forget_password/forget_password.dart';

class SignIn extends StatefulWidget {
  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  late String email;
  late String password;
  String errorMessage = '';

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  LoginController _loginController = LoginController();

  LogOutController _logOut = LogOutController();

  Future _userLogin() async {
    _formKey.currentState!.validate();
    _formKey.currentState!.save();

    if (_formKey.currentState!.validate()) {
      LoaderDialog().onLoading(context);
      final data = await _loginController.userLogin(
        email: email,
        password: password,
      );
      if (await data['success'] ?? false) {
        if (await data['is_doctor'] ?? false) {
          Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => DoctorHome(),
              ));
        } else {
          Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => Home(),
              ));
        }
      } else {
        setState(() {
          errorMessage = data['message'].toString();
        });
        Navigator.of(context).pop();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
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
                            Languages.of(context)!.signIn['welcome'],
                            style:
                                TextStyle(fontSize: 32, color: darkBlueColor),
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
                              obSecure: true,
                              textInputType: TextInputType.visiblePassword,
                              validatorFun: (value) {
                                if (value.toString().isEmpty) {
                                  return 'Password Required';
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
                            Padding(
                              padding: EdgeInsets.only(
                                  bottom: 35, right: 5, left: 5),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  InkWell(
                                      onTap: () => Navigator.pushReplacement(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  ForgetPassword(),
                                            ),
                                          ),
                                      child: Text(
                                        Languages.of(context)!
                                            .signIn['forgetPassword'],
                                        style: TextStyle(color: subTextColor),
                                      )),
                                ],
                              ),
                            ),
                            RoundedButton(
                              fun: () => _userLogin(),
                              text: Languages.of(context)!
                                  .signIn['signButtonTxt'],
                            ),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Padding(
                                  padding: EdgeInsets.only(top: 30, bottom: 10),
                                  child: Text(
                                    Languages.of(context)!.signIn['orSignWith'],
                                    style: TextStyle(color: subTextColor),
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SocialButton(
                                  onTap: () {
                                    _logOut.userLogOut();
                                  },
                                  icon: FontAwesomeIcons.google,
                                  iconColor: Colors.blue,
                                ),
                                SocialButton(
                                  onTap: () {
                                    _loginController.userLogin(
                                        email: email, password: password);
                                  },
                                  icon: FontAwesomeIcons.facebookF,
                                  iconColor: darkBlueColor.withOpacity(.8),
                                ),
                                SocialButton(
                                  onTap: () {
                                  },
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
    );
  }

  Future setToken(token) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('access_token', token);
  }

  Future getToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('access_token');
  }
}

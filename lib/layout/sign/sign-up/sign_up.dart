import 'package:flutter/material.dart';
import 'package:the_disease_fighter/layout/sign/sign_in/sign_in.dart';
import 'package:the_disease_fighter/localizations/localization/language/languages.dart';
import 'package:the_disease_fighter/material/bottons/roundedBtn.dart';
import 'package:the_disease_fighter/material/constants.dart';
import 'package:the_disease_fighter/material/inductors/loader_dialog.dart';
import 'package:the_disease_fighter/material/widgets/materialBanner.dart';
import 'package:the_disease_fighter/material/widgets/txt_field.dart';
import 'package:the_disease_fighter/services/basicData/controllers/verify_email.dart';
import 'additional-info/doctor-info.dart';
import 'additional-info/patient-info.dart';

class SignUp extends StatefulWidget {
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  String name = '';
  String email = '';
  String password = '';

  String confirmPassword = '';
  String errorMessage = '';
  String? _bannerMessage;
  bool isDoctor = false;
  bool _showBanner = false;
  bool _obSecurePassword = true;
  bool _obSecureConfirmPassword = true;

  VerifyEmailController _verifyEmailController = VerifyEmailController();
  Future _onSubmitSignUp() async {
    _formKey.currentState!.validate();
    _formKey.currentState!.save();

    if (_formKey.currentState!.validate()) {
      LoaderDialog().onLoading(context);
      final data = await _verifyEmailController.verifyEmail(
        name: name,
        email: email,
        password: password,
      );
      if (await data['success'] == true ) {
        if (isDoctor) {
          Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => DoctorInfo(email: email,isDoctor: isDoctor,password: password,name: name),
              ));
        } else {
          Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => PatientInfo(email: email,isDoctor: isDoctor,password: password,name: name,),
              ));
        }
      }else if (await data['success'] == false &&
          await data['message'] == 'Fail to sign up , check your internet') {
        Navigator.of(context).pop();
        setState(() {
          _bannerMessage = data['message'].toString();
          _showBanner = true;
          errorMessage = '';
        });
      } else {
        setState(() {
          errorMessage = data['message'].toString();
        });
        Navigator.of(context).pop();
      }
    }
  }

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                            horizontal: MediaQuery.of(context).size.width * .05,
                            vertical: 20),
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
                            SizedBox(
                              height: 30,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                MaterialButton(
                                  color:
                                      !isDoctor ? primaryColor : Colors.white,
                                  minWidth:
                                      MediaQuery.of(context).size.width * .43,
                                  height: 50,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10.0),
                                      side: BorderSide(
                                          color: !isDoctor
                                              ? primaryColor
                                              : subTextColor)),
                                  onPressed: () {
                                    setState(() {
                                      isDoctor = false;
                                    });
                                    print(isDoctor);
                                  },
                                  child: Row(
                                    children: [
                                      isDoctor
                                          ? Image.asset(
                                              'assets/icons/patientGrey.png',
                                              width: 20)
                                          : Image.asset(
                                              'assets/icons/patientWhite.png',
                                              width: 20),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      Text(
                                        Languages.of(context)!
                                            .signUp['patientBTN'],
                                        style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                            color: !isDoctor
                                                ? Colors.white
                                                : subTextColor),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                MaterialButton(
                                  color: isDoctor ? primaryColor : Colors.white,
                                  minWidth:
                                      MediaQuery.of(context).size.width * .43,
                                  height: 50,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10.0),
                                      side: BorderSide(
                                          color: isDoctor
                                              ? primaryColor
                                              : subTextColor)),
                                  onPressed: () {
                                    setState(() {
                                      isDoctor = true;
                                    });
                                    print(isDoctor);
                                  },
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      isDoctor
                                          ? Image.asset(
                                              'assets/icons/doctorWhite.png',
                                              width: 20)
                                          : Image.asset(
                                              'assets/icons/doctorGrey.png',
                                              width: 20),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      Text(
                                        Languages.of(context)!
                                            .signUp['doctorBTN'],
                                        style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                            color: isDoctor
                                                ? Colors.white
                                                : subTextColor),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            TxtField(
                              labelText: Languages.of(context)!.signUp['name'],
                              hintText:
                                  Languages.of(context)!.signUp['nameHint'],
                              inputTextFunction: (String name) {
                                setState(() {
                                  this.name = name;
                                });
                              },
                              textInputType: TextInputType.text,
                              validatorFun: (value) {
                                if (value.toString().isEmpty) {
                                  return 'Name Required';
                                }
                              },
                            ),
                            TxtField(
                              labelText: Languages.of(context)!.signUp['email'],
                              hintText:
                                  Languages.of(context)!.signUp['emailHint'],
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
                            TxtField(
                              labelText:
                                  Languages.of(context)!.signUp['password'],
                              hintText:
                                  Languages.of(context)!.signUp['passwordHint'],
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
                                } else {
                                  if (value != confirmPassword) {
                                    return 'Passwords Isn\'t Identical';
                                  }
                                  if (value.length < 8) {
                                    return 'Password Length Must Be More Than 9 Digit';
                                  }
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
                            TxtField(
                              labelText: Languages.of(context)!
                                  .signUp['confirmPassword'],
                              hintText: Languages.of(context)!
                                  .signUp['confirmPasswordHint'],
                              inputTextFunction: (String confirmPassword) {
                                setState(() {
                                  this.confirmPassword = confirmPassword.trim();
                                });
                              },
                              obSecure: _obSecureConfirmPassword,
                              textInputType: TextInputType.visiblePassword,
                              validatorFun: (value) {
                                if (value.toString().isEmpty) {
                                  return 'confirm password required';
                                } else {
                                  if (value != password) {
                                    return 'Passwords Isn\'t Identical';
                                  }
                                  if (value.length < 8) {
                                    return 'Password Length Must Be More Than 9 Digit';
                                  }
                                }
                              },
                              showSuffix: true,
                              showSuffixFun: (){
                                if(_obSecureConfirmPassword){
                                  setState(() {
                                    _obSecureConfirmPassword = false ;
                                  });
                                }else{
                                  setState(() {
                                    _obSecureConfirmPassword = true ;
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
                            SizedBox(
                              height: 10,
                            ),
                            RoundedButton(
                              fun: _onSubmitSignUp,
                              text: Languages.of(context)!
                                  .signUp['signButtonTxt'],
                            ),
                            // Row(
                            //   mainAxisAlignment: MainAxisAlignment.center,
                            //   crossAxisAlignment: CrossAxisAlignment.center,
                            //   children: [
                            //     Padding(
                            //       padding: EdgeInsets.only(top: 30, bottom: 10),
                            //       child: InkWell(
                            //           onTap: () {},
                            //           child: Text(
                            //             Languages.of(context)!
                            //                 .signUp['orSignWith'],
                            //             style: TextStyle(color: subTextColor),
                            //           )),
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
                              padding: EdgeInsets.only(top: 40, bottom: 20),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    Languages.of(context)!
                                        .signUp['dontHaveAccount'],
                                    style: TextStyle(color: subTextColor),
                                  ),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  InkWell(
                                      onTap: () => Navigator.pushReplacement(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) => SignIn(),
                                          )),
                                      child: Text(
                                        Languages.of(context)!
                                            .signUp['signUpTxt'],
                                        style: TextStyle(color: darkBlueColor),
                                      )),
                                ],
                              ),
                            ),
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
}
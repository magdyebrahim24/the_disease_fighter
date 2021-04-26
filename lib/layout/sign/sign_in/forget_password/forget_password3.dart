import 'package:flutter/material.dart';
import 'package:the_disease_fighter/layout/patient_screens/patient_home/home.dart';
import 'package:the_disease_fighter/localizations/localization/language/languages.dart';
import 'package:the_disease_fighter/material/bottons/roundedBtn.dart';
import 'package:the_disease_fighter/material/constants.dart';
import 'package:the_disease_fighter/material/widgets/txt_field.dart';

class ForgetPassword3 extends StatefulWidget {
  @override
  _ForgetPassword3State createState() => _ForgetPassword3State();
}

class _ForgetPassword3State extends State<ForgetPassword3> {
  String password = '';
  String confirmPassword = '';

  _getCode(String password) {
    setState(() {
      this.password = password;
    });
  }

  _getConfirmPassword(String confirmPassword) {
    setState(() {
      this.confirmPassword = confirmPassword;
    });
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
            mainAxisSize: MainAxisSize.max,
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
                height: MediaQuery.of(context).size.height - 130,
                width: MediaQuery.of(context).size.width,
                padding: EdgeInsets.symmetric(
                    horizontal: MediaQuery.of(context).size.width * .05,
                    vertical: 30),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                      topRight: Radius.circular(40),
                      topLeft: Radius.circular(40)),
                  color: Colors.white,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 10),
                      child: Text(
                        Languages.of(context)!.forgetPasswordScreen['header'],
                        style: TextStyle(
                          color: darkBlueColor,
                          fontSize: 28,
                        ),
                      ),
                    ),
                    Text(
                      Languages.of(context)!
                          .forgetPasswordScreen['newPassHint'],
                      style: TextStyle(
                        color: darkBlueColor,
                        fontSize: 20,
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Column(
                      children: [
                        TxtField(
                          labelText: Languages.of(context)!
                              .forgetPasswordScreen['passwordLabel'],
                          hintText: Languages.of(context)!
                              .forgetPasswordScreen['passwordHint'],
                          inputTextFunction: _getCode,
                          textInputType: TextInputType.visiblePassword,
                        ),
                        TxtField(
                          labelText: Languages.of(context)!
                              .forgetPasswordScreen['confirmPassword'],
                          hintText: Languages.of(context)!
                              .forgetPasswordScreen['confirmPasswordHint'],
                          inputTextFunction: _getConfirmPassword,
                          textInputType: TextInputType.visiblePassword,
                        ),
                      ],
                    ),
                    RoundedButton(
                      fun: () => Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => Home(),
                        ),
                      ),
                      text: Languages.of(context)!
                          .forgetPasswordScreen['changeBTN'],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        for (int i = 1; i <= 3; i++)
                          Container(
                            margin: EdgeInsets.all(10),
                            height: 10,
                            width: 10,
                            decoration: BoxDecoration(
                                color: i == 3 ? primaryColor : Colors.white,
                                shape: BoxShape.circle,
                                border: Border.all(color: primaryColor)),
                          ),
                      ],
                    ),
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

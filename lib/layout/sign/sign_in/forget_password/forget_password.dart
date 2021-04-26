import 'package:flutter/material.dart';
import 'package:the_disease_fighter/layout/sign/sign-up/sign_up.dart';
import 'package:the_disease_fighter/localizations/localization/language/languages.dart';
import 'package:the_disease_fighter/material/bottons/circleBtn.dart';
import 'package:the_disease_fighter/material/bottons/roundedBtn.dart';
import 'package:the_disease_fighter/material/constants.dart';
import 'package:the_disease_fighter/material/widgets/txt_field.dart';

import 'forget_password2.dart';

class ForgetPassword extends StatefulWidget {
  @override
  _ForgetPasswordState createState() => _ForgetPasswordState();
}

class _ForgetPasswordState extends State<ForgetPassword> {
  String email = '';

  _getEmail(String email) {
    setState(() {
      this.email = email.trim();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.transparent,
        leading: CircleButton(
          fun: () => Navigator.pop(context),
          color: darkBlueColor,
          icn: Icons.arrow_back,
        ),
      ),
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
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(vertical: 15),
                          child: Text(
                            Languages.of(context)!
                                .forgetPasswordScreen['header'],
                            style: TextStyle(
                              color: darkBlueColor,
                              fontSize: 28,
                            ),
                          ),
                        ),
                        Text(
                          Languages.of(context)!
                              .forgetPasswordScreen['emailSubTxt'],
                          style: TextStyle(
                            color: darkBlueColor,
                            fontSize: 20,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    TxtField(
                      labelText: Languages.of(context)!
                          .forgetPasswordScreen['emailLabel'],
                      hintText: Languages.of(context)!
                          .forgetPasswordScreen['emailHint'],
                      inputTextFunction: _getEmail,
                      textInputType: TextInputType.emailAddress,
                    ),
                    RoundedButton(
                      fun: () => Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ForgetPassword2(),
                        ),
                      ),
                      text: Languages.of(context)!
                          .forgetPasswordScreen['nextBTN'],
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
                                color: i == 1 ? primaryColor : Colors.white,
                                shape: BoxShape.circle,
                                border: Border.all(color: primaryColor)),
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
                                .forgetPasswordScreen['dontHaveAccount'],
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
                                    .forgetPasswordScreen['signUpTxt'],
                                style: TextStyle(
                                    color: darkBlueColor, fontSize: 15),
                              )),
                        ],
                      ),
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

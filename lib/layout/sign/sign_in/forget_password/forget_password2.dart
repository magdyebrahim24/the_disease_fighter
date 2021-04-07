import 'package:flutter/material.dart';
import 'package:the_disease_fighter/layout/sign/sign-up/sign_up.dart';
import 'package:the_disease_fighter/material/bottons/roundedBtn.dart';
import 'package:the_disease_fighter/material/constants.dart';
import 'package:the_disease_fighter/material/widgets/txt_field.dart';

import 'forget_password3.dart';

class ForgetPassword2 extends StatefulWidget {
  @override
  _ForgetPassword2State createState() => _ForgetPassword2State();
}

class _ForgetPassword2State extends State<ForgetPassword2> {
  String code = '';

  _getCode(String email) {
    setState(() {
      this.code = email.trim();
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
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(vertical: 15),
                          child: Text(
                            'Forgot password ?',
                            style: TextStyle(
                              color: darkBlueColor,
                              fontSize: 28,
                            ),
                          ),
                        ),
                        Text(
                          'Enter The Code that you recieved \nit in email.',
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
                      labelText: 'Code',
                      hintText: 'Enter Code',
                      inputTextFunction: _getCode,
                      textInputType: TextInputType.emailAddress,
                    ),
                    RoundedButton(
                      fun: () => Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ForgetPassword3(),
                        ),
                      ),
                      text: 'Verify',
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
                                color: i == 2 ? primaryColor : Colors.white,
                                shape: BoxShape.circle,
                                border: Border.all(color: primaryColor)),
                          ),
                      ],
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 5, bottom: 10),
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

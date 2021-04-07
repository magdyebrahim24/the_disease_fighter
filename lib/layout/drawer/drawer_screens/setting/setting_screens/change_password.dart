import 'package:flutter/material.dart';
import 'package:the_disease_fighter/material/bottons/circleBtn.dart';
import 'package:the_disease_fighter/material/bottons/roundedBtn.dart';
import 'package:the_disease_fighter/material/constants.dart';
import 'package:the_disease_fighter/material/widgets/patient-logo.dart';
import 'package:the_disease_fighter/material/widgets/txt_field.dart';

class ChangePassword extends StatefulWidget {
  @override
  _ChangePasswordState createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {
  String oldPassword = '';
  String newPassword = '';
  String confirmPassword = '';

  _getPassword(String password) {
    setState(() {
      this.oldPassword = password.trim();
    });
  }

  _getNewPassword(String newPassword) {
    setState(() {
      this.newPassword = newPassword.trim();
    });
  }

  _getConfirmPassword(String confirmPassword) {
    setState(() {
      this.confirmPassword = confirmPassword.trim();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        leading: CircleButton(
          fun: () => Navigator.pop(context),
          color: darkBlueColor,
          icn: Icons.arrow_back,
        ),
      ),
      body: SingleChildScrollView(
          child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 40),
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              PatientLogo(
                imgHigh: 140.0,
                imgWidth: 140.0,
                nameColor: darkBlueColor,
                nameSize: 23.0,
              ),
              SizedBox(
                height: 25,
              ),
              TxtField(
                labelText: 'Old password',
                hintText: 'write old password',
                textInputType: TextInputType.visiblePassword,
                obSecure: true,
                inputTextFunction: _getPassword,
              ),
              TxtField(
                labelText: 'New password',
                hintText: 'write New password',
                textInputType: TextInputType.visiblePassword,
                obSecure: true,
                inputTextFunction: _getNewPassword,
              ),
              TxtField(
                labelText: 'Confirm password',
                hintText: 'write confirm password',
                textInputType: TextInputType.visiblePassword,
                obSecure: true,
                inputTextFunction: _getConfirmPassword,
              ),
              SizedBox(
                height: 15,
              ),
              RoundedButton(
                fun: () => Navigator.pop(context),
                minWdthRatio: 1,
                text: 'Done',
              ),
            ]),
      )),
    );
  }
}

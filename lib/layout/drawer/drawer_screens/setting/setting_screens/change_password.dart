import 'package:flutter/material.dart';
import 'package:the_disease_fighter/layout/drawer/drawer_screens/setting/settings.dart';
import 'package:the_disease_fighter/localizations/localization/language/languages.dart';
import 'package:the_disease_fighter/material/bottons/circleBtn.dart';
import 'package:the_disease_fighter/material/bottons/roundedBtn.dart';
import 'package:the_disease_fighter/material/constants.dart';
import 'package:the_disease_fighter/material/inductors/loader_dialog.dart';
import 'package:the_disease_fighter/material/widgets/patient-logo.dart';
import 'package:the_disease_fighter/material/widgets/txt_field.dart';
import 'package:the_disease_fighter/services/basicData/controllers/change_password_controller.dart';

class ChangePassword extends StatefulWidget {
  @override
  _ChangePasswordState createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {
  String oldPassword = '';
  String newPassword = '';
  String confirmPassword = '';

  ChangePasswordController _changePasswordController =
      ChangePasswordController();
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String errorMessage = '';

  Future _changePasswordBtn() async {
    _formKey.currentState!.validate();

    if (_formKey.currentState!.validate()) {
      LoaderDialog().onLoading(context);

      final data = await _changePasswordController.changePassword(
        currentPassword: oldPassword,
        newPassword: newPassword,
      );
      if (await data['success']) {
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => Setting(
                showSnackBar: true,
              ),
            ));
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
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
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
                  labelText:
                      Languages.of(context)!.changePassword['oldPasswordLabel'],
                  hintText:
                      Languages.of(context)!.changePassword['oldPasswordHint'],
                  textInputType: TextInputType.visiblePassword,
                  obSecure: true,
                  inputTextFunction: (String password) {
                    setState(() {
                      this.oldPassword = password.trim();
                    });
                  },
                  validatorFun: (value) {
                    if (value.toString().isEmpty) {
                      return 'Old Password Required';
                    }
                  },
                ),
                TxtField(
                  labelText:
                      Languages.of(context)!.changePassword['newPasswordLabel'],
                  hintText:
                      Languages.of(context)!.changePassword['newPasswordHint'],
                  textInputType: TextInputType.visiblePassword,
                  obSecure: true,
                  inputTextFunction: (String newPassword) {
                    setState(() {
                      this.newPassword = newPassword.trim();
                    });
                  },
                  validatorFun: (value) {
                    if (value.toString().isEmpty) {
                      return 'New Password Required';
                    } else {
                      if (value != confirmPassword) {
                        return 'Passwords Isn\'t Identical';
                      }
                      if (value.length < 8) {
                        return 'Password Length Must Be More Than 9 Digit';
                      }
                    }
                  },
                ),
                TxtField(
                  labelText: Languages.of(context)!
                      .changePassword['confirmPasswordLabel'],
                  hintText: Languages.of(context)!
                      .changePassword['ConfirmPasswordHint'],
                  textInputType: TextInputType.visiblePassword,
                  obSecure: true,
                  inputTextFunction: (String confirmPassword) {
                    setState(() {
                      this.confirmPassword = confirmPassword.trim();
                    });
                  },
                  validatorFun: (value) {
                    if (value.toString().isEmpty) {
                      return 'Confirm Password Required';
                    } else {
                      if (value != confirmPassword) {
                        return 'Passwords Isn\'t Identical';
                      }
                      if (value.length < 8) {
                        return 'Password Length Must Be More Than 9 Digit';
                      }
                    }
                  },
                ),
                errorMessage != ''
                    ? Text(
                        errorMessage,
                        style: TextStyle(color: Colors.red.withOpacity(.6)),
                      )
                    : SizedBox(),
                SizedBox(
                  height: 15,
                ),
                RoundedButton(
                  fun: _changePasswordBtn,
                  minWdthRatio: 1,
                  text: Languages.of(context)!.changePassword['doneBtn'],
                ),
              ]),
        )),
      ),
    );
  }
}

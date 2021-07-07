import 'package:flutter/material.dart';
import 'package:the_disease_fighter/layout/setting/settings.dart';
import 'package:the_disease_fighter/localizations/localization/language/languages.dart';
import 'package:the_disease_fighter/material/bottons/circleBtn.dart';
import 'package:the_disease_fighter/material/bottons/roundedBtn.dart';
import 'package:the_disease_fighter/material/constants.dart';
import 'package:the_disease_fighter/material/inductors/loader_dialog.dart';
import 'package:the_disease_fighter/material/widgets/materialBanner.dart';
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
  String errorMessage = '';
  String? _bannerMessage;
  bool _showBanner = false;
  bool _obSecureOldPassword = true;
  bool _obSecureConfirmPassword = true;
  bool _obSecureNewPassword=true;

  ChangePasswordController _changePasswordController =
      ChangePasswordController();
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  Future _changePasswordBtn() async {
    _formKey.currentState!.validate();
    setState(() {
      _showBanner = false;
    });

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
      } else if (await data['success'] == false &&
          await data['message'] ==
              'Fail to Change Password , check your internet ') {
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
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Scaffold(
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
                      imgHigh: 135.0,
                      imgWidth: 135.0,
                      nameColor: darkBlueColor.withOpacity(.8),
                      nameSize: 22.0,
                    ),
                    SizedBox(
                      height: 25,
                    ),
                    TxtField(
                      labelText: Languages.of(context)!
                          .changePassword['oldPasswordLabel'],
                      hintText: Languages.of(context)!
                          .changePassword['oldPasswordHint'],
                      textInputType: TextInputType.visiblePassword,
                      obSecure: _obSecureOldPassword,
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
                      showSuffix: true,
                      showSuffixFun: (){
                        if(_obSecureOldPassword){
                          setState(() {
                            _obSecureOldPassword = false ;
                          });
                        }else{
                          setState(() {
                            _obSecureOldPassword = true ;
                          });
                        }

                      },
                    ),
                    TxtField(
                      labelText: Languages.of(context)!
                          .changePassword['newPasswordLabel'],
                      hintText: Languages.of(context)!
                          .changePassword['newPasswordHint'],
                      textInputType: TextInputType.visiblePassword,
                      obSecure: _obSecureNewPassword,
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
                      showSuffix: true,
                      showSuffixFun: (){
                        if(_obSecureNewPassword){
                          setState(() {
                            _obSecureNewPassword = false ;
                          });
                        }else{
                          setState(() {
                            _obSecureNewPassword = true ;
                          });
                        }

                      },
                    ),
                    TxtField(
                      labelText: Languages.of(context)!
                          .changePassword['confirmPasswordLabel'],
                      hintText: Languages.of(context)!
                          .changePassword['ConfirmPasswordHint'],
                      textInputType: TextInputType.visiblePassword,
                      obSecure: _obSecureConfirmPassword,
                      inputTextFunction: (String confirmPassword) {
                        setState(() {
                          this.confirmPassword = confirmPassword.trim();
                        });
                      },
                      validatorFun: (value) {
                        if (value.toString().isEmpty) {
                          return 'Confirm Password Required';
                        } else {
                          if (value != newPassword) {
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
        ),
        _showBanner
            ? SizedBox(
                height: 150,
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
    );
  }
}
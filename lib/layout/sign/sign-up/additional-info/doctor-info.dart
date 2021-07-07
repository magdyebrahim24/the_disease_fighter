import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:the_disease_fighter/layout/doctor-screens/doctor_profile/edit_doctor_info/update_doctor_dates.dart';
import 'package:the_disease_fighter/localizations/localization/language/languages.dart';
import 'package:the_disease_fighter/material/bottons/roundedBtn.dart';
import 'package:the_disease_fighter/material/constants.dart';
import 'package:the_disease_fighter/material/inductors/loader_dialog.dart';
import 'package:the_disease_fighter/material/widgets/drop-downlist.dart';
import 'package:the_disease_fighter/material/widgets/time-date-field.dart';
import 'package:the_disease_fighter/material/widgets/txt_field.dart';
import 'package:the_disease_fighter/services/basicData/controllers/doctor_register.dart';

class DoctorInfo extends StatefulWidget {
  final email;
  final password;
  final name;
  final isDoctor;

  const DoctorInfo({Key? key, this.email, this.password, this.name, this.isDoctor}) : super(key: key);
  @override
  _DoctorInfoState createState() => _DoctorInfoState();
}

class _DoctorInfoState extends State<DoctorInfo> {
  String? _clinicLocation;

  String? _phone;
  String _errorMessage = '';
  String? _genderValue;
  String? _specialistValue;
  DateTime? _dateOfBirth;
  String? _about;
  List<String> _specializationsList = [
    "Brain",
    "Heart",
    "Dermatology",
    "Teeth",
    "Bone",
    "Physical",
    "Urology",
    "Surgery",
    "Kids",
    "Internal Medicine",
    "Chest"
  ];
  int? _specializationId;
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  DoctorRegisterController _doctorRegisterController =DoctorRegisterController();

  Future _onSubmitSignUp() async {
    _formKey.currentState!.validate();
    if (_formKey.currentState!.validate()) {
      LoaderDialog().onLoading(context);
      final data = await _doctorRegisterController.register(
        name: widget.name,password: widget.password,isDoctor: widget.isDoctor,email: widget.email,
          phone: _phone.toString(),
          gender: _genderValue.toString(),
          dob: _dateOfBirth.toString(),
          clinicLocation: _clinicLocation.toString(),
          about: _about.toString(),
          specId: _specializationId!.toInt() + 1);
      if (await data['success'] == true) {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setBool('isDoctor', widget.isDoctor);
        await prefs.setString('userData',jsonEncode(await data['logged_user']));
        await prefs.setString('userAvatar',await data['logged_user']['avatar']);
        await prefs.setString('userName',await data['logged_user']['name']);


        Navigator.pushAndRemoveUntil<dynamic>(
          context,
          MaterialPageRoute<dynamic>(
            builder: (BuildContext context) => UpdateDoctorDates(showSkip: true)
          ),
              (route) => false,
        );
      } else {
        setState(() {
          _errorMessage = data['message'].toString();
        });
        Navigator.of(context).pop();
      }
    }
  }

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
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
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(top: 25, bottom: 30),
                        child: Text(
                            Languages.of(context)!
                                .signUpDoctorInfo['header'],
                          style: TextStyle(fontSize: 30, color: darkBlueColor),
                        ),
                      ),
                      TxtField(
                        labelText: Languages.of(context)!
                            .signUpDoctorInfo['phoneLabel'],
                        hintText: Languages.of(context)!
                            .signUpDoctorInfo['phoneHint'],
                        inputTextFunction: (value) {
                          setState(() {
                            _phone = value;
                          });
                        },
                        validatorFun: (value) {
                          if (value.toString().isEmpty) {
                            return 'Phone Required';
                          }
                          if(value.toString().length != 11){
                            return 'Phone Must Be 11 Digit';
                          }
                        },
                        textInputType: TextInputType.phone,
                      ),
                      DropDownList(
                        value: _genderValue,
                        getValue: (value) {
                          setState(() {
                            _genderValue = value;
                          });
                        },
                        items: ["Male", "Female"],
                        hintText: Languages.of(context)!
                            .signUpDoctorInfo['genderLabel'],
                        labelText: Languages.of(context)!
                            .signUpDoctorInfo['genderHint'],
                      ),
                      BasicDateField(
                        helperText:  Languages.of(context)!
                            .signUpDoctorInfo['helperText'],
                        label:  Languages.of(context)!
                            .signUpDoctorInfo['DateLabel'],
                        fun: (value) {
                          setState(() {
                            _dateOfBirth = value;
                          });
                        },
                      ),
                      DropDownList(
                        value: _specialistValue,
                        getValue: (value) {
                          for (var i = 0;
                              i < _specializationsList.length;
                              i++) {
                            if (_specializationsList[i] == value) {
                              setState(() {
                                _specializationId = i;
                                _specialistValue = value;
                              });
                            }
                          }
                        },
                        items: _specializationsList,
                        hintText:  Languages.of(context)!
                            .signUpDoctorInfo['specialistHint'],
                        labelText:  Languages.of(context)!
                            .signUpDoctorInfo['specialistLabel'],
                      ),
                      TxtField(
                        labelText: Languages.of(context)!
                            .signUpDoctorInfo['clinicLocationLabel'],
                        hintText: Languages.of(context)!
                            .signUpDoctorInfo['clinicLocationHint'],
                        inputTextFunction: (value) {
                          setState(() {
                            _clinicLocation = value;
                          });
                        },
                        textInputType: TextInputType.text,
                        validatorFun: (value) {
                          if (value.toString().isEmpty) {
                            return 'Location Required';
                          }
                        },
                      ),
                      TxtField(
                        labelText: Languages.of(context)!
                            .signUpDoctorInfo['infoAboutYou'],
                        hintText: Languages.of(context)!
                            .signUpDoctorInfo['infoAboutYouHint'],
                        inputTextFunction: (value) {
                          setState(() {
                            _about = value;
                          });
                        },
                        textInputType: TextInputType.text,
                        validatorFun: (value) {
                          if (value.toString().isEmpty) {
                            return 'Information Required';
                          }
                        },
                      ),
                      _errorMessage != ''
                          ? Padding(
                              padding: EdgeInsets.symmetric(vertical: 15),
                              child: Text(
                                _errorMessage,
                                style: TextStyle(
                                    color: Colors.red.withOpacity(.6)),
                              ),
                            )
                          : SizedBox(),
                      SizedBox(
                        height: 10,
                      ),
                      RoundedButton(
                        fun: _onSubmitSignUp,
                        text:Languages.of(context)!
                            .signUpDoctorInfo['submit'],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
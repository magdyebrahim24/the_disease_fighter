import 'package:flutter/material.dart';
import 'package:the_disease_fighter/layout/drawer/drawer_screens/terms_of_use.dart';
import 'package:the_disease_fighter/layout/patient_screens/patient_home/home.dart';
import 'package:the_disease_fighter/localizations/localization/language/languages.dart';
import 'package:the_disease_fighter/material/bottons/roundedBtn.dart';
import 'package:the_disease_fighter/material/constants.dart';
import 'package:the_disease_fighter/material/inductors/loader_dialog.dart';
import 'package:the_disease_fighter/material/widgets/drop-downlist.dart';
import 'package:the_disease_fighter/material/widgets/time-date-field.dart';
import 'package:the_disease_fighter/material/widgets/txt_field.dart';
import 'package:the_disease_fighter/services/logged_user/controllers/update_patient_info.dart';

class PatientInfo extends StatefulWidget {
  @override
  _PatientInfoState createState() => _PatientInfoState();
}

class _PatientInfoState extends State<PatientInfo> {
  String? _address;
  String? _phone;

  String _errorMessage = '';
  String? _genderValue;

  String? _about;

  DateTime? dateOfBirth;

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  UpdatePatientInfoController _updateUserInfoController =
      UpdatePatientInfoController();

  Future _updateUserInfo() async {
    _formKey.currentState!.validate();
    _formKey.currentState!.save();

    if (_formKey.currentState!.validate()) {
      LoaderDialog().onLoading(context);
      final data = await _updateUserInfoController.updatePatientInfo(
          location: _address,
          phone: _phone,
          dob: dateOfBirth.toString(),
          gender: _genderValue,
          about: _about);
      if (await data['success']) {
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => Home(),
            ));
      } else {
        setState(() {
          _errorMessage = data['message'].toString();
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
                      Padding(
                        padding: EdgeInsets.only(top: 25, bottom: 30),
                        child: Text(
                          Languages.of(context)!.signUpPatientInfo['header'],
                          style: TextStyle(fontSize: 30, color: darkBlueColor),
                        ),
                      ),
                      TxtField(
                        labelText: Languages.of(context)!
                            .signUpPatientInfo['addressLabel'],
                        hintText: Languages.of(context)!
                            .signUpPatientInfo['addressHint'],
                        inputTextFunction: (String address) {
                          setState(() {
                            this._address = address;
                          });
                        },
                        textInputType: TextInputType.text,
                        validatorFun: (value) {
                          if (value.toString().isEmpty) {
                            return 'Address Required';
                          }
                        },
                      ),
                      TxtField(
                        labelText: Languages.of(context)!
                            .signUpPatientInfo['phoneLabel'],
                        hintText: Languages.of(context)!
                            .signUpPatientInfo['phoneHint'],
                        inputTextFunction: (String phone) {
                          setState(() {
                            this._phone = phone;
                          });
                        },
                        textInputType: TextInputType.phone,
                        validatorFun: (value) {
                          if (value.toString().isEmpty) {
                            return 'Phone Required';
                          }
                        },
                      ),
                      BasicDateField(
                        helperText: Languages.of(context)!
                            .signUpPatientInfo['DateLabel'],
                        label: Languages.of(context)!
                            .signUpPatientInfo['helperText'],
                        fun: (dateOfBirth) {
                          setState(() {
                            this.dateOfBirth = dateOfBirth;
                          });
                        },
                      ),
                      DropDownList(
                        value: _genderValue,
                        getValue: (val) {
                          setState(() {
                            _genderValue = val;
                          });
                        },
                        items: ["Male", "Female"],
                        hintText: Languages.of(context)!
                            .signUpPatientInfo['genderHint'],
                        labelText: Languages.of(context)!
                            .signUpPatientInfo['genderLabel'],
                      ),
                      TxtField(
                        labelText: 'Information About You',
                        hintText: 'type any information',
                        inputTextFunction: (value) {
                          setState(() {
                            value = _about;
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
                          ? Text(
                              _errorMessage,
                              style:
                                  TextStyle(color: Colors.red.withOpacity(.6)),
                            )
                          : SizedBox(),
                      Container(
                        margin: EdgeInsets.symmetric(vertical: 15),
                        width: MediaQuery.of(context).size.width,
                        alignment: Alignment.center,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              Languages.of(context)!
                                  .signUpPatientInfo['subText'],
                              style: TextStyle(color: subTextColor),
                            ),
                            InkWell(
                              onTap: () => Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => TermsOfUse(),
                                ),
                              ),
                              child: Text(
                                Languages.of(context)!
                                    .signUpPatientInfo['terms'],
                                style: TextStyle(
                                    color: Colors.orangeAccent,
                                    decoration: TextDecoration.underline,
                                    decorationThickness: 2),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 20),
                        child: RoundedButton(
                          fun: _updateUserInfo,
                          text:
                              Languages.of(context)!.signUpPatientInfo['done'],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
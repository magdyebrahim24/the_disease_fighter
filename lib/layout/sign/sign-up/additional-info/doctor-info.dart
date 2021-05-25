import 'package:flutter/material.dart';
import 'package:the_disease_fighter/layout/drawer/drawer_screens/doctor/doctor_profile/edit_doctor_info/update_doctor_dates.dart';
import 'package:the_disease_fighter/material/bottons/roundedBtn.dart';
import 'package:the_disease_fighter/material/constants.dart';
import 'package:the_disease_fighter/material/inductors/loader_dialog.dart';
import 'package:the_disease_fighter/material/widgets/drop-downlist.dart';
import 'package:the_disease_fighter/material/widgets/time-date-field.dart';
import 'package:the_disease_fighter/material/widgets/txt_field.dart';
import 'package:the_disease_fighter/services/logged_user/controllers/updateDoctorInfo.dart';

class DoctorInfo extends StatefulWidget {
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
    "Heart" "Dermatology",
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

  UpdateDoctorInfoController _updateDoctorInfoController =
      UpdateDoctorInfoController();

  Future _onSubmitSignUp() async {
    _formKey.currentState!.validate();
    if (_formKey.currentState!.validate()) {
      LoaderDialog().onLoading(context);
      final data = await _updateDoctorInfoController.updateDoctorInfo(
          phone: _phone.toString(),
          gender: _genderValue.toString(),
          dob: _dateOfBirth.toString(),
          clinicLocation: _clinicLocation.toString(),
          about: _about.toString(),
          specId: _specializationId.toString());
      if (await data['success'] == true) {
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => UpdateDoctorDates(showSkip: true),
            ));
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
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(top: 25, bottom: 30),
                        child: Text(
                          'You\'re Almost Done!',
                          style: TextStyle(fontSize: 30, color: darkBlueColor),
                        ),
                      ),
                      TxtField(
                        labelText: 'Phone',
                        hintText: 'Enter your Phone',
                        inputTextFunction: (value) {
                          setState(() {
                            _phone = value;
                          });
                        },
                        validatorFun: (value) {
                          if (value.toString().isEmpty) {
                            return 'Phone Required';
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
                        hintText: 'Select Gender',
                        labelText: 'Gender',
                      ),
                      BasicDateField(
                        helperText: 'Select Date Of Birth',
                        label: 'Date Of Birth',
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
                        hintText: 'Select Your Specialist',
                        labelText: 'Specialist',
                      ),
                      TxtField(
                        labelText: 'Clinic Location',
                        hintText: 'Enter your Clinic Location',
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
                        labelText: 'Information About You',
                        hintText: 'Enter Any Information',
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
                        text: 'Submit',
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
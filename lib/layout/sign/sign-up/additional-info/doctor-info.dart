import 'package:flutter/material.dart';
import 'package:the_disease_fighter/layout/doctor-screens/doctor_home/doctor_home.dart';
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
  String clinicLocation = '';
  String? phone;
  String errorMessage = '';
  String genderValue = 'Male';
  String specialistValue = 'Brain';
  DateTime? dateOfBirth;

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  _getClinicLocation(String clinicLocation) {
    setState(() {
      this.clinicLocation = clinicLocation;
    });
  }

  _getDateOfBirth(val) {
    setState(() {
      this.dateOfBirth = val;
    });
  }

  _getGender(val) {
    setState(() {
      genderValue = val;
    });
  }

  _getSpecialist(val) {
    setState(() {
      specialistValue = val;
    });
  }

  UpdateDoctorInfoController _updateDoctorInfoController =
      UpdateDoctorInfoController();

  Future _onSubmitSignUp() async {
    _formKey.currentState!.validate();
    if (_formKey.currentState!.validate()) {
      LoaderDialog().onLoading(context);
      final data = await _updateDoctorInfoController.updateDoctorInfo(
          phone: phone.toString(),
          gender: genderValue.toString(),
          dob: dateOfBirth.toString(),
          clinicLocation: clinicLocation.toString(),
          about: "bjkkbj",
          specId: "1");
      if (await data['success'] == true) {
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => UpdateDoctorDates(showSkip: true),
            ));
      } else {
        setState(() {
          errorMessage = data['message'].toString();
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
                            phone = value;
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
                        value: genderValue,
                        getValue: _getGender,
                        items: ["Male", "Female"],
                        hintText: 'Select Gender',
                        labelText: 'Gender',
                      ),
                      BasicDateField(
                        helperText: 'Select Date Of Birth',
                        label: 'Date Of Birth',
                        fun: _getDateOfBirth,
                      ),
                      DropDownList(
                        value: specialistValue,
                        getValue: _getSpecialist,
                        items: [
                          'Brain',
                          'Heart',
                          'Dermatology',
                          'Teeth',
                          'Bone',
                          'Surgery',
                          'Urology',
                          'Psychiatry',
                          'Pediatrics',
                        ],
                        hintText: 'Select Your Specialist',
                        labelText: 'Specialist',
                      ),
                      TxtField(
                        labelText: 'Clinic Location',
                        hintText: 'Enter your Clinic Location',
                        inputTextFunction: _getClinicLocation,
                        textInputType: TextInputType.text,
                        validatorFun: (value) {
                          if (value.toString().isEmpty) {
                            return 'Location Required';
                          }
                        },
                      ),
                      errorMessage != ''
                          ? Padding(
                              padding: EdgeInsets.symmetric(vertical: 15),
                              child: Text(
                                errorMessage,
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

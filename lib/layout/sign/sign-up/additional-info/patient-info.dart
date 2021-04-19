import 'package:flutter/material.dart';
import 'package:the_disease_fighter/layout/drawer/drawer_screens/terms_of_use.dart';
import 'package:the_disease_fighter/layout/patient_screens/patient_home/home.dart';
import 'package:the_disease_fighter/material/bottons/roundedBtn.dart';
import 'package:the_disease_fighter/material/constants.dart';
import 'package:the_disease_fighter/material/widgets/drop-downlist.dart';
import 'package:the_disease_fighter/material/widgets/time-date-field.dart';
import 'package:the_disease_fighter/material/widgets/txt_field.dart';

class PatientInfo extends StatefulWidget {
  @override
  _PatientInfoState createState() => _PatientInfoState();
}

class _PatientInfoState extends State<PatientInfo> {
  String address = '';
  String phone = '';
  String errorMessage = '';
  String genderValue = 'Male';

  late DateTime dateOfBirth;

  _getAddress(String address) {
    setState(() {
      this.address = address;
    });
  }

  _getDateOfBirth(phone) {
    setState(() {
      this.dateOfBirth = phone;
    });
  }

  _getPhone(String phone) {
    setState(() {
      this.phone = phone;
    });
  }

  _getGender(val) {
    setState(() {
      genderValue = val;
    });
  }

  _onSubmitSignUp() {
    if (address == ''
        // clinicLocation == '' || phone == ''
        ) {
      setState(() {
        errorMessage = 'Name or Email Or Phone are empty';
      });
    } else {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => Home(),
        ),
      );
    }
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
                        'You\'re Almost Done!',
                        style: TextStyle(fontSize: 30, color: darkBlueColor),
                      ),
                    ),
                    TxtField(
                      labelText: 'Address',
                      hintText: 'Enter your Address',
                      inputTextFunction: _getAddress,
                      textInputType: TextInputType.text,
                    ),
                    TxtField(
                      labelText: 'Phone',
                      hintText: 'Enter your Phone',
                      inputTextFunction: _getPhone,
                      textInputType: TextInputType.phone,
                    ),
                    BasicDateField(
                      helperText: 'Select Date Of Birth',
                      label: 'Date Of Birth',
                      fun: _getDateOfBirth,
                    ),
                    DropDownList(
                      value: genderValue,
                      getValue: _getGender,
                      items: ["Male", "Female"],
                      hintText: 'Select Gender',
                      labelText: 'Gender',
                    ),
                    errorMessage != ''
                        ? Text(
                            errorMessage,
                            style: TextStyle(color: Colors.red.withOpacity(.6)),
                          )
                        : SizedBox(),
                    Container(
                      margin: EdgeInsets.symmetric(vertical: 20),
                      width: MediaQuery.of(context).size.width,
                      alignment: Alignment.center,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            'By pressing “Done” you agree to our',
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
                              'terms & conditions',
                              style: TextStyle(
                                  color: Colors.orangeAccent,
                                  decoration: TextDecoration.underline,
                                  decorationThickness: 2),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    RoundedButton(
                      fun: _onSubmitSignUp,
                      text: 'Done',
                    ),
                    SizedBox(
                      height: 20,
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

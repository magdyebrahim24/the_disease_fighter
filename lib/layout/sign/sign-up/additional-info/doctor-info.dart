import 'package:flutter/material.dart';
import 'package:the_disease_fighter/layout/patient_screens/patient_home/home.dart';
import 'package:the_disease_fighter/material/bottons/circleBtn.dart';
import 'package:the_disease_fighter/material/bottons/roundedBtn.dart';
import 'package:the_disease_fighter/material/constants.dart';
import 'package:the_disease_fighter/material/widgets/drop-downlist.dart';
import 'package:the_disease_fighter/material/widgets/time-date-field.dart';
import 'package:the_disease_fighter/material/widgets/txt_field.dart';

class DoctorInfo extends StatefulWidget {
  @override
  _DoctorInfoState createState() => _DoctorInfoState();
}

class _DoctorInfoState extends State<DoctorInfo> {
  String clinicLocation = '';
  String? phone;
  String errorMessage = '';
  bool isDoctor = false;
  String? genderValue;
  String? specialistValue;
  String? day;
  DateTime? fromTime;
  DateTime? toTime;
  DateTime? dateOfBirth;
  List clinicDates = [];
  String _clinicError = '';

  _getClinicLocation(String clinicLocation) {
    setState(() {
      this.clinicLocation = clinicLocation;
    });
  }

  _getPhone(String phone) {
    setState(() {
      this.phone = phone;
    });
  }

  _getDateOfBirth(DateTime phone) {
    setState(() {
      this.dateOfBirth = phone;
    });
  }

  _getGender(String val) {
    setState(() {
      genderValue = val;
    });
  }

  _getSpecialist(String val) {
    setState(() {
      specialistValue = val;
    });
  }

  _getDay(String? val) {
    setState(() {
      day = val;
    });
  }

  _getTimeFrom(DateTime val) {
    setState(() {
      fromTime = val;
    });
  }

  _getTimeTo(DateTime val) {
    setState(() {
      toTime = val;
    });
  }

  _onSubmitSignUp() {
    if (clinicLocation == '' /* == false */
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
                      inputTextFunction: _getPhone,
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
                    ),
                    Text(
                      'Enter Dates Clinic Available',
                      style: TextStyle(fontSize: 15, color: subTextColor),
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(
                        vertical: 7,
                      ),
                      padding:
                          EdgeInsets.symmetric(horizontal: 14, vertical: 15),
                      decoration: BoxDecoration(
                        color: backGroundColor,
                        border: Border.all(
                            width: 1,
                            color: Color(0xff707070).withOpacity(.15)),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(
                            height: clinicDates.length * 70.0,
                            child: ListView.builder(
                                physics: NeverScrollableScrollPhysics(),
                                padding: EdgeInsets.all(0),
                                itemCount: clinicDates.length,
                                itemBuilder: (ctx, index) {
                                  return Container(
                                    height: 60,
                                    width: MediaQuery.of(context).size.width,
                                    padding: EdgeInsets.fromLTRB(15, 10, 5, 10),
                                    margin: EdgeInsets.symmetric(vertical: 5),
                                    child: Row(
                                      children: [
                                        Icon(Icons.access_time,
                                            color: darkBlueColor),
                                        SizedBox(
                                          width: 10,
                                        ),
                                        Expanded(
                                          child: Text(
                                            '${clinicDates[index]['day']}, ${clinicDates[index]['from']} - ${clinicDates[index]['to']},',
                                            maxLines: 3,
                                            overflow: TextOverflow.ellipsis,
                                            style:
                                                TextStyle(color: darkBlueColor),
                                          ),
                                        ),
                                        CircleButton(
                                          color: subTextColor,
                                          fun: () {
                                            setState(() {
                                              clinicDates.removeAt(index);
                                              // x--;
                                              rebuildAllChildren(context);
                                            });
                                            print(clinicDates);
                                          },
                                          icn: Icons.delete_outline,
                                        ),
                                      ],
                                    ),
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius:
                                            BorderRadius.circular(15)),
                                  );
                                }),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(vertical: 5),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Day Clinic Open In :',
                                  style: TextStyle(
                                      fontSize: 15, color: darkBlueColor),
                                ),
                                Container(
                                    margin: EdgeInsets.symmetric(
                                      vertical: 7,
                                    ),
                                    padding: EdgeInsets.all(15),
                                    decoration: BoxDecoration(
                                        border: Border.all(
                                            width: 1,
                                            color: Color(0xff707070)
                                                .withOpacity(.15)),
                                        borderRadius: BorderRadius.circular(10),
                                        color: Colors.white),
                                    height: 52,
                                    width: MediaQuery.of(context).size.width,
                                    child: DropdownButtonHideUnderline(
                                      child: DropdownButton<String>(
                                        onChanged: _getDay,
                                        value: day,
                                        elevation: 1,
                                        hint: Text(
                                          'Select Day Clinic Open In',
                                          style: TextStyle(color: subTextColor),
                                        ),
                                        icon: Icon(Icons.arrow_drop_down,
                                            color:
                                                darkBlueColor.withOpacity(.7)),
                                        isDense: false,
                                        items: [
                                          'Saturday',
                                          'Sunday',
                                          'Monday',
                                          'Tuesday',
                                          'Wednesday',
                                          'Thursday',
                                          'Friday',
                                        ].map<DropdownMenuItem<String>>(
                                            (String value) {
                                          return DropdownMenuItem<String>(
                                            value: value,
                                            child: Text(
                                              value,
                                              style: TextStyle(
                                                  fontSize: 15,
                                                  color: darkBlueColor),
                                            ),
                                          );
                                        }).toList(),
                                      ),
                                    )),
                              ],
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              SizedBox(
                                  width:
                                      MediaQuery.of(context).size.width * .35,
                                  child: BasicTimeField(
                                    backgroundColor: Colors.white,
                                    labelColor: darkBlueColor,
                                    label: 'From :',
                                    fun: _getTimeFrom,
                                    helperText: 'Enter Time Clinic Opens In',
                                  )),
                              SizedBox(
                                width: 10,
                              ),
                              SizedBox(
                                  width:
                                      MediaQuery.of(context).size.width * .35,
                                  child: BasicTimeField(
                                    backgroundColor: Colors.white,
                                    labelColor: darkBlueColor,
                                    label: 'To :',
                                    fun: _getTimeTo,
                                    helperText: 'Enter Time Clinic Close In',
                                  )),
                            ],
                          ),
                          Text(
                            '$_clinicError',
                            style: TextStyle(color: Colors.red),
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: 5),
                            child: RoundedButton(
                              fun: () {
                                if (fromTime != null ||
                                    toTime != null ||
                                    day != null) {
                                  var from = fromTime.toString().split(' ');
                                  var to = toTime.toString().split(' ');
                                  var fromTimeSplit = from[1];
                                  var toTimeSplit = to[1];
                                  var clinicDate = {
                                    'day': day,
                                    'from': fromTimeSplit,
                                    'to': toTimeSplit
                                  };
                                  clinicDates.add(clinicDate);
                                  setState(() {
                                    _clinicError = '';
                                  });
                                } else {
                                  setState(() {
                                    _clinicError =
                                        'please enter times clinic open in and close in';
                                  });
                                }
                              },
                              text: 'Add',
                              borderRadious: 10,
                              minWdthRatio: .8,
                            ),
                          ),
                        ],
                      ),
                    ),
                    errorMessage != ''
                        ? Text(
                            errorMessage,
                            style: TextStyle(color: Colors.red.withOpacity(.6)),
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
            ],
          ),
        ),
      ),
    );
  }

  void rebuildAllChildren(BuildContext context) {
    void rebuild(Element el) {
      el.markNeedsBuild();
      el.visitChildren(rebuild);
    }

    (context as Element).visitChildren(rebuild);
  }
}
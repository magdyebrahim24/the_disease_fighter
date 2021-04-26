import 'package:flutter/material.dart';
import 'package:the_disease_fighter/layout/doctor-screens/doctor_home/doctor_home.dart';
import 'package:the_disease_fighter/layout/drawer/drawer_screens/terms_of_use.dart';
import 'package:the_disease_fighter/localizations/localization/language/languages.dart';
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
  String genderValue = 'Male';
  String specialistValue = 'Brain';
  String? day;
  late DateTime fromTime;
  late DateTime toTime;
  late DateTime dateOfBirth;
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

  _getDay(val) {
    setState(() {
      day = val;
    });
  }

  _getTimeFrom(val) {
    setState(() {
      fromTime = val;
    });
  }

  _getTimeTo(val) {
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
          builder: (context) => DoctorHome(),
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
                        Languages.of(context)!.signUpDoctorInfo['header'],
                        style: TextStyle(fontSize: 30, color: darkBlueColor),
                      ),
                    ),
                    TxtField(
                      labelText:
                          Languages.of(context)!.signUpDoctorInfo['phoneLabel'],
                      hintText:
                          Languages.of(context)!.signUpDoctorInfo['phoneHint'],
                      inputTextFunction: _getPhone,
                      textInputType: TextInputType.phone,
                    ),
                    DropDownList(
                      value: genderValue,
                      getValue: _getGender,
                      items: ["Male", "Female"],
                      hintText:
                          Languages.of(context)!.signUpDoctorInfo['genderHint'],
                      labelText: Languages.of(context)!
                          .signUpDoctorInfo['genderLabel'],
                    ),
                    BasicDateField(
                      helperText:
                          Languages.of(context)!.signUpDoctorInfo['helperText'],
                      label:
                          Languages.of(context)!.signUpDoctorInfo['DateLabel'],
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
                      hintText: Languages.of(context)!
                          .signUpDoctorInfo['specialistHint'],
                      labelText: Languages.of(context)!
                          .signUpDoctorInfo['specialistLabel'],
                    ),
                    TxtField(
                      labelText: Languages.of(context)!
                          .signUpDoctorInfo['clinicLocationLabel'],
                      hintText: Languages.of(context)!
                          .signUpDoctorInfo['clinicLocationHint'],
                      inputTextFunction: _getClinicLocation,
                      textInputType: TextInputType.text,
                    ),
                    Text(
                      Languages.of(context)!
                          .signUpDoctorInfo['clinicDaterHeader'],
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
                                    padding:
                                        EdgeInsets.fromLTRB(15, 10, 10, 10),
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
                                  Languages.of(context)!
                                      .signUpDoctorInfo['clinicOpen'],
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
                                          Languages.of(context)!
                                              .signUpDoctorInfo['dayHint'],
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
                                    label: Languages.of(context)!
                                        .signUpDoctorInfo['from'],
                                    fun: _getTimeFrom,
                                    helperText: Languages.of(context)!
                                        .signUpDoctorInfo['fromHelper'],
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
                                    label: Languages.of(context)!
                                        .signUpDoctorInfo['to'],
                                    fun: _getTimeTo,
                                    helperText: Languages.of(context)!
                                        .signUpDoctorInfo['toHelper'],
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
                                // ignore: unnecessary_null_comparison
                                if (fromTime != null ||
                                    // ignore: unnecessary_null_comparison
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
                              text: Languages.of(context)!
                                  .signUpDoctorInfo['addBTN'],
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
                    Container(
                      margin: EdgeInsets.symmetric(vertical: 15),
                      width: MediaQuery.of(context).size.width,
                      alignment: Alignment.center,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            Languages.of(context)!.signUpDoctorInfo['subText'],
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
                              Languages.of(context)!.signUpDoctorInfo['terms'],
                              style: TextStyle(
                                  color: Colors.orangeAccent,
                                  decoration: TextDecoration.underline,
                                  decorationThickness: 2),
                            ),
                          ),
                        ],
                      ),
                    ),
                    RoundedButton(
                      fun: _onSubmitSignUp,
                      text: Languages.of(context)!.signUpDoctorInfo['submit'],
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
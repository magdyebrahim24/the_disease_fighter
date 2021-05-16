import 'package:flutter/material.dart';
import 'package:the_disease_fighter/layout/drawer/drawer_screens/patient/favorite/favorite_doctors.dart';
import 'package:the_disease_fighter/layout/patient_screens/patient_home/home.dart';
import 'package:the_disease_fighter/localizations/localization/language/languages.dart';
import 'package:the_disease_fighter/material/bottons/roundedBtn.dart';
import 'package:the_disease_fighter/material/constants.dart';
import 'package:the_disease_fighter/material/widgets/drop-downlist.dart';
import 'package:the_disease_fighter/material/widgets/txt_field.dart';
import 'package:the_disease_fighter/services/doctors/controllers/getDoctorDatesController.dart';
import 'package:the_disease_fighter/services/sessions/controllers/createSession.dart';

class BookAppointment extends StatefulWidget {
  final docId;
  final docName;
  final docImage;

  BookAppointment({this.docId, this.docName, this.docImage});

  @override
  _BookAppointmentState createState() => _BookAppointmentState();
}

class _BookAppointmentState extends State<BookAppointment> {
  var appointmentTime;
  var appointmentDay;
  String gender = 'Male';
  String? phone;
  String comment = ' ';
  String? patientName;
  String? amPm;
  var days;
  String? errorMessage;

  List dayTimes = [];
  CreateSessionController _createSessionController = CreateSessionController();
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  GetDoctorDatesController _doctorDatesController = GetDoctorDatesController();

  Future _loadDoctorDates() async {
    var data =
        await _doctorDatesController.getDoctorDates(doctorId: widget.docId);
    days = data;
    return Future.value(data);
  }

  bool _isLoading = false;

  Future _createSession() async {
    _formKey.currentState!.validate();
    print(appointmentTime.time);
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
      });
      _formKey.currentState!.save();
      amPm = appointmentTime.time.split(' ')[1];
      final data = await _createSessionController.createSession(
          time: appointmentTime.time.toString(),
          amPm: amPm,
          comment: comment,
          day: appointmentDay.toString(),
          gender: gender.toString(),
          name: patientName,
          phone: phone.toString(),
          periodId: appointmentTime.id.toString(),
          previousPeriodId: appointmentTime.id.toString(),
          docId: widget.docId.toString());
      if (await data['success']) {
        print('success');
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (context) => Home(
                      showSnackBar: true,
                    )));
      } else {
        setState(() {
          errorMessage = data['message'].toString();
          _isLoading = false;
        });
      }
      setState(() {
        _isLoading = false;
        // errorMessage = data['message'].toString();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.transparent,
        leading: MaterialButton(
          onPressed: () => Navigator.pop(context),
          child: Icon(
            Icons.arrow_back,
            color: darkBlueColor,
          ),
          color: primaryColor.withOpacity(.2),
          elevation: 0.0,
          materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(45.0),
          ),
        ),
      ),
      body: !_isLoading
          ? SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    alignment: Alignment.center,
                    margin: EdgeInsets.only(bottom: 25),
                    padding: EdgeInsets.only(top: 25),
                    width: MediaQuery.of(context).size.width,
                    height: 230,
                    decoration: BoxDecoration(
                        color: primaryColor.withOpacity(.8),
                        borderRadius: BorderRadius.only(
                          bottomRight: Radius.circular(40),
                          bottomLeft: Radius.circular(40),
                        )),
                    // ignore: unnecessary_null_comparison
                    child: widget.docImage != null && widget.docName != null
                        ? Column(
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                    boxShadow: [
                                      BoxShadow(
                                          color: subTextColor,
                                          offset: Offset(1.0, 2.0),
                                          blurRadius: 6.0,
                                          spreadRadius: 1),
                                    ],
                                    image: DecorationImage(
                                        image: NetworkImage(widget.docImage),
                                        fit: BoxFit.cover),
                                    shape: BoxShape.circle,
                                    border: Border.all(
                                        color: Color(0xffFDFDFD), width: 2),
                                    color: backGroundColor),
                                margin: EdgeInsets.only(top: 20, bottom: 10),
                                height: 120,
                                width: 120,
                              ),
                              Text(
                                widget.docName.toString(),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: darkBlueColor,
                                  fontSize: 18,
                                ),
                              ),
                            ],
                          )
                        : Text(
                            'Some Thing Wrong',
                            style: TextStyle(color: Colors.white),
                          ),
                  ),
                  FutureBuilder<dynamic>(
                      future: _loadDoctorDates(),
                      builder: (BuildContext context,
                          AsyncSnapshot<dynamic> snapshot) {
                        if (!snapshot.hasData && !snapshot.hasError) {
                          return Center(child: CircularProgressIndicator());
                        } else {
                          if (snapshot.hasError) {
                            return Padding(
                              padding: EdgeInsets.only(
                                  top:
                                      MediaQuery.of(context).size.height * .15),
                              child: Column(
                                children: [
                                  IconButton(
                                      icon: Icon(
                                        Icons.refresh,
                                        color: primaryColor,
                                        size: 40,
                                      ),
                                      onPressed: () {
                                        setState(() {
                                          _loadDoctorDates();
                                        });
                                      }),
                                  SizedBox(
                                    height: 15,
                                  ),
                                  Text(
                                    'Failed To Load',
                                    style: TextStyle(
                                        color: subTextColor, fontSize: 16),
                                  ),
                                ],
                              ),
                            );
                          } else {
                            return snapshot.data.success == true
                                ? Form(
                                    key: _formKey,
                                    child: Padding(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 15, vertical: 10),
                                      child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            DropDownDate(
                                              getValue: (value) async {
                                                for (var item
                                                    in snapshot.data.dates) {
                                                  if (item.day == value) {
                                                    setState(() {
                                                      dayTimes =
                                                          item.availableDates;
                                                      appointmentDay = value;
                                                    });
                                                    return;
                                                  }
                                                }
                                              },
                                              // value: snapshot.data.dates[0].day.toString(),
                                              items: List.from(snapshot
                                                  .data.dates
                                                  .map((i) => DropdownMenuItem(
                                                        child: Text(
                                                          i.day.toString(),
                                                          style: TextStyle(
                                                              fontSize: 15,
                                                              color: darkBlueColor
                                                                  .withOpacity(
                                                                      .9)),
                                                        ),
                                                        value: i.day,
                                                      ))),

                                              hintText: 'select Day',
                                              labelText: 'Day',
                                            ),
                                            DropDownDate(
                                              getValue: (val) {
                                                setState(() {
                                                  appointmentTime = val;
                                                });
                                              },
                                              // value: snapshot.data.dates[0].day.toString(),
                                              items: List.from(dayTimes
                                                  .where((element) =>
                                                      element.isAvailable ==
                                                      false)
                                                  .map((i) => DropdownMenuItem(
                                                        child: Text(
                                                          i.time.toString(),
                                                          style: TextStyle(
                                                              fontSize: 15,
                                                              color: darkBlueColor
                                                                  .withOpacity(
                                                                      .9)),
                                                        ),
                                                        value: i,
                                                      ))),
                                              hintText: 'select Time',
                                              labelText: 'Time',
                                            ),
                                            // Container(
                                            //   margin: EdgeInsets.symmetric(
                                            //     vertical: 7,
                                            //   ),
                                            //   padding: EdgeInsets.symmetric(horizontal: 15,vertical: 3),
                                            //   decoration: BoxDecoration(
                                            //       border: Border.all(
                                            //           width: 1, color: Color(0xff707070).withOpacity(.15)),
                                            //       borderRadius: BorderRadius.circular(10),
                                            //       color: backGroundColor),
                                            //   // height: 52,
                                            //     child: DropdownButtonFormField<dynamic>(
                                            //         isDense: true,
                                            //         decoration: InputDecoration(
                                            //           border: InputBorder.none,
                                            //         ),
                                            //         items:List.from(snapshot.data.dates
                                            //             .map((i) => DropdownMenuItem(
                                            //           child: Text(
                                            //             i.day.toString(),
                                            //             style: TextStyle(
                                            //                 fontSize: 15,
                                            //                 color: darkBlueColor
                                            //                     .withOpacity(.9)),
                                            //           ),
                                            //           value: i.day,
                                            //         ))),
                                            //         onChanged: (value) async{
                                            //           for(var item in snapshot.data.dates){
                                            //             if(item.day == value){
                                            //               setState(() {
                                            //                 dayTimes = item.availableDates;
                                            //                 appointmentDay = value;
                                            //               });
                                            //             }
                                            //           }
                                            //         },
                                            //         isExpanded: true,
                                            //         elevation: 1,
                                            //         hint: Text(
                                            //             'select Day',
                                            //           style: TextStyle(color: subTextColor),
                                            //         ),
                                            //         validator: (value) {
                                            //           if (value == null ||
                                            //               value == '') {
                                            //             return 'من فضلك اختر خدمة';
                                            //           }
                                            //           return null;
                                            //         }),
                                            //   ),
                                            TxtField(
                                              textInputType: TextInputType.text,
                                              labelText: Languages.of(context)!
                                                  .bookAppointment['nameLabel'],
                                              hintText: Languages.of(context)!
                                                  .bookAppointment['nameHint'],
                                              inputTextFunction: (val) {
                                                setState(() {
                                                  patientName = val;
                                                });
                                              },
                                              validatorFun: (val) {
                                                if (val == null || val == '') {
                                                  return 'name required';
                                                }
                                              },
                                            ),
                                            Row(
                                              children: [
                                                SizedBox(
                                                  width: 130,
                                                  child: DropDownList(
                                                    value: gender,
                                                    getValue: (val) {
                                                      setState(() {
                                                        gender = val;
                                                      });
                                                    },
                                                    items: ['Male', 'Female'],
                                                    hintText: Languages.of(
                                                                context)!
                                                            .bookAppointment[
                                                        'genderHint'],
                                                    labelText: Languages.of(
                                                                context)!
                                                            .bookAppointment[
                                                        'genderLabel'],
                                                  ),
                                                ),
                                                SizedBox(
                                                  width: 20,
                                                ),
                                                Expanded(
                                                  child: TxtField(
                                                    textInputType:
                                                        TextInputType.phone,
                                                    labelText: Languages.of(
                                                                context)!
                                                            .bookAppointment[
                                                        'phoneLabel'],
                                                    hintText: Languages.of(
                                                                context)!
                                                            .bookAppointment[
                                                        'phoneHint'],
                                                    inputTextFunction: (phone) {
                                                      setState(() {
                                                        this.phone = phone;
                                                      });
                                                    },
                                                    validatorFun: (val) {
                                                      if (val == null) {
                                                        return 'phone required';
                                                      } else if (val.length <
                                                          11) {
                                                        return 'at least 11 digit';
                                                      }
                                                    },
                                                  ),
                                                ),
                                              ],
                                            ),
                                            Text(
                                              Languages.of(context)!
                                                      .bookAppointment[
                                                  'appointmentNote'],
                                              style: TextStyle(
                                                  color: darkBlueColor
                                                      .withOpacity(.8)),
                                            ),
                                            Container(
                                              margin: EdgeInsets.only(
                                                  top: 10, bottom: 20),
                                              padding: EdgeInsets.all(5),
                                              decoration: BoxDecoration(
                                                  border: Border.all(
                                                      width: 1,
                                                      color: Color(0xff707070)
                                                          .withOpacity(.15)),
                                                  color: backGroundColor,
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          10)),
                                              child: TextFormField(
                                                onChanged: (val) {
                                                  setState(() {
                                                    comment = val;
                                                  });
                                                },
                                                keyboardType:
                                                    TextInputType.text,
                                                maxLines: 3,
                                                decoration: InputDecoration(
                                                    border: InputBorder.none,
                                                    contentPadding:
                                                        EdgeInsets.all(10),
                                                    hintText: Languages
                                                                .of(context)!
                                                            .bookAppointment[
                                                        'appointmentNoteHint'],
                                                    hintStyle: TextStyle(
                                                        color: subTextColor
                                                            .withOpacity(.8),
                                                        fontSize: 16)),
                                              ),
                                            ),
                                            errorMessage != null
                                                ? Text(
                                                    errorMessage.toString(),
                                                    style: TextStyle(
                                                        color: Colors.red
                                                            .withOpacity(.6)),
                                                  )
                                                : SizedBox(),

                                            Padding(
                                              padding: EdgeInsets.only(
                                                  top: 5,
                                                  bottom: 10,
                                                  right: 35,
                                                  left: 35),
                                              child: RoundedButton(
                                                fun: _createSession,
                                                text: Languages.of(context)!
                                                    .bookAppointment['bookBTN'],
                                                borderRadious: 50,
                                              ),
                                            ),
                                          ]),
                                    ),
                                  )
                                : EmptyPage();
                          }
                        }
                      }),
                ],
              ),
            )
          : Center(child: CircularProgressIndicator()),
    );
  }
}

// ignore: must_be_immutable
class DropDownDate extends StatelessWidget {
  DropDownDate(
      {this.getValue,
      this.value,
      this.items,
      this.hintText,
      this.widthRatio = 1,
      this.labelText});

  final getValue;
  final value;
  List<DropdownMenuItem<dynamic>>? items;
  final hintText;
  final widthRatio;
  final labelText;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 7),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            labelText,
            style:
                TextStyle(fontSize: 15, color: darkBlueColor.withOpacity(.8)),
          ),
          Container(
            margin: EdgeInsets.symmetric(
              vertical: 7,
            ),
            padding: EdgeInsets.symmetric(horizontal: 15, vertical: 3),
            decoration: BoxDecoration(
                border: Border.all(
                    width: 1, color: Color(0xff707070).withOpacity(.15)),
                borderRadius: BorderRadius.circular(10),
                color: backGroundColor),
            // height: 52,
            child: DropdownButtonFormField<dynamic>(
                isDense: true,
                decoration: InputDecoration(
                  border: InputBorder.none,
                ),
                items: items,
                onChanged: getValue,
                isExpanded: true,
                elevation: 1,
                hint: Text(
                  '$hintText',
                  style: TextStyle(color: subTextColor),
                ),
                validator: (value) {
                  if (value == null || value == '') {
                    return 'Field Can\'t Be Empty';
                  }
                  return null;
                }),
          ),
        ],
      ),
    );
  }
}

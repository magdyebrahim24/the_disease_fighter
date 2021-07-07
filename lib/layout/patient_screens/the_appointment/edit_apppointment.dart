import 'package:flutter/material.dart';
import 'package:the_disease_fighter/layout/patient_screens/my_appointments/my_appointments.dart';
import 'package:the_disease_fighter/localizations/localization/language/languages.dart';
import 'package:the_disease_fighter/material/bottons/roundedBtn.dart';
import 'package:the_disease_fighter/material/constants.dart';
import 'package:the_disease_fighter/material/inductors/loader_dialog.dart';
import 'package:the_disease_fighter/material/widgets/drop-downlist.dart';
import 'package:the_disease_fighter/material/widgets/materialBanner.dart';
import 'package:the_disease_fighter/services/doctors/controllers/getDoctorDatesController.dart';
import 'package:the_disease_fighter/services/sessions/controllers/updateSession.dart';

class EditAppointment extends StatefulWidget {
  final data;
  EditAppointment({this.data});

  @override
  _EditAppointmentState createState() => _EditAppointmentState();
}

class _EditAppointmentState extends State<EditAppointment> {
  bool _showBanner = false;
  String? _selectedDay;
  List<String> _days = [];
  List<String> _times = [];
  String? _selectedTime;
  String? _periodId;
  String? _errorMessage;
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  GetDoctorDatesController _doctorDatesController = GetDoctorDatesController();
  UpdateSessionController _updateSessionController = UpdateSessionController();

  Future _loadDoctorDates() async {
    var data = await _doctorDatesController.getDoctorDates(
        doctorId: widget.data.doctorId);
    List<String> temp = [];
    for (var i = 0; i < data!.dates!.length; i++) {
      temp.add(data.dates![i].day.toString());
    }
    _days = temp;
    return Future.value(data);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Column(
              children: [
                _appointCard(),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        FutureBuilder<dynamic>(
                            future: _loadDoctorDates(),
                            builder: (BuildContext context,
                                AsyncSnapshot<dynamic> snapshot) {
                              if (!snapshot.hasData && !snapshot.hasError) {
                                return Container(
                                    alignment: Alignment.center,
                                    height:
                                        MediaQuery.of(context).size.height * .6,
                                    child: CircularProgressIndicator());
                              } else {
                                if (snapshot.hasError) {
                                  return Padding(
                                    padding: EdgeInsets.all(15),
                                    child: Center(
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
                                            'Failed To Load Doctor Available Appointments',
                                            style: TextStyle(
                                                color: subTextColor,
                                                fontSize: 16),
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                } else {
                                  return Form(
                                    key: _formKey,
                                    child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          Text(
                                        Languages.of(context)!
                                        .bookAppointment['note'].toString(),
                                            style:
                                                TextStyle(color: subTextColor),
                                          ),
                                          SizedBox(
                                            height: 15,
                                          ),
                                          DropDownList(
                                            value: _selectedDay,
                                            getValue: (value) {
                                              List<String> temp = [];
                                              print(snapshot.data.dates![0]
                                                  .availableDates[0].time
                                                  .toString());
                                              for (var i = 0;
                                                  i < _days.length;
                                                  i++) {
                                                if (snapshot
                                                        .data.dates[i].day ==
                                                    value) {
                                                  for (var y = 0;
                                                      y <
                                                          snapshot
                                                              .data
                                                              .dates[i]
                                                              .availableDates
                                                              .length;
                                                      y++) {
                                                    if (snapshot
                                                            .data
                                                            .dates[i]
                                                            .availableDates[y]
                                                            .isAvailable ==
                                                        false) {
                                                      temp.add(snapshot
                                                          .data
                                                          .dates![i]
                                                          .availableDates[y]
                                                          .time
                                                          .toString());
                                                    }
                                                  }
                                                }
                                              }
                                              print(temp[0]);
                                              setState(() {
                                                _times = temp;
                                                _selectedDay = value;
                                              });
                                            },
                                            items: _days,
                                            hintText: Languages.of(context)!
                                                .bookAppointment['day'].toString(),
                                            labelText: Languages.of(context)!
                                                .bookAppointment['hintDay'].toString(),
                                          ),
                                          DropDownList(
                                            value: _selectedTime,
                                            getValue: (value) {
                                              String? temp;
                                              for (var i = 0;
                                                  i < _days.length;
                                                  i++) {
                                                for (var y = 0;
                                                    y <
                                                        snapshot
                                                            .data
                                                            .dates[i]
                                                            .availableDates
                                                            .length;
                                                    y++) {
                                                  if (snapshot
                                                          .data
                                                          .dates![i]
                                                          .availableDates[y]
                                                          .time ==
                                                      value) {
                                                    temp = snapshot
                                                        .data
                                                        .dates![i]
                                                        .availableDates[y]
                                                        .id
                                                        .toString();
                                                  }
                                                }
                                              }
                                              setState(() {
                                                _selectedTime = value;
                                                _periodId = temp;
                                              });
                                            },
                                            items: _times,
                                            hintText: Languages.of(context)!
                                                .bookAppointment['time'].toString(),
                                            labelText: Languages.of(context)!
                                                .bookAppointment['hintTime'].toString(),
                                          ),
                                        ]),
                                  );
                                }
                              }
                            }),
                        _item(context,
                            labelText: Languages.of(context)!
                                .bookAppointment['nameLabel'],
                            data: widget.data.name.toString()),
                        _item(context,
                            labelText: Languages.of(context)!
                                .bookAppointment['genderLabel'],
                            data: widget.data.gender.toString()),
                        _item(context,
                            labelText: Languages.of(context)!
                                .bookAppointment['phoneLabel'],
                            data: widget.data.phone.toString()),
                        _item(context,
                            labelText: Languages.of(context)!
                                .bookAppointment['appointmentNote'],
                            data: widget.data.comment.toString()),
                      ]),
                ),
              ],
            ),
          ),
          _showBanner
              ? SizedBox(
            height: 150,
                child: ErrorMaterialBanner(
                    errorMessage: _errorMessage,
                    fun: () => setState(() {
                          _showBanner = false;
                        })),
              )
              : SizedBox()
        ],
      ),
      bottomNavigationBar: BottomAppBar(
        color: Colors.transparent,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 7),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              MaterialButton(
                minWidth: MediaQuery.of(context).size.width * .3,
                height: 50,
                shape: RoundedRectangleBorder(
                  side: BorderSide(color: subTextColor),
                  borderRadius: BorderRadius.circular(50),
                ),
                onPressed: () => Navigator.pop(context),
                child: Text(
                  Languages.of(context)!.bookAppointment['cancelBtn'],
                  style: TextStyle(fontSize: 16, color: subTextColor),
                ),
              ),
              SizedBox(
                width: 10,
              ),
              RoundedButton(
                minWdthRatio: .5,
                fun: _updateSession,
                text: Languages.of(context)!.bookAppointment['saveBTN'],
                borderRadious: 50,
              ),
            ],
          ),
        ),
        elevation: 0.0,
      ),
    );
  }

  Widget _item(BuildContext context, {labelText, data}) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8, horizontal: 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            labelText,
            style: TextStyle(fontSize: 15, color: subTextColor),
          ),
          Container(
              margin: EdgeInsets.symmetric(
                vertical: 7,
              ),
              width: MediaQuery.of(context).size.width,
              padding: EdgeInsets.symmetric(horizontal: 14, vertical: 15),
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                      color: subTextColor.withOpacity(.5),
                      offset: Offset(1.0, 2.0),
                      blurRadius: 4.0,
                      spreadRadius: .4),
                ],
                color: backGroundColor,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Text(
                data,
                style: TextStyle(color: darkBlueColor, fontSize: 16),
              )),
        ],
      ),
    );
  }  Widget _appointCard() {
    return Container(
      padding: EdgeInsets.all(15),
      margin: EdgeInsets.only(top: 40,bottom: 10,left: 10,right: 10),
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
              color: subTextColor.withOpacity(.5),
              offset: Offset(1.0, 2.0),
              blurRadius: 4.0,
              spreadRadius: .4),
        ],
        color: backGroundColor, borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Container(
                width: 75,
                height: 75,
                decoration: BoxDecoration(
                    color: Colors.grey.withOpacity(.5),
                    borderRadius: BorderRadius.circular(10),
                    image: DecorationImage(
                        image:
                        NetworkImage(widget.data.doctorAvatar.toString()),
                        fit: BoxFit.cover)),
              ),
              SizedBox(
                width: 15,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.data.doctorName.toString(),
                    style: TextStyle(
                        fontSize: 18,
                        color: darkBlueColor,
                        fontWeight: FontWeight.w600),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    '${widget.data.docSpecialization.toString()} Specialist',
                    style: TextStyle(
                      color: subTextColor,
                    ),
                  )
                ],
              )
            ],
          ),
        ],
      ),
    );
  }



  Future _updateSession() async {
    if (_formKey.currentState!.validate()) {
      LoaderDialog().onLoading(context);
      setState(() {
        _showBanner = false;
      });
      final data = await _updateSessionController.updateSession(
        time: _selectedTime,
        day: _selectedDay,
        selectedPeriodId: _periodId,
        previousPeriodId:  widget.data.periodId.toString()
        ,
        sessionId: widget.data.id.toString(),
      );
      if (await data['success']) {
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (context) => MyAppointments(
                      showSnackBar: true,
                      snackBarMessage:  Languages.of(context)!
                          .bookAppointment['editText'],
                    )));
      } else {
        setState(() {
          _errorMessage = data['message'].toString();
          _showBanner = true;
        });
        Navigator.pop(context);
      }
    }
  }
}

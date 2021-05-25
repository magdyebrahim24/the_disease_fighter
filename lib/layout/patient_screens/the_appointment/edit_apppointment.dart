import 'package:flutter/material.dart';
import 'package:the_disease_fighter/layout/drawer/drawer_screens/patient/my_appointments/my_appointments.dart';
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

  const EditAppointment({this.data});

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
                Container(
                    alignment: Alignment.center,
                    margin: EdgeInsets.only(bottom: 25),
                    padding: EdgeInsets.only(top: 25),
                    width: MediaQuery.of(context).size.width,
                    height: 240,
                    decoration: BoxDecoration(
                        color: primaryColor.withOpacity(.8),
                        borderRadius: BorderRadius.only(
                          bottomRight: Radius.circular(40),
                          bottomLeft: Radius.circular(40),
                        )),
                    child: Column(
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
                                  image: NetworkImage(
                                      widget.data.doctorAvatar.toString()),
                                  fit: BoxFit.cover),
                              shape: BoxShape.circle,
                              border: Border.all(
                                  color: Color(0xffFDFDFD), width: 2),
                              color: backGroundColor),
                          margin: EdgeInsets.all(10),
                          height: 120,
                          width: 120,
                        ),
                        Text(
                          widget.data.doctorName.toString(),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: darkBlueColor,
                            fontSize: 20,
                          ),
                        ),
                        SizedBox(
                          height: 7,
                        ),
                        Text(
                          'doc Specialist need',
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            fontSize: 16,
                          ),
                        ),
                      ],
                    )),
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
                                            'Note : you can edit only appointment date and time',
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
                                            hintText: 'Select Day',
                                            labelText: 'Day',
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
                                            hintText: 'Select Time',
                                            labelText: 'Time',
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
              ? ErrorMaterialBanner(
                  errorMessage: _errorMessage,
                  fun: () => setState(() {
                        _showBanner = false;
                      }))
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
      padding: EdgeInsets.symmetric(vertical: 7, horizontal: 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            labelText,
            style: TextStyle(fontSize: 15, color: subTextColor),
          ),
          Container(
              // alignment: Alignment.centerLeft,
              margin: EdgeInsets.symmetric(
                vertical: 7,
              ),
              width: MediaQuery.of(context).size.width,
              padding: EdgeInsets.symmetric(horizontal: 14, vertical: 15),
              decoration: BoxDecoration(
                color: backGroundColor,
                border: Border.all(
                    width: 1, color: Color(0xff707070).withOpacity(.15)),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Text(
                data,
                style: TextStyle(color: darkBlueColor, fontSize: 16),
              )),
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
        previousPeriodId: '12',
        sessionId: widget.data.id.toString(),
      );
      if (await data['success']) {
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (context) => MyAppointments(
                      showSnackBar: true,
                      snackBarMessage: 'Appointment Edited Successfully',
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

import 'package:flutter/material.dart';
import 'package:the_disease_fighter/layout/doctor-screens/doctor_home/doctor_home.dart';
import 'package:the_disease_fighter/localizations/localization/language/languages.dart';
import 'package:the_disease_fighter/material/constants.dart';
import 'package:the_disease_fighter/material/inductors/loader_dialog.dart';
import 'package:the_disease_fighter/material/widgets/drop-downlist.dart';
import 'package:the_disease_fighter/material/widgets/no_internet_widget.dart';
import 'package:the_disease_fighter/services/doctors/controllers/getDoctorDatesController.dart';
import 'package:the_disease_fighter/services/sessions/controllers/updateSession.dart';

class DelayMeeting extends StatefulWidget {
  final docId;
  final data;

  DelayMeeting({this.docId, @required this.data});
  @override
  _DelayMeetingState createState() => _DelayMeetingState();
}

class _DelayMeetingState extends State<DelayMeeting> {
  UpdateSessionController _updateSessionController = UpdateSessionController();

  GetDoctorDatesController _doctorDatesController = GetDoctorDatesController();

  String? _selectedDay;

  List<String> _days = [];

  List<String> _times = [];

  String? _selectedTime;

  String? _periodId;

  String? _errorMessage;

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  Future _loadDoctorDates() async {
    var data =
        await _doctorDatesController.getDoctorDates(doctorId: widget.docId);
    List<String> temp = [];
    for (var i = 0; i < data!.dates!.length; i++) {
      temp.add(data.dates![i].day.toString());
    }
    _days = temp;
    return Future.value(data);
  }

  Future _updateSession() async {
    if (_formKey.currentState!.validate()) {
      _errorMessage = null;
      LoaderDialog().onLoading(context);
      print(widget.data.id.toString());
      final data = await _updateSessionController.updateSession(
        time: _selectedTime,
        day: _selectedDay,
        selectedPeriodId: _periodId,
        previousPeriodId: widget.data.periodId.toString(),
        sessionId: widget.data.id.toString(),
      );
      if (await data['success']) {
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => DoctorHome(),
            ));
      } else {
        setState(() {
          _errorMessage = data['message'].toString();
        });
        Navigator.pop(context);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<dynamic>(
          future: _loadDoctorDates(),
          builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
            if (!snapshot.hasData && !snapshot.hasError) {
              return Center(child: CircularProgressIndicator());
            } else {
              if (snapshot.hasError) {
                return FailLoadWidget(
                  fun: () {
                    setState(() {
                      _loadDoctorDates();
                    });
                  },
                );
              } else {
                return Form(
                  key: _formKey,
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(15, 45, 15, 15),
                    child: SingleChildScrollView(
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            SizedBox(
                            height: 20,
                          ),
                            _appointCard(),
                            SizedBox(
                              height: 15,
                            ),
                            Text(
                              Languages.of(context)!
                                  .bookAppointment['note'],
                              style: TextStyle(color: subTextColor),
                            ),
                            SizedBox(
                              height: 25,
                            ),
                            DropDownList(
                              value: _selectedDay,
                              getValue: (value) {
                                List<String> temp = [];
                                print(snapshot
                                    .data.dates![0].availableDates[0].time
                                    .toString());
                                for (var i = 0; i < _days.length; i++) {
                                  if (snapshot.data.dates[i].day == value) {
                                    for (var y = 0;
                                        y <
                                            snapshot.data.dates[i]
                                                .availableDates.length;
                                        y++) {
                                      if (snapshot.data.dates[i]
                                              .availableDates[y].isAvailable ==
                                          false) {
                                        temp.add(snapshot.data.dates![i]
                                            .availableDates[y].time
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
                            SizedBox(
                              height: 10,
                            ),
                            DropDownList(
                              value: _selectedTime,
                              getValue: (value) {
                                String? temp;
                                for (var i = 0; i < _days.length; i++) {
                                  for (var y = 0;
                                      y <
                                          snapshot.data.dates[i].availableDates
                                              .length;
                                      y++) {
                                    if (snapshot.data.dates![i]
                                            .availableDates[y].time ==
                                        value) {
                                      temp = snapshot
                                          .data.dates![i].availableDates[y].id
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
                            _errorMessage != null
                                ? Text(
                                    _errorMessage.toString(),
                                    style: TextStyle(color: subTextColor),
                                  )
                                : SizedBox(),
                            SizedBox(
                              height: MediaQuery.of(context).size.height * .17,
                            ),
                            MaterialButton(
                              minWidth: MediaQuery.of(context).size.width,
                              height: 45,
                              color: primaryColor,
                              shape: RoundedRectangleBorder(
                                side: BorderSide(
                                    color: primaryColor.withOpacity(.2)),
                                borderRadius: BorderRadius.circular(15),
                              ),
                              onPressed: _updateSession,
                              child: Text(
                                Languages.of(context)!
                                    .bookAppointment['saveBTN'],
                                style: TextStyle(
                                    fontSize: 16, color: Colors.white),
                              ),
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            MaterialButton(
                              minWidth: MediaQuery.of(context).size.width,
                              height: 45,
                              color: backGroundColor,
                              shape: RoundedRectangleBorder(
                                side: BorderSide(
                                    color: subTextColor.withOpacity(.2)),
                                borderRadius: BorderRadius.circular(15),
                              ),
                              onPressed: () => Navigator.pop(context),
                              child: Text(
                                Languages.of(context)!
                                    .bookAppointment['cancelBtn'],
                                style: TextStyle(
                                    fontSize: 16, color: subTextColor),
                              ),
                            ),
                          ]),
                    ),
                  ),
                );
              }
            }
          }),
      backgroundColor: Colors.white,
    );
  }

  Widget _appointCard() {
    return Container(
      padding: EdgeInsets.all(15),
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(boxShadow: [
        BoxShadow(
            color: subTextColor.withOpacity(.5),
            offset: Offset(1.0, 2.0),
            blurRadius: 4.0,
            spreadRadius: .4),
      ], color: backGroundColor, borderRadius: BorderRadius.circular(20)),
      child: Column(
        children: [
          Row(
            children: [
              Container(
                width: 60,
                height: 60,
                decoration: BoxDecoration(
                    color: Colors.grey.withOpacity(.5),
                    shape: BoxShape.circle,
                    image: DecorationImage(
                        image:
                            NetworkImage(widget.data.patientAvatar.toString()),
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
                    widget.data.name.toString(),
                    style: TextStyle(
                        fontSize: 17,
                        color: darkBlueColor,
                        fontWeight: FontWeight.w500),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                    widget.data.phone.toString(),
                    style: TextStyle(
                      color: subTextColor,
                    ),
                  )
                ],
              )
            ],
          ),
          SizedBox(
            height: 15,
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 20),
            padding: EdgeInsets.all(13),
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Color(0xffBCBBBB),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.access_time,
                  color: Colors.white,
                  // size: 15,
                ),
                SizedBox(
                  width: 5,
                ),
                Expanded(
                  child: Text(
                    '${widget.data.day.toString()}, ${widget.data.date.toString()} , ${widget.data.time.toString()} ${widget.data.amPm.toString()}',
                    style: TextStyle(color: Colors.white),
                    maxLines: 3,
                    textAlign: TextAlign.center,
                    overflow: TextOverflow.ellipsis,
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}

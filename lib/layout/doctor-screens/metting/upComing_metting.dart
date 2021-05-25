import 'package:flutter/material.dart';
import 'package:the_disease_fighter/layout/doctor-screens/doctor_home/doctor_home.dart';
import 'package:the_disease_fighter/layout/doctor-screens/metting/start_meeting.dart';
import 'package:the_disease_fighter/material/bottons/circleBtn.dart';
import 'package:the_disease_fighter/material/constants.dart';
import 'package:the_disease_fighter/material/widgets/drop-downlist.dart';
import 'package:the_disease_fighter/material/widgets/meeting%20info.dart';
import 'package:the_disease_fighter/material/widgets/time-date-field.dart';
import 'package:the_disease_fighter/services/doctorScreens/controllers/get_one_session_controller.dart';

class UpComingMeeting extends StatefulWidget {
  final sessionId;

  const UpComingMeeting({this.sessionId});

  @override
  _UpComingMeetingState createState() => _UpComingMeetingState();
}

class _UpComingMeetingState extends State<UpComingMeeting> {
  var info;
  GetOneSessionController _getOneSessionController = GetOneSessionController();

  Future _getSessionData() async {
    var data = await _getOneSessionController.getOneSession(
      sessionId: widget.sessionId,
    );
    info = data;
    return data;
  }

  late String appointmentTime;
  late DateTime fromTime;

  _getAppointmentDate(DateTime phone) {
    setState(() {
      // this.fromTime = phone;
    });
  }

  _getAppointmentTime(String val) {
    setState(() {
      appointmentTime = val;
    });
  }

  Future _asyncConfirmDialog(BuildContext context) async {
    return showDialog(
      context: context,
      barrierDismissible: false, // user must tap button for close dialog!
      builder: (BuildContext context) {
        return AlertDialog(
          contentPadding: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
          buttonPadding: EdgeInsets.symmetric(horizontal: 20),
          content: Container(
            height: 300,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                BasicDateField(
                  helperText: 'Select Appointment Date',
                  label: 'Date',
                  fun: _getAppointmentDate,
                ),
                DropDownList(
                  value: appointmentTime,
                  getValue: _getAppointmentTime,
                  items: [
                    '08:00 pm',
                    '08:30 pm',
                    '09:00 pm',
                    '09:30 pm',
                    '10:00 pm',
                    '10:30 pm',
                  ],
                  hintText: '${DateTime.now().hour}:${DateTime.now().minute}',
                  labelText: 'Time',
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    InkWell(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Container(
                        height: 45,
                        width: MediaQuery.of(context).size.width * .3,
                        child: Center(
                          child: Text(
                            "Cancel",
                            style: TextStyle(
                                color: greyColor,
                                fontSize: 12,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: backGroundColor,
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    InkWell(
                      onTap: () => Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => DoctorHome())),
                      child: Container(
                        width: MediaQuery.of(context).size.width * .3,
                        height: 45,
                        child: Center(
                          child: Text(
                            "Done",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 12,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: primaryColor,
                        ),
                      ),
                    ),
                  ],
                ),
                InkWell(
                  onTap: () {
                    Navigator.pop(context, [true]);
                  },
                  //=> Navigator.pushReplacement(context,
                  //MaterialPageRoute(builder: (context) => DoctorHome())),
                  child: Container(
                    margin: EdgeInsets.symmetric(
                      horizontal: 20,
                    ),
                    width: MediaQuery.of(context).size.width,
                    height: 45,
                    child: Center(
                      child: Text(
                        "Delete Meeting",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: Color(0xffE13239),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _profilePicCard(BuildContext context, imgUrl, name) {
    return Container(
      margin: EdgeInsets.fromLTRB(0, 10, 0, 10),
      padding: EdgeInsets.symmetric(vertical: 20, horizontal: 10),
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: primaryColor.withOpacity(.1),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            margin: EdgeInsets.only(bottom: 10),
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: NetworkImage(imgUrl.toString()), fit: BoxFit.cover),
                shape: BoxShape.circle,
                border: Border.all(color: Color(0xffFDFDFD), width: 2),
                color: backGroundColor),
            height: 90,
            width: 90,
          ),
          Text(
            name.toString(),
            style: TextStyle(
                color: darkBlueColor,
                fontSize: 23,
                fontWeight: FontWeight.bold),
          ),
          SizedBox(
            height: 20,
          ),
          InkWell(
            onTap: () {
              _asyncConfirmDialog(context);
            },
            child: Container(
              width: MediaQuery.of(context).size.width * .7,
              height: 50,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Center(
                child: Text(
                  "Delay Meeting",
                  style: TextStyle(
                      color: primaryColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 16),
                ),
              ),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          InkWell(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => StartMeeting(
                            data: info.session,
                            sessionId: widget.sessionId,
                          )));
            },
            child: Container(
              width: MediaQuery.of(context).size.width * .7,
              height: 50,
              decoration: BoxDecoration(
                color: primaryColor,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Center(
                child: Text(
                  "Start Meeting",
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 16),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: FutureBuilder<dynamic>(
          future: _getSessionData(),
          builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Container(
                  height: 222,
                  alignment: Alignment.center,
                  child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Column(
                children: [
                  AppBar(
                    elevation: 0,
                    leading: CircleButton(
                      icn: Icons.arrow_back,
                      fun: () => Navigator.pop(context),
                      color: primaryColor,
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * .35,
                  ),
                  IconButton(
                      icon: Icon(
                        Icons.refresh,
                        color: primaryColor,
                        size: 40,
                      ),
                      onPressed: () {
                        setState(() {
                          _getSessionData();
                        });
                      }),
                  SizedBox(
                    height: 15,
                  ),
                  Text(
                    'Failed To Load',
                    style: TextStyle(color: subTextColor, fontSize: 16),
                  ),
                ],
              );
            } else {
              return SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 15),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      AppBar(
                        elevation: 0.0,
                        leading: IconButton(
                          icon: Icon(
                            Icons.arrow_back_outlined,
                            color: primaryColor,
                          ),
                          onPressed: () {
                            Navigator.pop(context, [true]);
                          },
                        ),
                        centerTitle: true,
                        title: Text(
                          "Meeting",
                          style: TextStyle(color: primaryColor, fontSize: 16),
                        ),
                      ),
                      //SizedBox(
                      // height: 15,
                      // ),
                      _profilePicCard(
                          context,
                          snapshot.data.session.patientAvatar.toString(),
                          snapshot.data.session.name.toString()),
                      MeetingInfo(
                        color: lightGreyColor,
                        width: null,
                        text: snapshot.data.session.date.toString(),
                        widget: Icon(
                          Icons.calendar_today_rounded,
                          color: primaryColor,
                        ),
                      ),
                      MeetingInfo(
                        color: lightGreyColor,
                        width: MediaQuery.of(context).size.width,
                        text:
                            '${snapshot.data.session.time.toString()}  ${snapshot.data.session.amPm.toString()}',
                        widget: Icon(Icons.access_time, color: primaryColor),
                      ),
                      MeetingInfo(
                        color: lightGreyColor,
                        width: null,
                        text: snapshot.data.session.name.toString(),
                        widget: Icon(
                          Icons.person,
                          color: primaryColor,
                        ),
                      ),
                      Row(
                        children: [
                          MeetingInfo(
                            color: lightGreyColor,
                            width: MediaQuery.of(context).size.width * .4,
                            text: snapshot.data.session.gender.toString(),
                            widget: Icon(Icons.wc, color: primaryColor),
                          ),
                          SizedBox(
                            width: 20,
                          ),
                          Expanded(
                              child: MeetingInfo(
                            color: lightGreyColor,
                            width: null,
                            text: snapshot.data.session.phone.toString(),
                            widget: Icon(
                              Icons.call,
                              color: primaryColor,
                            ),
                          ))
                        ],
                      ),
                      Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                        //height: 110,
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: lightGreyColor,
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Comment",
                              style: TextStyle(
                                  color: darkBlueColor,
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              snapshot.data.session.comment.toString(),
                              style: TextStyle(
                                fontSize: 11,
                                color: subTextColor,
                              ),
                            ),
                          ],
                        ),
                      ),

                      //  MeetingInfo(
                      //  color: lightGreyColor,
                      //   width: MediaQuery.of(context).size.width,
                      //   text: snapshot.data.session.phone.toString(),
                      //    widget: Icon(Icons.phone, color: primaryColor)),
                    ],
                  ),
                ),
              );
            }
          }),
      /*appBar: AppBar(
        elevation: 0.0,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_outlined,
            color: primaryColor,
          ),
          onPressed: () {
            Navigator.pop(context, [true]);
          },
        ),
        centerTitle: true,
        title: Text(
          "Meeting",
          style: TextStyle(color: primaryColor, fontSize: 16),
        ),
      ),*/
      /*body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              //SizedBox(
              // height: 15,
              // ),
              //_profilePicCard(context,widget.data.),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                height: 110,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: lightGreyColor,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "About",
                      style: TextStyle(
                          color: darkBlueColor,
                          fontSize: 12,
                          fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 10,),
                    Text(
                      "Lorem Ipsum is simply dummy text the printing typesetting and  industry Lorem Ipsum has been the industry's standard dummy text  ever since the 1500s.",
                      style: TextStyle(
                        fontSize: 10,
                        color: subTextColor,
                      ),
                    ),

                  ],
                ),
              ),

              MeetingInfo(
                color: lightGreyColor,
                width: MediaQuery.of(context).size.width,
                text: "alia12@example.com",
                widget: Icon(Icons.email, color: primaryColor),
              ),

              MeetingInfo(
                  color: lightGreyColor,
                  width: MediaQuery.of(context).size.width,
                  text: "+20 1334 5678 988",
                  widget: Icon(Icons.phone, color: primaryColor)),
              Row(
                children: [
                  MeetingInfo(
                    color: lightGreyColor,
                    width: MediaQuery.of(context).size.width * .4,
                    text: "Female",
                    widget: Icon(Icons.wc, color: primaryColor),
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  Expanded(
                      child: MeetingInfo(
                        color: lightGreyColor,
                    width: null,
                    text: "21 / 02 / 1999",
                    widget: Icon(
                      Icons.calendar_today_rounded,
                      color: primaryColor,
                    ),
                  ))
                ],
              ),

            ],
          ),
        ),
      ),*/
    );
  }
}

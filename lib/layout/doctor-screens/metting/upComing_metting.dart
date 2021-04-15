import 'package:flutter/material.dart';
import 'package:the_disease_fighter/layout/doctor-screens/doctor_home/doctot_home.dart';
import 'package:the_disease_fighter/layout/doctor-screens/metting/start_meeting.dart';
import 'package:the_disease_fighter/material/constants.dart';
import 'package:the_disease_fighter/material/widgets/drop-downlist.dart';
import 'package:the_disease_fighter/material/widgets/time-date-field.dart';

class UpComingMeeting extends StatefulWidget {
  @override
  _UpComingMeetingState createState() => _UpComingMeetingState();
}
class _UpComingMeetingState extends State<UpComingMeeting> {
  String appointmentTime;
  DateTime fromTime;

  _getAppointmentDate(DateTime phone) {
    setState(() {
      this.fromTime = phone;
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
              height:300,
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
                      width: MediaQuery
                          .of(context)
                          .size
                          .width * .3,
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
                    SizedBox(width: 10,),
                    InkWell(
                      onTap: () =>
                          Navigator.pushReplacement(context,
                              MaterialPageRoute(builder: (context) => DoctorHome())),
                      child: Container(
                        width: MediaQuery
                            .of(context)
                            .size
                            .width * .3,
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
                      Navigator.pop(context,[true]);
                    },
                    //=> Navigator.pushReplacement(context,
                            //MaterialPageRoute(builder: (context) => DoctorHome())),
                    child: Container(
                      margin: EdgeInsets.symmetric(
                        horizontal: 20,
                      ),
                      width: MediaQuery
                          .of(context)
                          .size
                          .width ,
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
    Widget _profilePicCard(BuildContext context) {
      return Container(
        margin: EdgeInsets.fromLTRB(0, 10, 0, 10),
        padding: EdgeInsets.symmetric(vertical: 20, horizontal: 10),
        width: MediaQuery
            .of(context)
            .size
            .width,
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
                      image: AssetImage("assets/images/img_1.png"),
                      fit: BoxFit.cover),
                  shape: BoxShape.circle,
                  border: Border.all(color: Color(0xffFDFDFD), width: 2),
                  color: backGroundColor),
              height: 90,
              width: 90,
            ),
            Text(
              "Dr. Christina Frazier",
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
                width: MediaQuery
                    .of(context)
                    .size
                    .width * .7,
                height: 40,
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
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => StartMeeting()));
              },
              child: Container(
                width: MediaQuery
                    .of(context)
                    .size
                    .width * .7,
                height: 40,
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

    Widget _infoCard(double width,
        String text,
        Widget widget,) {
      return Container(
        padding: EdgeInsets.only(
          left: 10,
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: Color(0xffE6F7FD),
        ),
        width: width,
        height: 50,
        child: Row(
          children: [
            Container(
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(7)),
              width: 40,
              height: 40,
              child: Center(child: widget),
            ),
            SizedBox(
              width: 20,
            ),
            Text(
              text,
              style: TextStyle(color: darkBlueColor, fontSize: 12),
            )
          ],
        ),
      );
    }

    @override
    Widget build(BuildContext context) {
      return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
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
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                //SizedBox(
                 // height: 15,
               // ),
                _profilePicCard(context),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                  height: 110,
                  width: MediaQuery
                      .of(context)
                      .size
                      .width,
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
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        "Lorem Ipsum is simply dummy text the printing typesetting and  industry Lorem Ipsum has been the industry's standard dummy text  ever since the 1500s.",
                        style: TextStyle(
                          fontSize: 10,
                          color: subTextColor,
                        ),
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                _infoCard(
                  MediaQuery
                      .of(context)
                      .size
                      .width,
                  "alia12@example.com",
                  Icon(Icons.email, color: primaryColor),
                ),
                SizedBox(
                  height: 10,
                ),
                _infoCard(MediaQuery
                    .of(context)
                    .size
                    .width, "+20 1334 5678 988",
                    Icon(Icons.phone, color: primaryColor)),
                SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    _infoCard(
                      150,
                      "Female",
                      Icon(Icons.wc, color: primaryColor),
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    Expanded(
                        child: _infoCard(
                            null,
                            "21 / 02 / 1999",
                            Icon(
                              Icons.calendar_today_rounded,
                              color: primaryColor,
                            )
                          //ImgButton(img:"assets/icons/calendar .png",fun: (){},imgWidth: 40.0,imgHigh: 40.0,),)

                        ))
                  ],
                ),
              ],
            ),
          ),
        ),
      );
    }
  }

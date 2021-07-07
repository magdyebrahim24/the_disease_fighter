import 'package:flutter/material.dart';
import 'package:the_disease_fighter/layout/doctor-screens/metting/delay_meeting.dart';
import 'package:the_disease_fighter/layout/doctor-screens/metting/start_meeting.dart';
import 'package:the_disease_fighter/localizations/localization/language/languages.dart';
import 'package:the_disease_fighter/material/bottons/circleBtn.dart';
import 'package:the_disease_fighter/material/constants.dart';
import 'package:the_disease_fighter/material/widgets/meeting%20info.dart';
import 'package:the_disease_fighter/material/widgets/no_internet_widget.dart';
import 'package:the_disease_fighter/services/doctorScreens/controllers/get_one_session_controller.dart';
import 'package:intl/intl.dart';
class UpComingMeeting extends StatefulWidget {
  final sessionId;
  final showSnackBar;

   UpComingMeeting({this.sessionId, this.showSnackBar = false});
  @override
  _UpComingMeetingState createState() => _UpComingMeetingState();
}

class _UpComingMeetingState extends State<UpComingMeeting> {
  var info;
  GetOneSessionController _getOneSessionController = GetOneSessionController();

  String? docId;

  Future _getSessionData() async {
    var data = await _getOneSessionController.getOneSession(
      sessionId: widget.sessionId,
    );
    docId = data.session![0].doctorId.toString();
    info = data.session![0];
    return data;
  }

  String? appointmentTime;

  Widget _profilePicCard(BuildContext context, imgUrl, name , data) {
    return Container(
      margin: EdgeInsets.fromLTRB(0, 10, 0, 10),
      padding: EdgeInsets.symmetric(vertical: 20, horizontal: 10),
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        color: primaryColor.withOpacity(.1),
        borderRadius: BorderRadius.circular(10),
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
            height: 120,
            width: 120,
          ),
          Text(
            name.toString(),
            style: TextStyle(
                color: darkBlueColor,
                fontSize: 20,
                fontWeight: FontWeight.bold),
          ),
          SizedBox(
            height: 20,
          ),
          InkWell(
            onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (ctx) => DelayMeeting(
                      data: info,
                          docId: docId,
                        ))),
            child: Container(
              width: MediaQuery.of(context).size.width * .7,
              height: 45,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Center(
                child: Text(
                Languages.of(context)!
        .doctorUpcomingMeeting['delayBtn'],
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
    onTap: ()=>Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => StartMeeting(
                      data: data,
                      sessionId: widget.sessionId,
                    ))) ,
            // onTap: ()=>
            //   currentDayTime.toString()  == data.date.toString() ?
            //   Navigator.push(
            //       context,
            //       MaterialPageRoute(
            //           builder: (context) => StartMeeting(
            //                 data: data,
            //                 sessionId: widget.sessionId,
            //               ))) : errorAlertFun(context,text:  Languages.of(context)!
        // .doctorUpcomingMeeting['startNote']+ '${data.date}'),
            child: Container(
              width: MediaQuery.of(context).size.width * .7,
              height: 45,
              decoration: BoxDecoration(
                color: primaryColor,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Center(
                child: Text(
    Languages.of(context)!
        .doctorUpcomingMeeting['startBtn'].toString(),
                  style: TextStyle(
                      color:  Colors.white,
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
  var currentDayTime;
  @override
  void initState() {

    var now = new DateTime.now();
    var formatter = new DateFormat('yyyy-MM-dd');
    String formattedDate = formatter.format(now);
    currentDayTime = formattedDate ;
    print(formattedDate); // 2016-01-25
    widget.showSnackBar
        ? Future.delayed(Duration.zero, () async {
      snackBarr();
    })
    // ignore: unnecessary_statements
        : null;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: FutureBuilder<dynamic>(
          future: _getSessionData(),
          builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Column(children: [
                AppBar(
                  elevation: 0,
                  leading: CircleButton(
                    icn: Icons.arrow_back,
                    fun: () => Navigator.pop(context),
                    color: primaryColor,
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * .3,
                ),
                FailLoadWidget(
                  fun: () {
                    setState(() {
                      _getSessionData();
                    });
                  },
                )
              ]);
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
                            Languages.of(context)!
                                .doctorUpcomingMeeting['tittle'].toString(),
                          style: TextStyle(color: primaryColor, fontSize: 16),
                        ),
                      ),
                      _profilePicCard(
                          context,
                          snapshot.data.session[0].patientAvatar.toString(),
                          snapshot.data.session[0].name.toString(),
                          snapshot.data.session[0],
                      ),
                      MeetingInfo(
                        color: lightGreyColor,
                        width: null,
                        text: '${snapshot.data.session[0].day.toString()} - ${snapshot.data.session[0].date.toString()}',
                        widget: Icon(
                          Icons.calendar_today_rounded,
                          color: primaryColor,
                        ),
                      ),
                      MeetingInfo(
                        color: lightGreyColor,
                        width: MediaQuery.of(context).size.width,
                        text:
                            '${snapshot.data.session[0].time.toString()}  ${snapshot.data.session[0].amPm.toString()}',
                        widget: Icon(Icons.access_time, color: primaryColor),
                      ),
                      MeetingInfo(
                        color: lightGreyColor,
                        width: null,
                        text: snapshot.data.session[0].name.toString(),
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
                            text: snapshot.data.session[0].gender.toString(),
                            widget: Icon(Icons.wc, color: primaryColor),
                          ),
                          SizedBox(
                            width: 20,
                          ),
                          Expanded(
                              child: MeetingInfo(
                            color: lightGreyColor,
                            width: null,
                            text: snapshot.data.session[0].phone.toString(),
                            widget: Icon(
                              Icons.call,
                              color: primaryColor,
                            ),
                          ))
                        ],
                      ),
                      Container(
                        margin: EdgeInsets.only(bottom: 15,top: 8),
                        padding:
                            EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                                color: subTextColor.withOpacity(.3),
                                offset: Offset(1.0, 2.0),
                                blurRadius: 2.0,
                                spreadRadius: .2),
                          ],
                          borderRadius: BorderRadius.circular(10),
                          color: lightGreyColor,
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                            Languages.of(context)!
                            .doctorUpcomingMeeting['comment'],
                              style: TextStyle(
                                  color: darkBlueColor,
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              snapshot.data.session[0].comment.toString(),
                              style: TextStyle(
                                fontSize: 11,
                                color: subTextColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }
          }),
    );
  }
  snackBarr() {
    final snackBar = SnackBar(
      content: Text(
        'Appointment Edited Successfully',
        style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
      ),
      backgroundColor: primaryColor,
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
  void errorAlertFun(BuildContext context,{text}) {
    showDialog(
        context: context,
        builder: (context) => Stack(
          children: [
            Positioned(
              bottom: 25,
              right: MediaQuery.of(context).size.width  * .01,
              left: MediaQuery.of(context).size.width  * .01,
              child: AlertDialog(
                  shape:  RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                  ),
                  backgroundColor: Colors.redAccent,
                  contentPadding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                  content: Row(
                    children: [
                      Expanded(child: Text(text.toString(),style: TextStyle(color: Colors.white),textAlign: TextAlign.center,)),
                      MaterialButton(onPressed: (){Navigator.pop(context);},child: Icon(Icons.close,color: Colors.white,size: 20,),height: 25,minWidth: 25,padding: EdgeInsets.all(3),materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,shape:  RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(20)),
                      ),)
                    ],
                  )
              ),
            ),
          ],
        ));
  }

}

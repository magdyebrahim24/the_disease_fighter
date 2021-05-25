import 'package:flutter/material.dart';
import 'package:the_disease_fighter/layout/doctor-screens/metting/upComing_metting.dart';
import 'package:the_disease_fighter/layout/drawer/drawer_screens/patient/favorite/favorite_doctors.dart';
import 'package:the_disease_fighter/localizations/localization/language/languages.dart';
import 'package:the_disease_fighter/material/bottons/circleBtn.dart';
import 'package:the_disease_fighter/material/constants.dart';
import 'package:the_disease_fighter/services/doctorScreens/controllers/filter_sessions_dates_controller.dart';
import 'package:url_launcher/url_launcher.dart';

// ignore: must_be_immutable
class FilteredDates extends StatefulWidget {
  var pickedTime;

  FilteredDates({this.pickedTime});

  @override
  _FilteredDatesState createState() => _FilteredDatesState();
}

class _FilteredDatesState extends State<FilteredDates> {
  FilterSessionByDateController _filterSessionByDateController =
      FilterSessionByDateController();

  Future _filterByDate() async {
    final time = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900, 1, 1),
      lastDate: DateTime.utc(DateTime.now().year + 1),
    );
    if (time != null) {
      setState(() {
        widget.pickedTime = time;
        _loadFilteredSessions();
      });
    }
    print(time.toString().split(" ")[0]);
  }

  Future _loadFilteredSessions() async {
    // var data = await _filterSessionByDateController.getFilteredSessions(sessionDate: widget.pickedTime);
    var data = await _filterSessionByDateController.getFilteredSessions(
        sessionDate: widget.pickedTime.toString().split(" ")[0]);
    //
    return Future.value(data);
  }

  Widget _filteredMeetingCard({data}) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 12, horizontal: 10),
      margin: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
              color: subTextColor,
              offset: Offset(1.0, 2.0),
              blurRadius: 2.0,
              spreadRadius: .2),
        ],
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
      width: MediaQuery.of(context).size.width,
      child: Column(
        children: [
          Row(
            children: [
              Container(
                  height: 93,
                  width: 90,
                  decoration: BoxDecoration(
                    color: greyColor.withOpacity(.5),
                    borderRadius: BorderRadius.circular(10),
                    image: DecorationImage(
                      image: NetworkImage(data.avatar.toString()),
                      fit: BoxFit.contain,
                    ),
                  )),
              SizedBox(
                width: 10,
              ),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Text(
                            data.name.toString(),
                            maxLines: 2,
                            style: TextStyle(
                              color: darkBlueColor,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        MaterialButton(
                          onPressed: () => launch("tel://01552154105"),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                          child: Icon(
                            Icons.phone_rounded,
                            color: Colors.white,
                            size: 16,
                          ),
                          height: 30,
                          minWidth: 30,
                          padding: EdgeInsets.zero,
                          materialTapTargetSize:
                              MaterialTapTargetSize.shrinkWrap,
                          color: primaryColor,
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Container(
                      child: Row(
                        children: [
                          Icon(
                            Icons.access_time_outlined,
                            color: subTextColor,
                            size: 19,
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Text(
                            '${data.day.toString()}, ${data.date.toString()} , ${data.time.toString()}${data.amPm.toString()}',
                            maxLines: 3,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontSize: 12,
                              color: subTextColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    MaterialButton(
                      onPressed: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => UpComingMeeting(
                                    sessionId: data.id,
                                  ))),
                      child: Text(
                        Languages.of(context)!.doctorHome['showBtn'],
                        style: TextStyle(
                            fontSize: 12,
                            color: Colors.white,
                            fontWeight: FontWeight.bold),
                      ),
                      height: 33,
                      minWidth: MediaQuery.of(context).size.width * .8,
                      color: primaryColor,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                    )
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        //elevation: 1,
        bottom: PreferredSize(
          preferredSize: Size(50.0, 30.0),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Row(
              children: [
                Text(
                  "${widget.pickedTime.toString().split(" ")[0]} Appointments",
                  style: kHeadStyle,
                ),
              ],
            ),
          ),
        ),
        actions: [
          ImgButton(
            fun: () {
              _filterByDate();
              //Navigator.push(context,
              // MaterialPageRoute(builder: (context) => DoctorHome()));
            },
            img: 'assets/icons/filter.png',
            imgWidth: 16.0,
            imgHigh: 21.0,
          ),
        ],

        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_outlined,
            color: primaryColor,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: FutureBuilder<dynamic>(
          future: _loadFilteredSessions(),
          builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            } else {
              if (snapshot.hasError) {
                return Padding(
                  padding: EdgeInsets.only(
                      top: MediaQuery.of(context).size.height * .15),
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
                              _loadFilteredSessions();
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
                  ),
                );
              } else {
                return snapshot.data.sessions.length != 0 &&
                        snapshot.data.sessions != null
                    // && snapshot.data.containsKey
                    ? ListView.builder(
                        physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: snapshot.data.sessions.length,
                        itemBuilder: (ctx, index) {
                          return _filteredMeetingCard(
                              data: snapshot.data.sessions[index]);
                        },
                      )
                    : EmptyPage();
                //MeetingCard(data:snapshot.data.sessions);

              }
            }
          }),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:the_disease_fighter/layout/doctor-screens/doctor_profile/edit_doctor_info/update_doctor_dates.dart';
import 'package:the_disease_fighter/localizations/localization/language/languages.dart';
import 'package:the_disease_fighter/material/constants.dart';
import 'package:the_disease_fighter/material/widgets/meeting%20info.dart';

class DocInformation extends StatelessWidget {
  final data;

  const DocInformation({Key? key, this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: EdgeInsets.symmetric(vertical: 10),
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 30),
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                      color: subTextColor.withOpacity(0.3),
                      offset: Offset(1.0, 2.0),
                      blurRadius: 2.0,
                      spreadRadius: .2),
                ],
                borderRadius: BorderRadius.circular(10),
                color: backGroundColor,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    Languages.of(context)!
                        .doctorProfile['editProfile']['about']
                        .toString(),
                    style: TextStyle(
                        color: darkBlueColor,
                        fontSize: 15,
                        fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    data.about.toString(),
                    style: TextStyle(
                      fontSize: 14,
                      color: subTextColor,
                    ),
                  ),
                ],
              ),
            ),
            MeetingInfo(
              color: backGroundColor,
              width: MediaQuery.of(context).size.width,
              text: data.email.toString(),
              widget: Icon(Icons.email, color: primaryColor),
            ),
            MeetingInfo(
                color: backGroundColor,
                width: MediaQuery.of(context).size.width,
                text: data.phone.toString(),
                widget: Icon(Icons.phone, color: primaryColor)),
            Row(
              children: [
                MeetingInfo(
                  color: backGroundColor,
                  width: MediaQuery.of(context).size.width * .4,
                  text: data.gender.toString(),
                  widget: Icon(Icons.wc, color: primaryColor),
                ),
                SizedBox(
                  width: 20,
                ),
                Expanded(
                    child: MeetingInfo(
                  color: backGroundColor,
                  width: null,
                  text: data.dob.toString(),
                  widget: Icon(
                    Icons.calendar_today_rounded,
                    color: primaryColor,
                  ),
                ))
              ],
            ),
            MeetingInfo(
              color: backGroundColor,
              width: MediaQuery.of(context).size.width,
              text: data.clinicLocation.toString(),
              widget: Icon(Icons.location_on_rounded, color: primaryColor),
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              margin: EdgeInsets.symmetric(
                vertical: 15,
              ),
              padding: EdgeInsets.symmetric(horizontal: 14, vertical: 20),
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                      color: subTextColor.withOpacity(.3),
                      offset: Offset(1.0, 2.0),
                      blurRadius: 2.0,
                      spreadRadius: .2),
                ],
                color: backGroundColor,
                border: Border.all(
                    width: 1, color: Color(0xff707070).withOpacity(.15)),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          Languages.of(context)!
                              .updateDoctorDates['yourDates']
                              .toString(),
                          style: TextStyle(
                              color: darkBlueColor,
                              fontSize: 15,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      IconButton(
                        color: primaryColor,
                        icon: Icon(
                          FontAwesomeIcons.solidEdit,
                          size: 20,
                        ),
                        onPressed: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (ctx) => UpdateDoctorDates(
                                      showSkip: false,
                                    ))),
                      ),
                    ],
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 5, bottom: 10),
                    child: Divider(
                      thickness: 3,
                    ),
                  ),
                  data.availableDates.length != 0 &&
                          data.availableDates.length != null
                      ? ListView.builder(
                          physics: NeverScrollableScrollPhysics(),
                          padding: EdgeInsets.all(0),
                          shrinkWrap: true,
                          itemCount: data.availableDates.length,
                          itemBuilder: (ctx, index) {
                            return Container(
                              height: 60,
                              width: MediaQuery.of(context).size.width,
                              padding: EdgeInsets.fromLTRB(15, 10, 5, 10),
                              margin: EdgeInsets.symmetric(vertical: 5),
                              child: Row(
                                children: [
                                  Icon(Icons.access_time, color: darkBlueColor),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Expanded(
                                    child: Text(
                                      '${data.availableDates[index].day}, ${data.availableDates[index].startTime} - ${data.availableDates[index].endTime},',
                                      maxLines: 3,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(color: darkBlueColor),
                                    ),
                                  ),
                                ],
                              ),
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(15)),
                            );
                          })
                      : Text(
                          Languages.of(context)!
                              .updateDoctorDates['noDates']
                              .toString(),
                          style: TextStyle(color: subTextColor),
                        )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

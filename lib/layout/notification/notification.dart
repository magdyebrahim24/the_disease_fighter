import 'package:flutter/material.dart';
import 'package:the_disease_fighter/layout/drawer/drawer_screens/patient/favorite/favorite_doctors.dart';
import 'package:the_disease_fighter/layout/notification/rate.dart';
import 'package:the_disease_fighter/localizations/localization/language/languages.dart';
import 'package:the_disease_fighter/material/bottons/circleBtn.dart';
import 'package:the_disease_fighter/material/constants.dart';
import 'package:the_disease_fighter/services/notification/controllers/show_patient_notification_controller.dart';

class Notifications extends StatefulWidget {
  final data;

  const Notifications({Key? key, this.data}) : super(key: key);

  @override
  _NotificationsState createState() => _NotificationsState();
}

class _NotificationsState extends State<Notifications> {
  ShowPatientNotificationController _patientNotificationController =
      ShowPatientNotificationController();

  Future _showPatientNotification() async {
    var data = await _patientNotificationController.getPatientNotification();
    return Future.value(data);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          Languages.of(context)!.notificationScreen['tittle'],
          style: kHeadStyle,
        ),
        leading: CircleButton(
          fun: () => Navigator.pop(context),
          icn: Icons.arrow_back,
          color: primaryColor,
        ),
        centerTitle: true,
      ),
      body: Directionality(
        textDirection: TextDirection.ltr,
        child: FutureBuilder<dynamic>(
            future: _showPatientNotification(),
            builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              } else {
                if (snapshot.hasError) {
                  return Center(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        IconButton(
                            icon: Icon(
                              Icons.refresh,
                              color: primaryColor,
                              size: 40,
                            ),
                            onPressed: () {
                              setState(() {
                                _showPatientNotification();
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
                  return snapshot.data.notifications != null &&
                          snapshot.data.notifications.length != 0
                      ? ListView.builder(
                          padding: EdgeInsets.symmetric(vertical: 10),
                          itemCount: snapshot.data.notifications.length ?? 0,
                          itemBuilder: (ctx, index) {
                            return Padding(
                              padding: EdgeInsets.symmetric(
                                  vertical: 8, horizontal: 15),
                              child: InkWell(
                                onTap: () => Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => RateScreen(
                                              sessionId: snapshot
                                                  .data
                                                  .notifications[index]
                                                  .sessionId,
                                              data: snapshot
                                                  .data.notifications[index],
                                            ))),
                                child: Container(
                                  padding: EdgeInsets.symmetric(
                                      vertical: 15, horizontal: 15),
                                  // margin: EdgeInsets.symmetric(vertical: 8, horizontal: 15),
                                  decoration: BoxDecoration(
                                    color: primaryColor.withOpacity(.17),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10)),
                                  ),
                                  child: Row(
                                    children: [
                                      Container(
                                          margin: EdgeInsets.only(right: 13),
                                          height: 55,
                                          width: 55,
                                          decoration: BoxDecoration(
                                            color: greyColor.withOpacity(.5),
                                            shape: BoxShape.circle,
                                            image: DecorationImage(
                                              image: AssetImage(
                                                  'assets/doctors_img/doc3.jpg'),
                                              fit: BoxFit.cover,
                                            ),
                                          )),
                                      Expanded(
                                          child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text.rich(
                                            TextSpan(
                                              text: snapshot
                                                  .data
                                                  .notifications[index]
                                                  .doctorName
                                                  .toString(),
                                              style: new TextStyle(
                                                fontWeight: FontWeight.bold,
                                                color: darkBlueColor,
                                              ),
                                              children: [
                                                TextSpan(
                                                    text:
                                                        'finished his session with you can rate it now!! ',
                                                    style: new TextStyle(
                                                        fontWeight:
                                                            FontWeight.normal)),
                                              ],
                                            ),
                                          ),
                                          SizedBox(
                                            height: 7,
                                          ),
                                          Text(
                                            snapshot
                                                .data.notifications[index].time
                                                .toString(),
                                            style: TextStyle(
                                              color: subTextColor,
                                              fontSize: 12,
                                              // fontWeight: FontWeight.bold,
                                            ),
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ],
                                      )),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          })
                      : EmptyPage();
                  //MeetingCard(data:snapshot.data.sessions);

                }
              }
            }),
      ),
    );
  }
}

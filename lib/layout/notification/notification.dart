import 'package:flutter/material.dart';
import 'package:the_disease_fighter/layout/notification/widget/notification_card.dart';
import 'package:the_disease_fighter/layout/patient_screens/patient_home/home.dart';
import 'package:the_disease_fighter/localizations/localization/language/languages.dart';
import 'package:the_disease_fighter/material/bottons/circleBtn.dart';
import 'package:the_disease_fighter/material/constants.dart';
import 'package:the_disease_fighter/material/widgets/empty_list_widget.dart';
import 'package:the_disease_fighter/material/widgets/no_internet_widget.dart';
import 'package:the_disease_fighter/services/notification/controllers/show_patient_notification_controller.dart';

class Notifications extends StatefulWidget {
  final data;
  Notifications({this.data});

  @override
  _NotificationsState createState() => _NotificationsState();
}

class _NotificationsState extends State<Notifications> {
  ShowPatientNotificationController _patientNotificationController =
      ShowPatientNotificationController();

  Future _showPatientNotification() async {
    var data = await _patientNotificationController.getPatientNotification();
    List _seenNotificationList = [];
    List _unSeenNotificationList = [];
    for (var item in data.notifications ?? []) {
      if (item.seen == false) {
        _unSeenNotificationList.add(item);
      } else {
        _seenNotificationList.add(item);
      }
    }
    Map notificationData = {
      'un_seen': _unSeenNotificationList,
      'seen': _seenNotificationList,
    };
    return notificationData;
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
          fun: () => Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Home(),)),
          icn: Icons.arrow_back,
          color: primaryColor,
        ),
        centerTitle: true,
        elevation: 0.0,
      ),
      body: FutureBuilder<dynamic>(
          future: _showPatientNotification(),
          builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
            if (!snapshot.hasData && !snapshot.hasError) {
              return Center(child: CircularProgressIndicator());
            } else {
              if (snapshot.hasError) {
                return FailLoadWidget(
                  fun: () {
                    setState(() {
                      _showPatientNotification();
                    });
                  },
                );
              } else {
                return snapshot.data['un_seen'].length == 0 &&
                        snapshot.data['seen'].length == 0
                    ? EmptyListWidget(
                        icon: Icons.notifications_none_rounded,
                        iconSize: 80.0,
                        label:  Languages.of(context)!.notificationScreen['no notification'],
                      )
                    : SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            snapshot.data['un_seen'].length != 0
                                ? Padding(
                                    padding:
                                        EdgeInsets.fromLTRB(15, 25, 15, 10),
                                    child: Text(
                                      'Un Seen Notification',
                                      style: TextStyle(
                                          color: darkBlueColor,
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  )
                                : SizedBox(),
                            snapshot.data['un_seen'].length != 0
                                ? ListView.builder(
                                    shrinkWrap: true,
                                    physics: NeverScrollableScrollPhysics(),
                                    itemCount:
                                        snapshot.data['un_seen'].length ?? 0,
                                    itemBuilder: (ctx, index) {
                                      return NotificationCard(
                                        data: snapshot.data['un_seen'][index] ??
                                            {},
                                      );
                                    })
                                : SizedBox(),
                            snapshot.data['seen'].length != 0
                                ? Container(
                                    height: 5,
                                    color: backGroundColor,
                                    margin: EdgeInsets.symmetric(
                                        horizontal: 20, vertical: 15),
                                  )
                                : SizedBox(),
                            snapshot.data['seen'].length != 0
                                ? Padding(
                                    padding:
                                        EdgeInsets.fromLTRB(15, 10, 15, 10),
                                    child: Text(
                                      'Seen Notification',
                                      style: TextStyle(
                                          color: darkBlueColor,
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  )
                                : SizedBox(),
                            snapshot.data['seen'].length != 0
                                ? ListView.builder(
                                    shrinkWrap: true,
                                    physics: NeverScrollableScrollPhysics(),
                                    itemCount:
                                        snapshot.data['seen'].length ?? 0,
                                    itemBuilder: (ctx, index) {
                                      return NotificationCard(
                                        data:
                                            snapshot.data['seen'][index] ?? {},
                                        seen: true,
                                      );
                                    })
                                : SizedBox(),
                          ],
                        ),
                      );
              }
            }
          }),
    );
  }
}

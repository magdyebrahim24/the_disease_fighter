import 'package:flutter/material.dart';
import 'package:the_disease_fighter/layout/notification/rate.dart';
import 'package:the_disease_fighter/material/bottons/circleBtn.dart';
import 'package:the_disease_fighter/material/constants.dart';

class Notifications extends StatefulWidget {
  @override
  _NotificationsState createState() => _NotificationsState();
}

class _NotificationsState extends State<Notifications> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          'Notifications',
          style: kHeadStyle,
        ),
        leading: CircleButton(
          fun: () => Navigator.pop(context),
          icn: Icons.arrow_back,
          color: primaryColor,
        ),
        centerTitle: true,
      ),
      body: ListView.builder(
          padding: EdgeInsets.symmetric(vertical: 10),
          itemCount: 10,
          itemBuilder: (ctx, index) {
            return Padding(
              padding: EdgeInsets.symmetric(vertical: 8, horizontal: 15),
              child: InkWell(
                onTap: () => Navigator.push(context,
                    MaterialPageRoute(builder: (context) => RateScreen())),
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: 15, horizontal: 15),
                  // margin: EdgeInsets.symmetric(vertical: 8, horizontal: 15),
                  decoration: BoxDecoration(
                    color: primaryColor.withOpacity(.17),
                    borderRadius: BorderRadius.all(Radius.circular(10)),
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
                              image: AssetImage('assets/doctors_img/doc3.jpg'),
                              fit: BoxFit.cover,
                            ),
                          )),
                      Expanded(
                          child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text.rich(
                            TextSpan(
                              text: 'Dr. Christina Frazier ',
                              style: new TextStyle(
                                fontWeight: FontWeight.bold,
                                color: darkBlueColor,
                              ),
                              children: [
                                TextSpan(
                                    text:
                                        'finished his session with you can rate it now!! ',
                                    style: new TextStyle(
                                        fontWeight: FontWeight.normal)),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 7,
                          ),
                          Text(
                            '1 hour ago',
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
          }),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:the_disease_fighter/layout/patient_screens/rate_screen/rate_screen.dart';
import 'package:the_disease_fighter/localizations/localization/language/languages.dart';
import 'package:the_disease_fighter/material/constants.dart';

class NotificationCard extends StatelessWidget {
  final data ;
  final seen;
   NotificationCard({this.data, this.seen = false});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
          vertical: 8, horizontal: 15),
      child: InkWell(
        onTap:!seen ? () =>   Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (context) => RateScreen(
                  sessionId: data
                      .sessionId,
                  data: data
                ))) : null ,
        child: Container(
          padding: EdgeInsets.symmetric(
              vertical: 15, horizontal: 15),
          decoration: BoxDecoration(
            color: !seen ? primaryColor.withOpacity(.12) : backGroundColor,
            borderRadius:
            BorderRadius.all(Radius.circular(10)),
          ),
          child: Row(
            children: [
              Container(
                  margin: EdgeInsets.only(right: 13,left: 10),
                  height: 55,
                  width: 55,
                  decoration: BoxDecoration(
                    color: greyColor.withOpacity(.5),
                    shape: BoxShape.circle,
                    image: DecorationImage(
                      image: NetworkImage('${data.doctorAvatar}',),
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
                          text: data.doctorName
                              .toString(),
                          style: new TextStyle(
                            fontWeight: FontWeight.bold,
                            color: darkBlueColor,
                          ),
                          children: [
                            TextSpan(
                                text:
                                "\t ${ Languages.of(context)!
                  .notificationScreen['txt']  }",
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
                        data.time
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
  }
}

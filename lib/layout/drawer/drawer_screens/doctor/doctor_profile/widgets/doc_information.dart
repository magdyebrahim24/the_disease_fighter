import 'package:flutter/material.dart';
import 'package:the_disease_fighter/material/constants.dart';
import 'package:the_disease_fighter/material/widgets/meeting%20info.dart';
class DocInformation extends StatelessWidget {
  final data;
  const DocInformation({Key? key, this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15,vertical: 10),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
         crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 30),
            //height: 110,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: backGroundColor,
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
                  data.about.toString(),
                  style: TextStyle(
                    fontSize: 10,
                    color: subTextColor,
                  ),
                ),

              ],
            ),
          ),
          MeetingInfo(
            color: backGroundColor,
            width: MediaQuery.of(context).size.width,
            text:  data.email.toString(),
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
            width: MediaQuery.of(context).size.width ,
            text: data.clinicLocation.toString(),
            widget: Icon(Icons.location_on_rounded, color: primaryColor),
          ),
        ],

      ),
    )
      ;
  }
}

import 'package:flutter/material.dart';
import 'package:the_disease_fighter/localizations/localization/language/languages.dart';
import 'package:the_disease_fighter/material/constants.dart';

class DocInformation extends StatelessWidget {
  Widget _infoCard(
    double? width,
    String text,
    Widget widget,
  ) {
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
    return SingleChildScrollView(
        child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
          //mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: EdgeInsets.only(top: 10),
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
                    Languages.of(context)!.doctorProfile['infoTapAbout'],
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
              MediaQuery.of(context).size.width,
              "alia12@example.com",
              Icon(Icons.email, color: primaryColor),
            ),
            SizedBox(
              height: 12,
            ),
            _infoCard(MediaQuery.of(context).size.width, "+20 1334 5678 988",
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

                        )),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            _infoCard(
              MediaQuery.of(context).size.width,
              "Mansoura, Egypt",
              Icon(Icons.location_on_rounded, color: primaryColor),
            ),
          ]),
    ));
  }
}
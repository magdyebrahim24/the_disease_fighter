import 'package:flutter/material.dart';
import '../constants.dart';

class PatientLogo extends StatelessWidget {
  PatientLogo({
    this.imgHigh = 240.0,
    this.imgWidth = 240.0,
    this.nameColor,
    this.nameSize = 18.0,
  });
  final imgHigh;
  final imgWidth;
  final nameColor;
  final nameSize;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                    color: subTextColor,
                    offset: Offset(1.0, 2.0),
                    blurRadius: 6.0,
                    spreadRadius: 1),
              ],
              image: DecorationImage(
                  image: AssetImage("assets/images/img_1.png"),
                  fit: BoxFit.cover),
              shape: BoxShape.circle,
              border: Border.all(color: Color(0xffFDFDFD), width: 2),
              color: backGroundColor),
          margin: EdgeInsets.all(10),
          height: imgHigh,
          width: imgWidth,
        ),
        Text(
          "ALia Ahmed Ali",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: nameColor,
            fontSize: nameSize,
          ),
        ),
        SizedBox(
          height: 7,
        ),
        Text(
          "Egypt - Mansoura",
          style: TextStyle(color: subTextColor),
        )
      ],
    );
  }
}

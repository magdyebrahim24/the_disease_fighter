import 'package:flutter/material.dart';
import '../constants.dart';
class MeetingInfo extends StatelessWidget {
  final width;
      final text;
  final widget;
  final color;
  const MeetingInfo({this.width, this.text, this.widget,this.color});
  @override
  Widget build ( BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 8),
        padding: EdgeInsets.only(
          left: 10,
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: color,
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
  }


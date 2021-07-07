import 'package:flutter/material.dart';
import '../constants.dart';

class MeetingInfo extends StatelessWidget {
  final width;
  final text;
  final widget;
  final color;

  const MeetingInfo({this.width, this.text, this.widget, this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 8),
      padding: EdgeInsets.symmetric(vertical: 10,horizontal: 10),
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
              color: subTextColor.withOpacity(.3),
              offset: Offset(1.0, 2.0),
              blurRadius: 2.0,
              spreadRadius: .2),
        ],
        borderRadius: BorderRadius.circular(8),
        color: color,
      ),
      width: width,
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
            width: 15,
          ),
          Expanded(
            child: Text(
              '$text',
              maxLines: 2,
              style: TextStyle(color: darkBlueColor, fontSize: 14,),overflow: TextOverflow.ellipsis,
            ),
          )
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../constants.dart';

// ignore: must_be_immutable
class TxtField extends StatelessWidget {
  TxtField(
      {Key key,
      this.labelText,
      this.hintText,
      this.actionIcon,
      this.obSecure = false,
      this.readOnly = false,
      this.inputTextFunction,
      this.textInputType = TextInputType.emailAddress})
      : super(key: key);
  final labelText;

  final hintText;

  final Icon actionIcon;
  final obSecure;
  final readOnly;

  Function inputTextFunction;

  final TextInputType textInputType;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 7),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            labelText,
            style: TextStyle(fontSize: 15, color: subTextColor),
          ),
          Container(
            height: 52,
            alignment: Alignment.center,
            margin: EdgeInsets.symmetric(
              vertical: 7,
            ),
            padding: EdgeInsets.symmetric(
              horizontal: 14,
            ),
            decoration: BoxDecoration(
              color: backGroundColor,
              border: Border.all(
                  width: 1, color: Color(0xff707070).withOpacity(.15)),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Row(
              children: [
                Expanded(
                  child: TextFormField(
                    decoration: InputDecoration(
                      hintText: hintText,
                      hintStyle: TextStyle(
                        color: subTextColor.withOpacity(.6),
                      ),
                      border: InputBorder.none,
                    ),
                    keyboardType: textInputType,
                    cursorColor: primaryColor,
                    obscureText: obSecure,
                    readOnly: readOnly,
                    style: TextStyle(color: darkBlueColor.withOpacity(.8)),
                    onChanged: (value) {
                      inputTextFunction(value);
                    },
                  ),
                ),
                actionIcon != null ? actionIcon : SizedBox(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

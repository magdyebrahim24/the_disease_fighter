import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../constants.dart';

// ignore: must_be_immutable
class TxtField extends StatelessWidget {
  TxtField(
      {this.labelText,
      this.hintText,
      this.obSecure = false,
      this.readOnly = false,
      this.inputTextFunction,
      this.textInputType = TextInputType.emailAddress,
      this.validatorFun});

  final labelText;

  final hintText;
  final obSecure;
  final readOnly;
  final validatorFun;

  Function? inputTextFunction;

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
            style:
                TextStyle(fontSize: 15, color: darkBlueColor.withOpacity(.8)),
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 8),
            child: TextFormField(
              validator: validatorFun,
              decoration: InputDecoration(
                  hintText: hintText,
                  hintStyle: TextStyle(
                    color: subTextColor.withOpacity(.6),
                  ),
                  // border: InputBorder.none,
                  contentPadding: EdgeInsets.symmetric(
                    horizontal: 14,
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: BorderSide(
                      color: primaryColor,
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                        width: 1, color: Color(0xff707070).withOpacity(.15)),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  fillColor: backGroundColor,
                  filled: true),
              keyboardType: textInputType,
              cursorColor: primaryColor,
              obscureText: obSecure,
              readOnly: readOnly,
              style: TextStyle(color: darkBlueColor.withOpacity(.8)),
              onChanged: (value) {
                inputTextFunction!(value);
              },
            ),
          ),
        ],
      ),
    );
  }
}
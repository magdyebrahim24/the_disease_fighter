import 'package:flutter/material.dart';
import '../constants.dart';

class DropDownList extends StatelessWidget {
  DropDownList(
      {this.getValue,
      this.value,
      this.items,
      this.hintText,
      this.widthRatio = 1,
      this.labelText});

  final getValue;
  final value;
  final items;
  final hintText;
  final widthRatio;
  final labelText;

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
          Container(
              margin: EdgeInsets.symmetric(
                vertical: 7,
              ),
              // padding: EdgeInsets.all(15),
              // decoration: BoxDecoration(
              //     border: Border.all(
              //         width: 1, color: Color(0xff707070).withOpacity(.15)),
              //     borderRadius: BorderRadius.circular(10),
              //     color: backGroundColor),
              // height: 52,
              width: MediaQuery.of(context).size.width * widthRatio,
              child: DropdownButtonFormField<String>(
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
                onChanged: getValue,
                validator: (value) {
                  if (value == null) return 'Field Required';
                },
                value: value,
                elevation: 1,
                hint: Text(
                  hintText,
                  style: TextStyle(color: subTextColor),
                ),
                icon: Icon(Icons.arrow_drop_down,
                    color: darkBlueColor.withOpacity(.6)),
                isDense: false,
                items: items.map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(
                      value,
                      style: TextStyle(
                          fontSize: 15, color: darkBlueColor.withOpacity(.9)),
                    ),
                  );
                }).toList(),
              )),
        ],
      ),
    );
  }
}
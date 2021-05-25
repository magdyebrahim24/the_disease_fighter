import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../constants.dart';
import 'dart:ui';

// ignore: must_be_immutable
class BasicTimeField extends StatefulWidget {
  final label;
  final fun;
  final helperText;
  final backgroundColor;
  final labelColor;
  var selectedTime;

  BasicTimeField(
      {this.label,
      this.fun,
      this.helperText,
      this.backgroundColor,
      this.labelColor,
      this.selectedTime});

  @override
  _BasicTimeFieldState createState() => _BasicTimeFieldState();
}

class _BasicTimeFieldState extends State<BasicTimeField> {
  var txt;

  @override
  Widget build(BuildContext context) {
    return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            ' ${widget.label}',
            style: TextStyle(color: darkBlueColor.withOpacity(.9)),
          ),
          SizedBox(
            height: 5,
          ),
          InkWell(
            onTap: widget.fun,
            child: Container(
                alignment: Alignment.centerLeft,
                margin: EdgeInsets.symmetric(
                  vertical: 7,
                ),
                padding: EdgeInsets.symmetric(horizontal: 13, vertical: 15),
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(
                      width: 1, color: Color(0xff707070).withOpacity(.15)),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: widget.selectedTime != null
                    ? Text(
                        widget.selectedTime,
                        style: TextStyle(color: darkBlueColor),
                      )
                    : Text(
                        '00:00 AM',
                        style: TextStyle(color: subTextColor.withOpacity(.8)),
                      )),
          ),
        ]);
  }
}

// ignore: must_be_immutable
class BasicDateField extends StatefulWidget {
  final label;
  final fun;
  final helperText;
  var selectedDate;

  BasicDateField({
    this.label,
    required this.fun,
    this.helperText,
    this.selectedDate,
  });

  @override
  _BasicDateFieldState createState() => _BasicDateFieldState();
}

class _BasicDateFieldState extends State<BasicDateField> {
  @override
  Widget build(BuildContext context) {
    return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            widget.label,
            style: TextStyle(color: subTextColor),
          ),
          Container(
            alignment: Alignment.center,
            margin: EdgeInsets.symmetric(
              vertical: 7,
            ),
            padding: EdgeInsets.only(left: 14, right: 10),
            decoration: BoxDecoration(
              color: backGroundColor,
              border: Border.all(
                  width: 1, color: Color(0xff707070).withOpacity(.15)),
              borderRadius: BorderRadius.circular(10),
            ),
            child: DateTimeField(
              onChanged: widget.fun,
              validator: (value) {
                if (value.toString().isEmpty || value == null) {
                  return 'Date Required';
                }
              },
              format: DateFormat("yyyy-MM-dd"),
              decoration: InputDecoration(
                  hintStyle: TextStyle(color: subTextColor, fontSize: 16),
                  suffixIcon: Icon(Icons.arrow_drop_down,
                      color: darkBlueColor.withOpacity(.7)),
                  hintText: 'yyyy-MM-dd',
                  // '${DateFormat("hh:mm a").format(DateTime.now())}',
                  border: InputBorder.none),
              onShowPicker: (context, currentValue) async {
                final time = await showDatePicker(
                    // locale: Locale('ar', 'MA'),
                    // selectableDayPredicate: (DateTime val) =>
                    //     val.weekday == 1 || val.weekday == 3 ? false : true,
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime(1900, 1, 1),
                    lastDate: DateTime.now());
                return time;
              },
            ),
          ),
        ]);
  }

// void _selectDate() async {
//   final DateTime newDate = (await showDatePicker(
//     context: context,
//     initialDate: DateTime.now(),
//     firstDate: DateTime(1900, 1, 1),
//     lastDate: DateTime.now(),
//     helpText: 'Select a date',
//   ))!;
//   if (newDate != null) {
//     setState(() {
//       widget.selectedDate = newDate.toString();
//     });
//   }
// }
}
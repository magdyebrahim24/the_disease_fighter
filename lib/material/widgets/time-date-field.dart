import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../constants.dart';
import 'dart:ui';

// ignore: must_be_immutable
class BasicTimeField extends StatelessWidget {
  final label;
  final fun;
  final helperText;
  final backgroundColor;
  final labelColor;

  BasicTimeField(
      {this.label,
      this.fun,
      this.helperText,
      this.backgroundColor,
      this.labelColor});

  @override
  Widget build(BuildContext context) {
    return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            label,
            style: TextStyle(color: labelColor),
          ),
          Container(
            height: 52,
            alignment: Alignment.center,
            margin: EdgeInsets.symmetric(
              vertical: 7,
            ),
            padding: EdgeInsets.only(
              left: 14,
            ),
            decoration: BoxDecoration(
              color: backgroundColor,
              border: Border.all(
                  width: 1, color: Color(0xff707070).withOpacity(.15)),
              borderRadius: BorderRadius.circular(10),
            ),
            child: DateTimeField(
              onChanged: fun,
              format: DateFormat("hh:mm a"),
              decoration: InputDecoration(
                  hintStyle: TextStyle(color: subTextColor, fontSize: 16),
                  suffixIcon: Icon(Icons.arrow_drop_down,
                      color: darkBlueColor.withOpacity(.7)),
                  hintText: '00:00 AM',
                  // '${DateFormat("hh:mm a").format(DateTime.now())}',
                  border: InputBorder.none),
              onShowPicker: (context, currentValue) async {
                final time = await showTimePicker(
                  context: context,
                  initialEntryMode: TimePickerEntryMode.input,
                  helpText: helperText,
                  initialTime:
                      TimeOfDay.fromDateTime(currentValue ?? DateTime.now()),
                  builder: (BuildContext context, Widget? child) {
                    return MediaQuery(
                      data: MediaQuery.of(context).copyWith(
                        alwaysUse24HourFormat: false,
                      ),
                      child: child!,
                    );
                  },
                );
                return time == null ? null : DateTimeField.convert(time);
              },
            ),
          ),
        ]);
  }
}

class BasicDateField extends StatelessWidget {
  final label;
  final fun;
  final helperText;

  BasicDateField({
    this.label,
    required this.fun,
    this.helperText,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            label,
            style: TextStyle(color: subTextColor),
          ),
          Container(
            height: 52,
            alignment: Alignment.center,
            margin: EdgeInsets.symmetric(
              vertical: 7,
            ),
            padding: EdgeInsets.only(
                left: 14, right: 10),
            decoration: BoxDecoration(
              color: backGroundColor,
              border: Border.all(
                  width: 1, color: Color(0xff707070).withOpacity(.15)),
              borderRadius: BorderRadius.circular(10),
            ),
            child: DateTimeField(
              onChanged: fun,
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
                    selectableDayPredicate: (DateTime val) =>
                        val.weekday == 1 || val.weekday == 3 ? false : true,
                    context: context,
                    initialDate: DateTime(2021, 6, 25),
                    firstDate: DateTime.now(),
                    lastDate: DateTime(DateTime.now().year + 1));
                return time;
              },
            ),
          ),
        ]);
  }
}
import 'package:flutter/material.dart';
import 'package:the_disease_fighter/layout/patient_screens/patient_home/home.dart';
import 'package:the_disease_fighter/material/bottons/roundedBtn.dart';
import 'package:the_disease_fighter/material/constants.dart';
import 'package:the_disease_fighter/material/widgets/drop-downlist.dart';
import 'package:the_disease_fighter/material/widgets/patient-logo.dart';
import 'package:the_disease_fighter/material/widgets/time-date-field.dart';
import 'package:the_disease_fighter/material/widgets/txt_field.dart';

class BookAppointment extends StatefulWidget {
  @override
  _BookAppointmentState createState() => _BookAppointmentState();
}

class _BookAppointmentState extends State<BookAppointment> {
  String appointmentTime;
  String gender;
  String name;
  String phone;
  String comment;
  DateTime fromTime;

  _getAppointmentTime(String val) {
    setState(() {
      appointmentTime = val;
    });
  }

  _getComment(String val) {
    setState(() {
      comment = val;
    });
  }

  _getGender(String val) {
    setState(() {
      gender = val;
    });
  }

  _getName(String name) {
    setState(() {
      this.name = name;
    });
  }

  _getPhone(String phone) {
    setState(() {
      this.phone = phone;
    });
  }

  _getAppointmentDate(DateTime phone) {
    setState(() {
      this.fromTime = phone;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.transparent,
        leading: MaterialButton(
          onPressed: () => Navigator.pop(context),
          child: Icon(
            Icons.arrow_back,
            color: darkBlueColor,
          ),
          color: primaryColor.withOpacity(.2),
          elevation: 0.0,
          materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(45.0),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              alignment: Alignment.center,
              margin: EdgeInsets.only(bottom: 25),
              padding: EdgeInsets.only(top: 25),
              width: MediaQuery.of(context).size.width,
              height: 230,
              decoration: BoxDecoration(
                  color: primaryColor.withOpacity(.8),
                  borderRadius: BorderRadius.only(
                    bottomRight: Radius.circular(40),
                    bottomLeft: Radius.circular(40),
                  )),
              child: PatientLogo(
                imgWidth: 120.0,
                imgHigh: 120.0,
                nameColor: darkBlueColor,
                nameSize: 20.0,
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    BasicDateField(
                      helperText: 'Select Appointment Date',
                      label: 'Appointment Date',
                      fun: _getAppointmentDate,
                    ),
                    DropDownList(
                      value: appointmentTime,
                      getValue: _getAppointmentTime,
                      items: [
                        '08:00 pm',
                        '08:30 pm',
                        '09:00 pm',
                        '09:30 pm',
                        '10:00 pm',
                        '10:30 pm',
                      ],
                      hintText: 'Time That Clinic Aviable',
                      labelText: 'Appointment Time',
                    ),
                    TxtField(
                      textInputType: TextInputType.text,
                      labelText: 'Name',
                      hintText: 'Write Patient Name',
                      inputTextFunction: _getName,
                    ),
                    Row(
                      children: [
                        SizedBox(
                          width: 130,
                          child: DropDownList(
                            value: gender,
                            getValue: _getGender,
                            items: ['Male', 'Female'],
                            hintText: 'gender',
                            labelText: 'Gender',
                          ),
                        ),
                        SizedBox(
                          width: 20,
                        ),
                        Expanded(
                          child: TxtField(
                            textInputType: TextInputType.phone,
                            labelText: 'Phone',
                            hintText: 'Write Phone',
                            inputTextFunction: _getPhone,
                          ),
                        ),
                      ],
                    ),
                    Text(
                      'Appointment Note',
                      style: TextStyle(color: subTextColor),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 10, bottom: 20),
                      padding: EdgeInsets.all(5),
                      decoration: BoxDecoration(
                          border: Border.all(
                              width: 1,
                              color: Color(0xff707070).withOpacity(.15)),
                          color: backGroundColor,
                          borderRadius: BorderRadius.circular(10)),
                      child: TextFormField(
                        onChanged: _getComment,
                        keyboardType: TextInputType.text,
                        maxLines: 3,
                        decoration: InputDecoration(
                            border: InputBorder.none,
                            contentPadding: EdgeInsets.all(10),
                            hintText: "Write your Note ...",
                            hintStyle: TextStyle(
                                color: subTextColor.withOpacity(.8),
                                fontSize: 16)),
                      ),
                    ),
                  ]),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        color: Colors.transparent,
        child: Padding(
          padding: EdgeInsets.only(top: 5, bottom: 10, right: 35, left: 35),
          child: RoundedButton(
            fun: () => Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                    builder: (context) => Home(
                          showSnackBar: true,
                        ))),
            text: 'Book Appointment',
            borderRadious: 50,
          ),
        ),
        elevation: 0.0,
      ),
    );
  }
}

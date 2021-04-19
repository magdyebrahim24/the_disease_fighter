import 'package:flutter/material.dart';
import 'package:the_disease_fighter/layout/drawer/drawer_screens/patient/my_appointments/my_appointments.dart';
import 'package:the_disease_fighter/material/bottons/roundedBtn.dart';
import 'package:the_disease_fighter/material/constants.dart';
import 'package:the_disease_fighter/material/widgets/drop-downlist.dart';
import 'package:the_disease_fighter/material/widgets/patient-logo.dart';
import 'package:the_disease_fighter/material/widgets/time-date-field.dart';
import 'package:the_disease_fighter/material/widgets/txt_field.dart';

class EditAppointment extends StatefulWidget {
  @override
  _EditAppointmentState createState() => _EditAppointmentState();
}

class _EditAppointmentState extends State<EditAppointment> {
  String appointmentTime = '08:00 pm';
  String gender = 'Female';
  String name = 'magdy';
  String phone = '01277155972';
  String comment = '';
  late DateTime fromTime;

  _getAppointmentTime(val) {
    setState(() {
      appointmentTime = val;
    });
  }

  _getComment(val) {
    setState(() {
      comment = val;
    });
  }

  _getGender(val) {
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

  _getAppointmentDate(phone) {
    setState(() {
      this.fromTime = phone;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 7),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              MaterialButton(
                minWidth: MediaQuery.of(context).size.width * .3,
                height: 50,
                shape: RoundedRectangleBorder(
                  side: BorderSide(color: subTextColor),
                  borderRadius: BorderRadius.circular(50),
                ),
                onPressed: () => Navigator.pop(context),
                child: Text(
                  'Cancel',
                  style: TextStyle(fontSize: 16, color: subTextColor),
                ),
              ),
              SizedBox(
                width: 10,
              ),
              RoundedButton(
                minWdthRatio: .5,
                fun: () => Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) => MyAppointments())),
                text: 'Save',
                borderRadious: 50,
              ),
            ],
          ),
        ),
        elevation: 0.0,
      ),
    );
  }
}

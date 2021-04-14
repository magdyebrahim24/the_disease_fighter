import 'package:flutter/material.dart';
import 'package:the_disease_fighter/layout/drawer/drawer_screens/patient/my_appointments/my_appointments.dart';
import 'package:the_disease_fighter/material/bottons/roundedBtn.dart';
import 'package:the_disease_fighter/material/constants.dart';
import 'package:the_disease_fighter/material/widgets/patient-logo.dart';
import 'edit_apppointment.dart';

// ignore: must_be_immutable
class ShowAppointment extends StatelessWidget {
  // Map appointmentData = {
  //   'date':'4/4/2021',
  //   'time':'05:30 PM',
  //   'name':'Magdy Ebrahim Ali',
  //   'gender':'Male',
  //   'phone':'01552154105',
  //   'Comment': 'I have a severe headache and the abdomen and suffer from your diversity and a cold and a cold ',
  // };
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
            _item(labelText: 'Appointment Date', data: '4/4/2021'),
            _item(labelText: 'Appointment Time', data: '05:30 PM'),
            _item(labelText: 'Name', data: 'Magdy Ebrahim Ali'),
            _item(labelText: 'Gender', data: 'Male'),
            _item(labelText: 'Phone', data: '01552154105'),
            _item(
                labelText: 'Comment',
                data:
                    'I have a severe headache and the abdomen and suffer from your diversity and a cold and a cold '),
            SizedBox(
              height: 15,
            )
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
                color: Colors.redAccent,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(50),
                ),
                onPressed: () => Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) => MyAppointments())),
                child: Text(
                  'Delete',
                  style: TextStyle(fontSize: 16, color: Colors.white),
                ),
              ),
              SizedBox(
                width: 10,
              ),
              RoundedButton(
                minWdthRatio: .5,
                fun: () => Navigator.push(context,
                    MaterialPageRoute(builder: (context) => EditAppointment())),
                text: 'Edit',
                borderRadious: 50,
              ),
            ],
          ),
        ),
        elevation: 0.0,
      ),
    );
  }

  Widget _item({labelText, data}) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 7, horizontal: 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            labelText,
            style: TextStyle(fontSize: 15, color: subTextColor),
          ),
          Container(
              alignment: Alignment.centerLeft,
              margin: EdgeInsets.symmetric(
                vertical: 7,
              ),
              padding: EdgeInsets.symmetric(horizontal: 14, vertical: 15),
              decoration: BoxDecoration(
                color: backGroundColor,
                border: Border.all(
                    width: 1, color: Color(0xff707070).withOpacity(.15)),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Text(
                data,
                style: TextStyle(color: darkBlueColor, fontSize: 16),
              )),
        ],
      ),
    );
  }
}

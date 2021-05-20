import 'package:flutter/material.dart';
import 'package:the_disease_fighter/layout/doctor-screens/doctor_home/widgets/metting_card.dart';
import 'package:the_disease_fighter/material/bottons/circleBtn.dart';
import 'package:the_disease_fighter/material/constants.dart';

class AllAppointments extends StatefulWidget {
  @override
  _AllAppointmentsState createState() => _AllAppointmentsState();
}

class _AllAppointmentsState extends State<AllAppointments> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.fromLTRB(16, 20, 10, 5),
            child: Row(
              children: [
                Expanded(
                    child: Text(
                  'All Appointments',
                  style: kHeadStyle,
                )),
                ImgButton(
                  fun: () {},
                  img: 'assets/icons/filter.png',
                  imgWidth: 16.0,
                  imgHigh: 21.0,
                ),
              ],
            ),
          ),
          for (var i = 0; i < 15; i++) MeetingCard()
        ],
      ),
    );
  }
}

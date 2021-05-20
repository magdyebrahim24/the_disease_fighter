import 'package:flutter/material.dart';
import 'package:the_disease_fighter/layout/doctor-screens/doctor_home/widgets/metting_card.dart';

class TodayAppointments extends StatefulWidget {
  @override
  _TodayAppointmentsState createState() => _TodayAppointmentsState();
}

class _TodayAppointmentsState extends State<TodayAppointments> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: 15, itemBuilder: (ctx, index) => MeetingCard());
  }
}

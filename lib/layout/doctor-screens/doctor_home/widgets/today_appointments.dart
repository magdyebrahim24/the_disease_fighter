import 'package:flutter/material.dart';
import 'package:the_disease_fighter/layout/doctor-screens/doctor_home/widgets/metting_card.dart';
import 'package:the_disease_fighter/layout/drawer/drawer_screens/patient/favorite/favorite_doctors.dart';

class TodayAppointments extends StatefulWidget {
  final data;

  const TodayAppointments({Key? key, this.data}) : super(key: key);

  @override
  _TodayAppointmentsState createState() => _TodayAppointmentsState();
}

class _TodayAppointmentsState extends State<TodayAppointments> {
  @override
  Widget build(BuildContext context) {
    return widget.data.length != 0 && widget.data.length != null
        ? ListView.builder(
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: widget.data.length,
            itemBuilder: (ctx, index) => MeetingCard(
                  data: widget.data[index],
                ))
        : EmptyPage();
  }
}
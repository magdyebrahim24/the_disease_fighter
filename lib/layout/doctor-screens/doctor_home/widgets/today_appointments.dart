import 'package:flutter/material.dart';
import 'package:the_disease_fighter/layout/doctor-screens/doctor_home/widgets/metting_card.dart';
import 'package:the_disease_fighter/localizations/localization/language/languages.dart';
import 'package:the_disease_fighter/material/widgets/empty_list_widget.dart';

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
        : EmptyListWidget(icon: Icons.date_range_outlined,label:Languages.of(context)!.doctorProfile['editProfile']['noTodayAppointments'].toString(),iconSize: 100.0,);
  }
}
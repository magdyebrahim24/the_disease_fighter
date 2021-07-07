import 'package:flutter/material.dart';
import 'package:the_disease_fighter/layout/doctor-screens/doctor_profile/widgets/previous_appointment_details.dart';
import 'package:the_disease_fighter/localizations/localization/language/languages.dart';
import 'package:the_disease_fighter/material/constants.dart';
import 'package:the_disease_fighter/material/widgets/empty_list_widget.dart';
import 'package:the_disease_fighter/material/widgets/no_internet_widget.dart';
import 'package:the_disease_fighter/services/doctorScreens/controllers/prevous_appointments_controller.dart';

class PreviousAppointments extends StatefulWidget {
  @override
  _PreviousAppointmentsState createState() => _PreviousAppointmentsState();
}

class _PreviousAppointmentsState extends State<PreviousAppointments> {
  DoctorPreviousAppointmentsController _previousAppointmentsController=DoctorPreviousAppointmentsController();

  Future _getPreviousAppointments() async {
    var data = await _previousAppointmentsController.getDoctorPreviousAppointments();
    return data ;
  }

  @override
  Widget build(BuildContext context) {
    return  FutureBuilder<dynamic>(
        future:_getPreviousAppointments(),
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          if (!snapshot.hasData && !snapshot.hasError) {
            return Container(
                height: MediaQuery.of(context).size.height * .15,
                alignment: Alignment.center,
                child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Padding(
              padding:  EdgeInsets.only(top:25.0),
              child: SingleChildScrollView(
                child: FailLoadWidget(
                  fun: () {
                    setState(() {
                      _getPreviousAppointments();
                    });
                  },
                ),
              ),
            );
          } else {
            return  snapshot.data.previousSessions != null  && snapshot.data.previousSessions.length != 0
                ? ListView.builder(
                itemCount: snapshot.data.previousSessions.length,
                itemBuilder: (ctx, index) {
                  return Container(
                    padding: EdgeInsets.symmetric(vertical: 15, horizontal: 15),
                    margin: EdgeInsets.symmetric(vertical: 8, horizontal: 15),
                    decoration: BoxDecoration(
                      color: lightGreyColor,
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      border: Border.all(color: Color(0xffBCE0FD)),
                    ),
                    width: MediaQuery.of(context).size.width,
                    child: Row(
                      children: [
                        Container(
                            height: 45,
                            width: 45,
                            decoration: BoxDecoration(
                              color: greyColor.withOpacity(.5),
                              borderRadius: BorderRadius.circular(10),
                              image: DecorationImage(
                                image: NetworkImage(snapshot.data.previousSessions[index].patientAvatar.toString()),
                                fit: BoxFit.cover,
                              ),
                            )),
                        SizedBox(
                          width: 10,
                        ),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                snapshot.data.previousSessions[index].name.toString(),
                                style: TextStyle(
                                  color: darkBlueColor,
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Text(
                                ' ${snapshot.data.previousSessions[index].date.toString()} ',
                                style: TextStyle(
                                  color: subTextColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                        MaterialButton(
                          onPressed: () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => PreviousAppointmentDetails(data: snapshot.data.previousSessions[index],))),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5)),
                          child: Text(
                            Languages.of(context)!.doctorProfile['prevTapMoreBtn'],
                            style: TextStyle(
                                color: Colors.white, fontWeight: FontWeight.bold),
                          ),
                          height: 30,
                          color: primaryColor,
                        )
                      ],
                    ),
                  );
                }) :
            EmptyListWidget(
              icon: Icons.date_range,
              label: Languages.of(context)!.doctorProfile['editProfile']['noPreviousAppointments'].toString(),
              iconSize: 100.0,
            );
          }
        }

    );}
}

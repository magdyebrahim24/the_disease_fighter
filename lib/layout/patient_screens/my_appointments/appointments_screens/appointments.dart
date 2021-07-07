import 'package:flutter/material.dart';
import 'package:the_disease_fighter/layout/patient_screens/the_appointment/show_appointment.dart';
import 'package:the_disease_fighter/localizations/localization/language/languages.dart';
import 'package:the_disease_fighter/material/constants.dart';
import 'package:the_disease_fighter/material/widgets/empty_list_widget.dart';
import 'package:url_launcher/url_launcher.dart';

class AppointmentsBuilder extends StatelessWidget {
  final data;

  const AppointmentsBuilder({Key? key, this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return data.length != 0
        ? ListView.builder(
            itemCount: data.length,
            itemBuilder: (ctx, index) {
              return Container(
                padding: EdgeInsets.symmetric(vertical: 15, horizontal: 15),
                margin: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                        color: subTextColor,
                        offset: Offset(1.0, 2.0),
                        blurRadius: 3.0,
                        spreadRadius: .5),
                  ],
                  color: backGroundColor,
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                ),
                width: MediaQuery.of(context).size.width,
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                            height: 45,
                            width: 45,
                            decoration: BoxDecoration(
                              color: greyColor.withOpacity(.5),
                              borderRadius: BorderRadius.circular(10),
                              image: DecorationImage(
                                image: NetworkImage(
                                    data[index].doctorAvatar.toString()),
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
                                data[index].doctorName.toString(),
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
                                '${data[index].day.toString()}, ${data[index].date.toString()} , ${data[index].time.toString()}${data[index].amPm.toString()}',
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  color: subTextColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                        MaterialButton(
                          onPressed: () =>
                              launch("tel://${data[index].phone.toString()}"),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30)),
                          child: Icon(
                            Icons.phone_rounded,
                            color: primaryColor,
                            size: 16,
                          ),
                          height: 30,
                          minWidth: 30,
                          padding: EdgeInsets.zero,
                          materialTapTargetSize:
                              MaterialTapTargetSize.shrinkWrap,
                          color: Colors.white,
                        )
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    MaterialButton(
                      onPressed: () => Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ShowAppointment(
                                    data: data[index],
                                  ))),
                      child: Text(
                        Languages.of(context)!
                            .patientAppointments['detailsBTN'],
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                      height: 40,
                      minWidth: MediaQuery.of(context).size.width,
                      color: primaryColor,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                    )
                  ],
                ),
              );
            })
        : EmptyListWidget(icon: Icons.list_alt,label:   Languages.of(context)!
        .patientAppointments['no appointments'].toString(),iconSize: 100.0,);
  }

}

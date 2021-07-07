import 'package:flutter/material.dart';
import 'package:the_disease_fighter/layout/drawer/drawer_screens/patient/favorite/favorite_doctors.dart';
import 'package:the_disease_fighter/localizations/localization/language/languages.dart';
import 'package:the_disease_fighter/material/constants.dart';

import 'previous_appointment_details.dart';

class PreviousAppointments extends StatelessWidget {
  final data;

  const PreviousAppointments({this.data});

  @override
  Widget build(BuildContext context) {
    return data.length != 0
        ? ListView.builder(
            itemCount: data.length,
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
                        data[index].date.toString(),
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
                              builder: (context) => PreviousAppointmentDetails(
                                    data: data[index],
                                  ))),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5)),
                      child: Text(
                        Languages.of(context)!
                            .patientAppointments['showMoreBTN'],
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                      height: 30,
                      color: primaryColor,
                    )
                  ],
                ),
              );
            })
        : EmptyPage();
  }
}

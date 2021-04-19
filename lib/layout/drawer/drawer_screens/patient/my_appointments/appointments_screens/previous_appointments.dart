import 'package:flutter/material.dart';
import 'package:the_disease_fighter/material/constants.dart';

import 'previous_appointment_details.dart';

class PreviousAppointments extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: 15,
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
                    margin: EdgeInsets.only(right: 13),
                    height: 45,
                    width: 45,
                    decoration: BoxDecoration(
                      color: greyColor.withOpacity(.5),
                      borderRadius: BorderRadius.circular(10),
                      image: DecorationImage(
                        image: AssetImage('assets/doctors_img/doc3.jpg'),
                        fit: BoxFit.cover,
                      ),
                    )),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Dr.Magdy Ebrahim',
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
                        '09-12-2021',
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
                          builder: (context) => PreviousAppointmentDetails())),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5)),
                  child: Text(
                    'Show More',
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                  height: 30,
                  color: primaryColor,
                )
              ],
            ),
          );
        });
  }
}

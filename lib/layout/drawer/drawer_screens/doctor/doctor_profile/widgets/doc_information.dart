import 'package:flutter/material.dart';
import 'package:the_disease_fighter/layout/patient_screens/the_appointment/show_appointment.dart';
import 'package:the_disease_fighter/material/constants.dart';
import 'package:url_launcher/url_launcher.dart';

class DocInformation extends StatelessWidget {
  Widget _infoCard(
    double width,
    String text,
    Widget widget,
  ) {
    return Container(
      padding: EdgeInsets.only(
        left: 10,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: lightGreyColor,
      ),
      width: width,
      height: 50,
      child: Row(
        children: [
          Container(
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(7)),
            width: 30,
            height: 30,
            child: Center(child: widget),
          ),
          SizedBox(
            width: 20,
          ),
          Text(
            text,
            style: TextStyle(color: darkBlueColor, fontSize: 12),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: 15,
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
                        margin: EdgeInsets.only(right: 13),
                        height: 45,
                        width: 45,
                        decoration: BoxDecoration(
                          color: greyColor.withOpacity(.5),
                          borderRadius: BorderRadius.circular(10),
                          image: DecorationImage(
                            image: AssetImage('assets/doctors_img/doc1.jpg'),
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
                            'Mon, Feb 19, 08.00am - 10.00am',
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              color: subTextColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                    MaterialButton(
                      onPressed: () => launch("tel://01552154105"),
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
                      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      color: Colors.white,
                    )
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                MaterialButton(
                  onPressed: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ShowAppointment())),
                  child: Text(
                    'Appointment Details',
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
        });
  }
}

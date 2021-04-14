import 'package:flutter/material.dart';
import 'package:the_disease_fighter/data/doctor_data.dart';
import 'package:the_disease_fighter/layout/patient_screens/doctor_details/doctor_details.dart';
import 'package:the_disease_fighter/layout/patient_screens/the_appointment/book_appointment.dart';
import 'package:the_disease_fighter/material/bottons/circleBtn.dart';
import 'package:the_disease_fighter/material/constants.dart';
import 'package:the_disease_fighter/material/widgets/rate_bar.dart';

class FavoriteDoctors extends StatefulWidget {
  @override
  _FavoriteDoctorsState createState() => _FavoriteDoctorsState();
}

class _FavoriteDoctorsState extends State<FavoriteDoctors> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        elevation: 1,
        leading: CircleButton(
          color: primaryColor,
          fun: () => Navigator.pop(context),
          icn: Icons.arrow_back,
        ),
        title: Text(
          'Favorite Doctors',
          style: TextStyle(color: darkBlueColor.withOpacity(.8), fontSize: 17),
        ),
      ),
      body: ListView.builder(
        padding: EdgeInsets.symmetric(vertical: 15),
        itemCount: 10,
        itemBuilder: (ctx, index) {
          return Container(
            margin: EdgeInsets.symmetric(vertical: 5, horizontal: 15),
            padding: EdgeInsets.all(15),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(20)),
              border: Border.all(color: Color(0xffD7E9F5)),
            ),
            child: Row(
              children: [
                InkWell(
                  onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              DoctorDetails(data: doctorsData[0]))),
                  child: Container(
                      margin: EdgeInsets.only(right: 15),
                      height: 92,
                      width: 90,
                      decoration: BoxDecoration(
                        color: Colors.grey,
                        image: DecorationImage(
                          image: AssetImage('${doctorsData[0].doctorImg}'),
                          fit: BoxFit.cover,
                        ),
                        borderRadius: BorderRadius.circular(10),
                      )),
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Dr.${doctorsData[0].doctorName}',
                            style: TextStyle(
                              color: darkBlueColor,
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          Icon(
                            Icons.favorite,
                            color: primaryColor,
                          )
                        ],
                      ),
                      Text(
                        '${doctorsData[0].pecialty}',
                        style: TextStyle(
                          color: Color(0xff8A9EAD),
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      // Text('${data[index].address}',style: TextStyle(color: Color(0xff8A9EAD),fontSize: 14,fontWeight: FontWeight.bold,),maxLines: 1,overflow: TextOverflow.ellipsis,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Rate(
                            clr: Color(0xff9ADFF7),
                            rateValue: doctorsData[0].rate.toInt(),
                          ),
                          MaterialButton(
                            onPressed: () => Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => BookAppointment())),
                            height: 30,
                            minWidth: 65,
                            child: Text(
                              'Book',
                              style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white),
                            ),
                            color: Color(0xff9ADFF7),
                            elevation: 1,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

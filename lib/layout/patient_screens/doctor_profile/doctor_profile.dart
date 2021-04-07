import 'package:flutter/material.dart';
import 'package:the_disease_fighter/layout/drawer/drawer_screens/favorite_doctors.dart';
import 'package:the_disease_fighter/layout/patient_screens/the_appointment/book_appointment.dart';
import 'package:the_disease_fighter/material/bottons/circleBtn.dart';
import 'package:the_disease_fighter/material/bottons/roundedBtn.dart';
import 'package:the_disease_fighter/material/constants.dart';
import 'package:the_disease_fighter/material/widgets/rate_bar.dart';
import 'package:url_launcher/url_launcher.dart';

// ignore: must_be_immutable
class DoctorProfile extends StatefulWidget {
  final data;

  DoctorProfile({@required this.data});

  @override
  _DoctorProfileState createState() => _DoctorProfileState();
}

class _DoctorProfileState extends State<DoctorProfile> {
  bool isFavorite = false;

  snackBarr({text, fun, label = ''}) {
    final snackBar = SnackBar(
      duration: Duration(seconds: 1),
      content: Text(
        text,
        style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
      ),
      backgroundColor: primaryColor,
      action:
          SnackBarAction(label: label, textColor: Colors.white, onPressed: fun),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        elevation: 0.0,
        toolbarOpacity: 1,
        backgroundColor: Colors.transparent,
        leading: CircleButton(
          color: darkBlueColor,
          icn: Icons.arrow_back,
          fun: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
                width: MediaQuery.of(context).size.width,
                height: 400,
                decoration: BoxDecoration(
                  color: Colors.grey,
                  image: DecorationImage(
                    image: AssetImage(widget.data.doctorImg),
                    fit: BoxFit.cover,
                  ),
                  borderRadius: BorderRadius.only(
                      bottomRight: Radius.circular(35),
                      bottomLeft: Radius.circular(35)),
                )),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
              child: Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                          child: Text(
                        'Dr. ${widget.data.doctorName}',
                        style: kHeadStyle.copyWith(
                          fontSize: 26,
                        ),
                      )),
                      IconButton(
                          icon: Icon(
                            isFavorite ? Icons.favorite : Icons.favorite_border,
                            color: isFavorite
                                ? Colors.red
                                : darkBlueColor.withOpacity(.7),
                          ),
                          onPressed: () {
                            setState(() {
                              if (isFavorite) {
                                isFavorite = false;
                              } else {
                                isFavorite = true;
                              }
                            });
                            isFavorite
                                ? snackBarr(
                                    label: 'Show',
                                    text: 'Added To Favorite',
                                    fun: () => Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                FavoriteDoctors())),
                                  )
                                : snackBarr(
                                    text: 'Removed From Favorite', fun: () {});
                          }),
                    ],
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(vertical: 30, horizontal: 15),
                    margin: EdgeInsets.symmetric(vertical: 15),
                    decoration: BoxDecoration(
                      color: backGroundColor,
                      borderRadius: BorderRadius.all(Radius.circular(15)),
                      // border: Border.all(color: lightGreyColor),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsets.fromLTRB(0, 0, 10, 0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'About',
                                style: kHeadStyle.copyWith(
                                    fontSize: 17, fontWeight: FontWeight.w700),
                              ),
                              Rate(
                                rateValue: widget.data.rate.toInt(),
                                clr: primaryColor,
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(
                              vertical: 10, horizontal: 15),
                          child: Text(
                            widget.data.about,
                            style: kSubStyle,
                            maxLines: 3,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 25, bottom: 15),
                          child: Row(
                            children: [
                              Icon(
                                Icons.location_on,
                                color: darkBlueColor,
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              Text(widget.data.address, style: kSubStyle),
                            ],
                          ),
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width,
                          padding: EdgeInsets.symmetric(
                              vertical: 17, horizontal: 15),
                          margin: EdgeInsets.symmetric(vertical: 5),
                          child: Row(
                            children: [
                              Icon(Icons.access_time, color: darkBlueColor),
                              SizedBox(
                                width: 10,
                              ),
                              Text(
                                'Monday, 08.00am - 10.00 am',
                                style: TextStyle(color: darkBlueColor),
                              ),
                            ],
                          ),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(15)),
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width,
                          padding: EdgeInsets.symmetric(
                              vertical: 17, horizontal: 15),
                          margin: EdgeInsets.symmetric(vertical: 5),
                          child: Row(
                            children: [
                              Icon(Icons.access_time, color: darkBlueColor),
                              SizedBox(
                                width: 10,
                              ),
                              Text(
                                'Monday, 08.00am - 10.00 am',
                                style: TextStyle(color: darkBlueColor),
                              ),
                            ],
                          ),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(15)),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        color: Colors.transparent,
        child: Padding(
          padding: EdgeInsets.only(top: 5, bottom: 10, right: 5, left: 5),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              MaterialButton(
                elevation: 0.5,
                hoverElevation: 5.0,
                materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                minWidth: 60,
                height: 60,
                color: backGroundColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(40.0),
                ),
                onPressed: () => launch("tel://01552154105"),
                child: Icon(
                  Icons.phone,
                  color: primaryColor,
                ),
              ),
              RoundedButton(
                fun: () => Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) => BookAppointment())),
                minWdthRatio: .63,
                text: 'Book Appointment',
                borderRadious: 50,
              ),
            ],
          ),
        ),
        elevation: 0.0,
      ),
    );
  }
}

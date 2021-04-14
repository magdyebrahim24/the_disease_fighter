import 'package:flutter/material.dart';
import 'package:the_disease_fighter/layout/drawer/drawer_screens/patient/favorite_doctors.dart';
import 'package:the_disease_fighter/layout/patient_screens/doctor_details/reviews.dart';
import 'package:the_disease_fighter/layout/patient_screens/the_appointment/book_appointment.dart';
import 'package:the_disease_fighter/material/bottons/circleBtn.dart';
import 'package:the_disease_fighter/material/bottons/roundedBtn.dart';
import 'package:the_disease_fighter/material/constants.dart';
import 'package:the_disease_fighter/material/widgets/rate_bar.dart';
import 'package:url_launcher/url_launcher.dart';

// ignore: must_be_immutable
class DoctorDetails extends StatefulWidget {
  final data;

  DoctorDetails({@required this.data});

  @override
  _DoctorDetailsState createState() => _DoctorDetailsState();
}

class _DoctorDetailsState extends State<DoctorDetails> {
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
      backgroundColor: Colors.white,
      extendBodyBehindAppBar: true,
      // appBar: AppBar(
      //   elevation: 0.0,
      //   toolbarOpacity: 1,
      //   backgroundColor: Colors.transparent,
      //   leading: CircleButton(
      //     color: darkBlueColor,
      //     icn: Icons.arrow_back,
      //     fun: () => Navigator.pop(context),
      //   ),
      // ),
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            elevation: 0.0,
            leading: CircleButton(
              color: darkBlueColor,
              icn: Icons.arrow_back,
              fun: () => Navigator.pop(context),
            ),
            actions: [
              IconButton(
                  icon: Icon(
                    isFavorite ? Icons.favorite : Icons.favorite_border,
                    color:
                        isFavorite ? Colors.red : darkBlueColor.withOpacity(.7),
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
                                    builder: (context) => FavoriteDoctors())),
                          )
                        : snackBarr(text: 'Removed From Favorite', fun: () {});
                  }),
            ],
            pinned: true,
            // snap: true,
            floating: true,
            expandedHeight: 400.0,
            flexibleSpace: FlexibleSpaceBar(
              title: Text('Dr. ${widget.data.doctorName}', style: kHeadStyle),
              background: docImage(),
            ),
          ),
          SliverList(
            delegate: SliverChildListDelegate.fixed(
              [
                Container(
                  padding: EdgeInsets.symmetric(vertical: 30, horizontal: 15),
                  margin: EdgeInsets.fromLTRB(10, 20, 10, 10),
                  decoration: BoxDecoration(
                    color: backGroundColor,
                    borderRadius: BorderRadius.all(Radius.circular(10)),
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
                        padding:
                            EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                        child: Text(
                          widget.data.about,
                          style: kSubStyle,
                          maxLines: 3,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 20, bottom: 10),
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
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(vertical: 30, horizontal: 15),
                  margin: EdgeInsets.fromLTRB(10, 0, 10, 10),
                  decoration: BoxDecoration(
                    color: backGroundColor,
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    // border: Border.all(color: lightGreyColor),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.fromLTRB(0, 0, 0, 10),
                        child: Text(
                          'Clinic Appointments ',
                          style: kHeadStyle.copyWith(
                              fontSize: 17, fontWeight: FontWeight.w700),
                        ),
                      ),
                      appointmentCard(context),
                      appointmentCard(context),
                      appointmentCard(context),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 10,
                  ),
                  child: ListTile(
                    onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => DoctorReviews())),
                    tileColor: backGroundColor,
                    title: Text(
                      "Patient Reviews",
                      style: TextStyle(
                        color: darkBlueColor,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    trailing: Icon(
                      Icons.arrow_forward_ios_sharp,
                      color: subTextColor,
                      size: 20,
                    ),
                    contentPadding:
                        EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  ),
                ),
                SizedBox(
                  height: double.infinity < MediaQuery.of(context).size.height
                      ? MediaQuery.of(context).size.height -
                          double.infinity +
                          10
                      : 0,
                ),
              ],
            ),
          ),
        ],
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

  Container appointmentCard(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      padding: EdgeInsets.symmetric(vertical: 17, horizontal: 15),
      margin: EdgeInsets.symmetric(vertical: 5),
      child: Row(
        children: [
          Icon(Icons.access_time, color: darkBlueColor),
          SizedBox(
            width: 10,
          ),
          Text(
            'Monday, 08.00am - 10.00 am',
            maxLines: 2,
            style: TextStyle(color: darkBlueColor),
          ),
        ],
      ),
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(15)),
    );
  }

  Widget docImage() => Container(
      child: Image.asset(widget.data.doctorImg, fit: BoxFit.contain),
      width: MediaQuery.of(context).size.width,
      margin: EdgeInsets.only(bottom: 55),
      // height: 300,
      decoration: BoxDecoration(
        color: backGroundColor,
        // image: DecorationImage(
        //   image: AssetImage(widget.data.doctorImg),
        //   fit: BoxFit.cover,
        // ),
        borderRadius: BorderRadius.only(
            bottomRight: Radius.circular(35), bottomLeft: Radius.circular(35)),
      ));
}

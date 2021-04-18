import 'package:flutter/material.dart';
import 'package:the_disease_fighter/layout/patient_screens/patient_home/home.dart';
import 'package:the_disease_fighter/material/bottons/circleBtn.dart';
import 'package:the_disease_fighter/material/bottons/roundedBtn.dart';
import 'package:the_disease_fighter/material/constants.dart';
import 'package:the_disease_fighter/material/rating_bar/flutter_rating_bar.dart';

class RateScreen extends StatefulWidget {
  @override
  _RateScreenState createState() => _RateScreenState();
}

class _RateScreenState extends State<RateScreen> {
  String comment = '';
  double? _rating;

  _getComment(String val) {
    setState(() {
      comment = val;
    });
  }

  @override
  Widget build(BuildContext context) {
    Widget _profilePicCard(BuildContext context) {
      return Stack(
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            height: 85,
            decoration: BoxDecoration(
                color: primaryColor.withOpacity(.1),
                borderRadius: BorderRadius.only(
                  bottomRight: Radius.circular(40),
                  bottomLeft: Radius.circular(40),
                )),
          ),
          Padding(
            padding: EdgeInsets.only(top: 10.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Column(
                  children: [
                    Stack(
                      // fit: StackFit.loose,
                      children: [
                        Container(
                          margin: EdgeInsets.only(bottom: 10),
                          decoration: BoxDecoration(
                              boxShadow: [
                                BoxShadow(
                                    color: subTextColor,
                                    offset: Offset(0.0, 1.0),
                                    blurRadius: 6.0,
                                    spreadRadius: 1),
                              ],
                              image: DecorationImage(
                                  image: AssetImage("assets/images/img_1.png"),
                                  fit: BoxFit.cover),
                              shape: BoxShape.circle,
                              border: Border.all(
                                  color: Color(0xffFDFDFD), width: 2),
                              color: backGroundColor),
                          height: 145,
                          width: 145,
                        ),
                      ],
                    ),
                    Text(
                      "Dr. Christina Frazier",
                      style: TextStyle(
                          color: darkBlueColor,
                          fontSize: 23,
                          fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Text(
                      "Mansoura, Egypt",
                      style: TextStyle(
                        color: subTextColor,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      );
    }

    return Scaffold(
      appBar: AppBar(
        leading: CircleButton(
          fun: () => Navigator.pop(context),
          icn: Icons.arrow_back,
          color: darkBlueColor,
        ),
        backgroundColor: primaryColor.withOpacity(.1),
        elevation: 0.0,
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          children: [
            _profilePicCard(context),
            Center(
                child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 15, vertical: 30),
              child: _ratingBar(),
            )),
            SizedBox(
              height: MediaQuery.of(context).size.height * .05,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                'Review',
                style: TextStyle(color: subTextColor),
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 10, bottom: 20, left: 20, right: 20),
              padding: EdgeInsets.all(5),
              decoration: BoxDecoration(
                  border: Border.all(
                      width: 1, color: Color(0xff707070).withOpacity(.15)),
                  color: backGroundColor,
                  borderRadius: BorderRadius.circular(10)),
              child: TextFormField(
                onChanged: _getComment,
                keyboardType: TextInputType.text,
                maxLines: 4,
                decoration: InputDecoration(
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.all(10),
                    hintText: "Write a review about doctor ...",
                    hintStyle: TextStyle(
                        color: subTextColor.withOpacity(.8), fontSize: 16)),
              ),
            ),
            Center(
              child: RoundedButton(
                fun: () => Navigator.pushReplacement(
                    context, MaterialPageRoute(builder: (context) => Home())),
                borderRadious: 15,
                text: 'Done',
                minWdthRatio: .5,
              ),
            ),
            SizedBox(
              height: 15,
            )
          ],
        ),
      ),
    );
  }

  Widget _ratingBar() {
    return RatingBar(
      initialRating: 0,
      direction: Axis.horizontal,
      allowHalfRating: false,
      alpha: 40,
      itemCount: 5,
      itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
      itemBuilder: (context, _) => Icon(
        Icons.star,
        color: primaryColor,
      ),
      onRatingUpdate: (rating) {
        setState(() {
          _rating = rating;
        });
      },
    );
  }
}
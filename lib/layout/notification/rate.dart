import 'package:flutter/material.dart';
import 'package:the_disease_fighter/layout/patient_screens/patient_home/home.dart';
import 'package:the_disease_fighter/localizations/localization/language/languages.dart';
import 'package:the_disease_fighter/material/bottons/circleBtn.dart';
import 'package:the_disease_fighter/material/bottons/roundedBtn.dart';
import 'package:the_disease_fighter/material/constants.dart';
import 'package:the_disease_fighter/material/inductors/loader_dialog.dart';
import 'package:the_disease_fighter/material/rating_bar/flutter_rating_bar.dart';
import 'package:the_disease_fighter/services/reviews/controllers/create_review_controller.dart';

class RateScreen extends StatefulWidget {
  @override
  _RateScreenState createState() => _RateScreenState();
}

class _RateScreenState extends State<RateScreen> {
  String _comment = '';
  double? _rating;
  String errorMessage = '';
  CreateReviewController _createReviewController = CreateReviewController();

  Future _userLogin() async {
    if (_comment != '' && _rating != 0) {
      LoaderDialog().onLoading(context);
      final data = await _createReviewController.createReview(
        comment: _comment,
        stars: _rating,
      );
      if (await data['success'] ?? false) {
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => Home(),
            ));
        setState(() {
          errorMessage = '';
        });
      } else {
        setState(() {
          errorMessage = data['message'].toString();
        });
        Navigator.of(context).pop();
      }
    } else {
      setState(() {
        errorMessage = 'Rate Value Must Be at least one star \n '
            'OR Comment mustn\'t be empty';
      });
    }
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
                Languages.of(context)!.rateScreen['reviewLabel'],
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
                onChanged: (String val) {
                  setState(() {
                    _comment = val;
                  });
                },
                keyboardType: TextInputType.text,
                maxLines: 4,
                decoration: InputDecoration(
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.all(10),
                    hintText: Languages.of(context)!.rateScreen['reviewHint'],
                    hintStyle: TextStyle(
                        color: subTextColor.withOpacity(.8), fontSize: 16)),
              ),
            ),
            errorMessage != ''
                ? Padding(
                    padding: EdgeInsets.fromLTRB(20, 0, 15, 20),
                    child: Text(
                      errorMessage,
                      style: TextStyle(color: Colors.red.withOpacity(.6)),
                    ),
                  )
                : SizedBox(),
            Center(
              child: RoundedButton(
                fun: _userLogin,
                borderRadious: 15,
                text: Languages.of(context)!.rateScreen['done'],
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
          rating = rating;
        });
      },
    );
  }
}

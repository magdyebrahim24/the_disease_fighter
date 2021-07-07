import 'package:flutter/material.dart';
import 'package:the_disease_fighter/layout/notification/notification.dart';
import 'package:the_disease_fighter/localizations/localization/language/languages.dart';
import 'package:the_disease_fighter/material/bottons/circleBtn.dart';
import 'package:the_disease_fighter/material/bottons/roundedBtn.dart';
import 'package:the_disease_fighter/material/constants.dart';
import 'package:the_disease_fighter/material/inductors/loader_dialog.dart';
import 'package:the_disease_fighter/material/rating_bar/flutter_rating_bar.dart';
import 'package:the_disease_fighter/material/widgets/materialBanner.dart';
import 'package:the_disease_fighter/services/reviews/controllers/create_review_controller.dart';

class RateScreen extends StatefulWidget {
  final sessionId;
  final data;

  const RateScreen({Key? key, this.sessionId, this.data}) : super(key: key);

  @override
  _RateScreenState createState() => _RateScreenState();
}

class _RateScreenState extends State<RateScreen> {
  String? comment;
  String? name;
  double? stars;
  String errorMessage = '';
  String? _bannerMessage;
  bool _showBanner = false;
  CreateReviewController _createReviewController = CreateReviewController();

  Future _createReview() async {
    setState(() {
      _showBanner = false;
    });
    if (comment != '' && stars != null) {
      LoaderDialog().onLoading(context);
      final data = await _createReviewController.createReview(
          comment: comment.toString(),
          stars: stars,
          sessionId: widget.sessionId.toString());
      if (await data['success'] ) {
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => Notifications(),
            ));
      } else if (await data['success'] == false &&
          await data['message'] == 'Fail to add review , check your internet') {
        setState(() {
          _bannerMessage = data['message'].toString();
          _showBanner = true;
        });
        Navigator.of(context).pop();
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
                                  image: NetworkImage(widget.data.doctorAvatar.toString()),
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
                      widget.data.doctorName.toString(),
                      style: TextStyle(
                          color: darkBlueColor,
                          fontSize: 23,
                          fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Text(
                      '${widget.data.specialization.toString()} Specialist',
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

    return Stack(
      children: [
        Scaffold(
          appBar: AppBar(
            leading: CircleButton(
              fun: () => Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Notifications(),)),
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
                  margin:
                      EdgeInsets.only(top: 10, bottom: 20, left: 20, right: 20),
                  padding: EdgeInsets.all(5),
                  decoration: BoxDecoration(
                      border: Border.all(
                          width: 1, color: Color(0xff707070).withOpacity(.15)),
                      color: backGroundColor,
                      borderRadius: BorderRadius.circular(10)),
                  child: TextFormField(
                    onChanged: (String val) {
                      setState(() {
                        comment = val;
                      });
                    },
                    keyboardType: TextInputType.text,
                    maxLines: 4,
                    decoration: InputDecoration(
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.all(10),
                        hintText:
                            Languages.of(context)!.rateScreen['reviewHint'],
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
                    fun: _createReview,
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
        ),
        _showBanner
            ? SizedBox(
                height: 150,
                child: ErrorMaterialBanner(
                  fun: () {
                    setState(() {
                      _showBanner = false;
                    });
                  },
                  errorMessage: _bannerMessage,
                ),
              )
            : SizedBox()
      ],
    );
  }

  Widget _ratingBar() {
    return RatingBar(
      initialRating: 0,
      direction: Axis.horizontal,
      allowHalfRating: false,
      alpha: 40,
      glowRadius: .5,
      glowColor: Colors.lightBlueAccent.withOpacity(.1),
      itemCount: 5,
      itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
      itemBuilder: (context, _) => Icon(
        Icons.star,
        color: primaryColor,
      ),
      onRatingUpdate: (value) {
        setState(() {
          stars = value;
        });
      },
    );
  }
}

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:the_disease_fighter/localizations/localization/language/languages.dart';
import 'package:the_disease_fighter/material/constants.dart';
import 'package:the_disease_fighter/material/widgets/rate_bar.dart';
import 'package:the_disease_fighter/services/reviews/controllers/get_doctor_reviews_controller.dart';

class DoctorReviews extends StatefulWidget {
  @override
  _DoctorReviewsState createState() => _DoctorReviewsState();
}

class _DoctorReviewsState extends State<DoctorReviews> {
  GetDoctorReviewsController _getReviews = GetDoctorReviewsController();

  @override
  void initState() {
    super.initState();
  }

  Future _getReviewsFun() async {
    return await _getReviews.loadReviewsList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          elevation: 1.5,
          leading: IconButton(
            onPressed: () => Navigator.pop(context),
            icon: Icon(
              Icons.arrow_back,
              color: darkBlueColor,
            ),
          ),
          title: Text(
            Languages.of(context)!.doctorDetails['reviewsTittle'],
            style: TextStyle(color: darkBlueColor),
          ),
          centerTitle: true,
        ),
        body: FutureBuilder<dynamic>(
            future: _getReviewsFun(),
            builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
              if (snapshot.hasData) {
                return ListView.builder(
                  itemBuilder: (ctx, index) {
                    return card(data: snapshot.data.reviews[index]);
                  },
                  itemCount: snapshot.data.reviews.length,
                  padding: EdgeInsets.symmetric(vertical: 15),
                );
              } else if (snapshot.hasError) {
                return emptyPage();
              } else {
                return Center(child: CircularProgressIndicator());
              }
            }));
  }

  Widget card({required data}) {
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
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
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
          SizedBox(
            width: 13,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  data.name.toString(),
                  style: TextStyle(
                    color: darkBlueColor,
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 6),
                  child: Rate(
                    clr: primaryColor,
                    rateValue: data.stars,
                  ),
                ),
                Text(
                  data.comment.toString(),
                  style: TextStyle(
                    color: subTextColor,
                  ),
                  maxLines: 7,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget emptyPage() {
    return Container(
      alignment: Alignment.center,
      child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        Icon(
          FontAwesomeIcons.folderOpen,
          color: darkBlueColor.withOpacity(.2),
          size: 70,
        ),
        Padding(
          padding: const EdgeInsets.only(top: 16),
          child: Text(
            'Empty Reviews List',
            style:
                TextStyle(color: darkBlueColor.withOpacity(.4), fontSize: 20),
          ),
        )
      ]),
    );
  }
}

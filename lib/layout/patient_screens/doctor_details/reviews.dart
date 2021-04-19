import 'package:flutter/material.dart';
import 'package:the_disease_fighter/material/constants.dart';

class DoctorReviews extends StatelessWidget {
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
          'Reviews',
          style: TextStyle(color: darkBlueColor),
        ),
        centerTitle: true,
      ),
      body: ListView.builder(
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
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
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
                        'Magdy Ebrahim',
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
                        'this doctor is very good and have a large experience and gave me good medicine this doctor is very good and have a large experience and gave me good medicinethis doctor is very good and have a large experience and gave me good medicine this doctor is very good and have a large experience and gave me good medicine',
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
        },
        itemCount: 10,
        padding: EdgeInsets.symmetric(vertical: 15),
      ),
    );
  }
}

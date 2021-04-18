import 'package:flutter/material.dart';
import 'package:the_disease_fighter/layout/doctor-screens/metting/upComing_metting.dart';
import 'package:the_disease_fighter/material/constants.dart';
import 'package:url_launcher/url_launcher.dart';

class MeetingCard extends StatelessWidget {
  const MeetingCard({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: EdgeInsets.symmetric(vertical: 12, horizontal: 15),
          margin: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                  color: subTextColor,
                  offset: Offset(1.0, 2.0),
                  blurRadius: 2.0,
                  spreadRadius: .2),
            ],
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(10)),
          ),
          width: MediaQuery.of(context).size.width,
          child: Row(
            children: [
              Container(
                  margin: EdgeInsets.only(right: 13),
                  height: 93,
                  width: 90,
                  decoration: BoxDecoration(
                    color: greyColor.withOpacity(.5),
                    borderRadius: BorderRadius.circular(10),
                    image: DecorationImage(
                      image: AssetImage('assets/doctors_img/doc2.jpg'),
                      fit: BoxFit.contain,
                    ),
                  )),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Text(
                            'Dr.Magdy Ebrahim',
                            maxLines: 2,
                            style: TextStyle(
                              color: darkBlueColor,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        MaterialButton(
                          onPressed: () => launch("tel://01552154105"),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                          child: Icon(
                            Icons.phone_rounded,
                            color: Colors.white,
                            size: 16,
                          ),
                          height: 30,
                          minWidth: 30,
                          padding: EdgeInsets.zero,
                          materialTapTargetSize:
                              MaterialTapTargetSize.shrinkWrap,
                          color: primaryColor,
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Row(
                      children: [
                        Icon(
                          Icons.access_time_outlined,
                          color: subTextColor,
                          size: 19,
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Text(
                          'Mon, Feb 19, 08.00am - 10.00am',
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontSize: 12,
                            color: subTextColor,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    MaterialButton(
                      onPressed: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => UpComingMeeting())),
                      child: Text(
                        'Show',
                        style: TextStyle(
                            fontSize: 12,
                            color: Colors.white,
                            fontWeight: FontWeight.bold),
                      ),
                      height: 33,
                      minWidth: MediaQuery.of(context).size.width * .8,
                      color: primaryColor,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                    )
                  ],
                ),
              ),
            ],
          ),
        )
      ],
    );
  }
}

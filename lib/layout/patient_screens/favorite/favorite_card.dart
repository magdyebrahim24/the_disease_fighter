import 'package:flutter/material.dart';
import 'package:the_disease_fighter/layout/patient_screens/doctor_details/doctor_details.dart';
import 'package:the_disease_fighter/layout/patient_screens/the_appointment/book_appointment.dart';
import 'package:the_disease_fighter/localizations/localization/language/languages.dart';
import 'package:the_disease_fighter/material/constants.dart';
import 'package:the_disease_fighter/material/widgets/rate_bar.dart';

// ignore: must_be_immutable
class FavoriteCard extends StatelessWidget {
  FavoriteCard({required this.data, this.iconWidget});

  final iconWidget;
  final data;

  @override
  Widget build(BuildContext context) {
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
                    builder: (context) => DoctorDetails(data: data))),
            child: Container(
                height: 92,
                width: 90,
                decoration: BoxDecoration(
                  color: Colors.grey,
                  image: DecorationImage(
                    image: NetworkImage(
                        "${data.avatar}"),
                    fit: BoxFit.cover,
                  ),
                  borderRadius: BorderRadius.circular(10),
                )),
          ),
          SizedBox(
            width: 12,
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
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(
                  height: 5,
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(0, 4, 5, 10),
                  child: Text(
                    data.clinicLocation.toString(),
                    style: TextStyle(
                      color: Color(0xff8A9EAD),
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                Rate(
                  clr: Color(0xff9ADFF7),
                  rateValue: data.reviews.rates,
                ),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              iconWidget,

              SizedBox(
                height: 20,
              ),
              MaterialButton(
                onPressed: () => Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (context) => BookAppointment(
                              docId: data.id,
                              docImage: data.avatar,
                              docName: data.name.toString(),
                            ))),
                height: 30,
                minWidth: 65,
                child: Text(
                  Languages.of(context)!.favoriteDoctors['bookBTN'],
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
    );
  }
}

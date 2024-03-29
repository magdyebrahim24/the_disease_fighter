import 'package:flutter/material.dart';
import 'package:the_disease_fighter/layout/patient_screens/doctor_details/doctor_details.dart';
import 'package:the_disease_fighter/material/constants.dart';
import 'package:the_disease_fighter/material/widgets/rate_bar.dart';

class DoctorCard extends StatelessWidget {
   DoctorCard({
    required this.item,
  });

  final item;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 15, horizontal: 15),
      margin: EdgeInsets.symmetric(vertical: 8, horizontal: 15),
      decoration: BoxDecoration(
        color: backGroundColor,
        borderRadius: BorderRadius.all(Radius.circular(10)),
        border: Border.all(color: Color(0xffBCE0FD)),
      ),
      child: InkWell(
        onTap: () => Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => DoctorDetails(
                  data: item,
                ))),
        child: Row(
          children: [
            Container(
                height: 55,
                width: 55,
                decoration: BoxDecoration(
                  color: greyColor.withOpacity(.5),
                  shape: BoxShape.circle,
                  image: DecorationImage(
                    image: NetworkImage(
                      item.avatar,
                    ),
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
                    '${item.name}',
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
                  Text(
                    // '${item.specialization[0].name}',
                    item.specialization.name.toString(),
                    style: TextStyle(
                      color: subTextColor,
                      fontSize: 14,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
            Rate(
              clr: primaryColor,
              rateValue: item.reviews.rates.toInt(),
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:the_disease_fighter/layout/patient_screens/doctor_details/doctor_details.dart';
import 'package:the_disease_fighter/material/constants.dart';
import 'package:the_disease_fighter/material/widgets/rate_bar.dart';
import 'package:the_disease_fighter/model/doctor_model.dart';

class DoctorCard extends StatelessWidget {
  const DoctorCard({
    required this.item,
  });

  final DoctorModel item;

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
                margin: EdgeInsets.only(right: 13),
                height: 55,
                width: 55,
                decoration: BoxDecoration(
                  color: greyColor.withOpacity(.5),
                  shape: BoxShape.circle,
                  image: DecorationImage(
                    image: AssetImage('${item.doctorImg}'),
                    fit: BoxFit.cover,
                  ),
                )),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Dr.${item.doctorName}',
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
                    '${item.pecialty}',
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
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Rate(
                  clr: primaryColor,
                  rateValue: item.rate.toInt(),
                ),
                SizedBox(
                  height: 8,
                ),
                Text(
                  '(99+)Patients',
                  style: TextStyle(color: subTextColor, fontSize: 12),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

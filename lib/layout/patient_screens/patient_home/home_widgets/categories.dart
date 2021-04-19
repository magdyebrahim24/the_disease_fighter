import 'package:flutter/material.dart';
import 'package:the_disease_fighter/layout/patient_screens/clinics/brain_clinic/brain_clinic.dart';
import 'package:the_disease_fighter/layout/patient_screens/clinics/clinic.dart';
import 'package:the_disease_fighter/material/constants.dart';

// ignore: must_be_immutable
class Categories extends StatelessWidget {
  List clinicsInfo = [
    {
      'img': 'assets/clinics_logo/Brain.png',
      'name': 'Brain',
    },
    {
      'img': 'assets/clinics_logo/Teeth.png',
      'name': 'Teeth',
    },
    {
      'img': 'assets/clinics_logo/chest.png',
      'name': 'Chest',
    },
    {
      'img': 'assets/clinics_logo/heart.png',
      'name': 'Heart',
    }
  ];

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 145,
      child: ListView.builder(
        itemCount: clinicsInfo.length,
        scrollDirection: Axis.horizontal,
        itemBuilder: (ctx, index) {
          return InkWell(
            onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => index == 0 || index == 1
                        ? BrainClinic(
                            clinicTittle: clinicsInfo[index]['name'],
                          )
                        : Clinic(
                            clinicTittle: clinicsInfo[index]['name'],
                          ))),
            child: Container(
              margin: EdgeInsets.all(5),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: primaryColor,
              ),
              padding: EdgeInsets.symmetric(horizontal: 25, vertical: 20),
              child: Column(
                children: [
                  Image.asset(
                    '${clinicsInfo[index]['img']}',
                    height: 55,
                    width: 55,
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Text(
                    '${clinicsInfo[index]['name']}',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.w700,
                        color: Colors.white),
                    maxLines: 2,
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

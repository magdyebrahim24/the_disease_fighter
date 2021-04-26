import 'package:flutter/material.dart';
import 'package:the_disease_fighter/layout/patient_screens/clinics/brain_clinic/brain_clinic.dart';
import 'package:the_disease_fighter/layout/patient_screens/clinics/clinic.dart';
import 'package:the_disease_fighter/localizations/localization/language/languages.dart';
import 'package:the_disease_fighter/material/constants.dart';

// ignore: must_be_immutable
class Categories extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    List clinicsInfo = [
      {
        'img': 'assets/clinics_logo/Brain.png',
        'name': '${Languages.of(context)!.allClinicsScreen['brainDoctors']}',
        'docName': '${Languages.of(context)!.allClinicsScreen['brainDoctors']}',
      },
      {
        'img': 'assets/clinics_logo/Teeth.png',
        'name': '${Languages.of(context)!.allClinicsScreen['teeth']}',
        'docName': '${Languages.of(context)!.allClinicsScreen['teethDoctors']}',
      },
      {
        'img': 'assets/clinics_logo/chest.png',
        'name': '${Languages.of(context)!.allClinicsScreen['chest']}',
        'docName': '${Languages.of(context)!.allClinicsScreen['chestDoctors']}',
      },
      {
        'img': 'assets/clinics_logo/heart.png',
        'name': '${Languages.of(context)!.allClinicsScreen['heart']}',
        'docName': '${Languages.of(context)!.allClinicsScreen['heartDoctors']}',
      },
      {
        'img': 'assets/clinics_logo/bone.png',
        'name': '${Languages.of(context)!.allClinicsScreen['bone']}',
        'docName': '${Languages.of(context)!.allClinicsScreen['boneDoctors']}',
      }
    ];
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
                    builder: (context) => index == 0 || index == 2
                        ? BrainClinic(
                            clinicTittle: clinicsInfo[index]['docName'],
                          )
                        : Clinic(
                            clinicTittle: clinicsInfo[index]['docName'],
                          ))),
            child: Container(
              margin: EdgeInsets.all(5),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: primaryColor,
              ),
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 17),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Image.asset(
                    '${clinicsInfo[index]['img']}',
                    height: 55,
                    width: 55,
                  ),
                  SizedBox(
                    height: 5,
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

import 'package:flutter/material.dart';
import 'package:the_disease_fighter/layout/patient_screens/clinics/brain_clinic/brain_clinic.dart';
import 'package:the_disease_fighter/layout/patient_screens/clinics/clinic.dart';
import 'package:the_disease_fighter/material/constants.dart';

// ignore: must_be_immutable
class Categories extends StatelessWidget {
  List clinicsInfo = [
    {
      'img': 'assets/clinics/any.png',
      'name': 'All',
    },
    {
      'img': 'assets/clinics/brain.png',
      'name': 'Brain',
    },
    {
      'img': 'assets/clinics/heart.png',
      'name': 'Heart',
    },
    {
      'img': 'assets/clinics/any.png',
      'name': 'Dermatology', //الامراض الجلدية
    },
    {
      'img': 'assets/clinics/teeth.png',
      'name': 'Teeth',
    },
    {
      'img': 'assets/clinics/teeth.png',
      'name': 'Bone',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 12, vertical: 20),
          child: Text(
            'Categories',
            style: kHeadStyle.copyWith(fontWeight: FontWeight.w600),
          ),
        ),
        SizedBox(
          height: 100,
          child: ListView.builder(
            itemCount: clinicsInfo.length,
            scrollDirection: Axis.horizontal,
            itemBuilder: (ctx, index) {
              return InkWell(
                onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => index != 1
                            ? Clinic(
                                clinicTittle: clinicsInfo[index]['name'],
                              )
                            : BrainClinic(
                                clinicTittle: clinicsInfo[index]['name'],
                              ))),
                child: Container(
                    margin: EdgeInsets.symmetric(horizontal: 5),
                    height: 85,
                    width: 80,
                    decoration: BoxDecoration(
                      color: Colors.grey,
                      image: DecorationImage(
                        image: AssetImage('${clinicsInfo[index]['img']}'),
                        fit: BoxFit.cover,
                      ),
                      borderRadius: BorderRadius.circular(10),
                    )),
              );
            },
          ),
        ),
      ],
    );
  }
}

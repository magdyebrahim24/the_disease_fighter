import 'package:flutter/material.dart';
import 'package:the_disease_fighter/layout/patient_screens/clinics/brain_clinic/brain_clinic.dart';
import 'package:the_disease_fighter/layout/patient_screens/clinics/clinic.dart';
import 'package:the_disease_fighter/localizations/localization/language/languages.dart';
import '../../../material/bottons/circleBtn.dart';
import '../../../material/constants.dart';

class AllClinics extends StatefulWidget {
  @override
  _AllClinicsState createState() => _AllClinicsState();
}

class _AllClinicsState extends State<AllClinics> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: CircleButton(
          fun: () => Navigator.pop(context),
          icn: Icons.arrow_back,
          color: darkBlueColor,
        ),
        centerTitle: true,
        title: Text(
          Languages.of(context)!.allClinicsScreen['tittle'],
          style: TextStyle(color: darkBlueColor),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(
              vertical: 15,
              horizontal: MediaQuery.of(context).size.width * .05),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  ClinicItem(

                    clinicLogo: 'assets/clinics_logo/Brain.png',
                    clinicName:
                        Languages.of(context)!.allClinicsScreen['brain'],
                    fun: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => BrainClinic(
                              clinicId: 1,
                                  clinicTittle: Languages.of(context)!
                                      .allClinicsScreen['brainDoctors'],
                                ))),
                  ),
                  ClinicItem(
                    clinicLogo: 'assets/clinics_logo/chest.png',
                    clinicName:
                        Languages.of(context)!.allClinicsScreen['chest'],
                    fun: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => BrainClinic(
                              clinicId: 11,
                                  clinicTittle: Languages.of(context)!
                                      .allClinicsScreen['chestDoctors'],
                                ))),
                  ),
                ],
              ),
              verticalItem(
                clinicLogo: 'assets/clinics_logo/any.png',
                clinicName: Languages.of(context)!.allClinicsScreen['physical'],
                fun: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => Clinic(
                          clinicId: 6,
                              clinicTittle: Languages.of(context)!
                                  .allClinicsScreen['physicalDoctors'],
                            ))),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  ClinicItem(
                    clinicLogo: 'assets/clinics_logo/bone.png',
                    clinicName: Languages.of(context)!.allClinicsScreen['bone'],
                    fun: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => Clinic(
                              clinicId: 5,
                                  clinicTittle: Languages.of(context)!
                                      .allClinicsScreen['boneDoctors'],
                                ))),
                  ),
                  ClinicItem(
                    clinicLogo: 'assets/clinics_logo/internal_medicine.png',
                    clinicName:
                        Languages.of(context)!.allClinicsScreen['internal'],
                    fun: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => Clinic(
                              clinicId: 10,
                                  clinicTittle: Languages.of(context)!
                                      .allClinicsScreen['internalDoctors'],
                                ))),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  ClinicItem(
                    clinicLogo: 'assets/clinics_logo/surgery.png',
                    clinicName:
                        Languages.of(context)!.allClinicsScreen['surgery'],
                    fun: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => Clinic(
                              clinicId: 8,
                                  clinicTittle: Languages.of(context)!
                                      .allClinicsScreen['surgeryDoctors'],
                                ))),
                  ),
                  ClinicItem(
                    clinicLogo: 'assets/clinics_logo/Teeth.png',
                    clinicName:
                        Languages.of(context)!.allClinicsScreen['teeth'],
                    fun: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => Clinic(
                              clinicId: 4,
                                  clinicTittle: Languages.of(context)!
                                      .allClinicsScreen['teethDoctors'],
                                ))),
                  ),
                ],
              ),
              verticalItem(
                clinicLogo: 'assets/clinics_logo/urology.png',
                clinicName: Languages.of(context)!.allClinicsScreen['urology'],
                fun: () => Navigator.push(
                    context,
                    MaterialPageRoute(

                        builder: (context) => Clinic(
                          clinicId: 7,
                              clinicTittle: Languages.of(context)!
                                  .allClinicsScreen['urologyDoctors'],
                            ))),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  ClinicItem(
                    clinicLogo: 'assets/clinics_logo/heart.png',
                    clinicName:
                        Languages.of(context)!.allClinicsScreen['heart'],
                    fun: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => Clinic(
                              clinicId: 2,
                                  clinicTittle: Languages.of(context)!
                                      .allClinicsScreen['heartDoctors'],
                                ))),
                  ),
                  ClinicItem(
                    clinicLogo: 'assets/clinics_logo/any.png',
                    clinicName: Languages.of(context)!.allClinicsScreen['kids'],
                    fun: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => Clinic(
                              clinicId: 9,
                                  clinicTittle: Languages.of(context)!
                                      .allClinicsScreen['kidsDoctors'],
                                ))),
                  ),
                ],
              ),
              verticalItem(
                clinicLogo: 'assets/clinics_logo/any.png',
                clinicName:
                    Languages.of(context)!.allClinicsScreen['dermatology'],
                fun: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => Clinic(
                          clinicId: 3,
                              clinicTittle: Languages.of(context)!
                                  .allClinicsScreen['dermatologyDoctors'],
                            ))),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget verticalItem({fun, clinicName, clinicLogo}) => InkWell(
        onTap: fun,
        child: Container(
          // width: MediaQuery.of(context).size.width * .8,
          margin: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: primaryColor,
          ),
          padding: EdgeInsets.symmetric(horizontal: 25, vertical: 15),
          child: Row(
            children: [
              Image.asset(
                clinicLogo,
                height: 50,
                width: 50,
              ),
              SizedBox(
                width: 15,
              ),
              Text(
                clinicName,
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                    color: Colors.white),
                maxLines: 2,
              )
            ],
          ),
        ),
      );
}

class ClinicItem extends StatelessWidget {
  ClinicItem({this.clinicName, this.clinicLogo, this.fun});

  final clinicName;
  final clinicLogo;
  final fun;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: InkWell(
        onTap: fun,
        child: Container(
          // width: ,
          // height: MediaQuery.of(context).size.width*.37,
          margin: EdgeInsets.all(5),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: primaryColor,
          ),
          padding: EdgeInsets.all(25),
          child: Column(
            children: [
              Image.asset(
                clinicLogo,
                height: 70,
                width: 70,
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                clinicName,
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                    color: Colors.white),
                maxLines: 2,
              )
            ],
          ),
        ),
      ),
    );
  }
}

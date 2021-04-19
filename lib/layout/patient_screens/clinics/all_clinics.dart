import 'package:flutter/material.dart';
import 'package:the_disease_fighter/layout/patient_screens/clinics/brain_clinic/brain_clinic.dart';
import 'package:the_disease_fighter/layout/patient_screens/clinics/clinic.dart';
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
          'All Clinics',
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
                    clinicName: 'Brain Clinic',
                    fun: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => BrainClinic(
                                  clinicTittle: 'Brain',
                                ))),
                  ),
                  ClinicItem(
                    clinicLogo: 'assets/clinics_logo/chest.png',
                    clinicName: 'Chest Clinic',
                    fun: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => BrainClinic(
                                  clinicTittle: 'Chest',
                                ))),
                  ),
                ],
              ),
              verticalItem(
                clinicLogo: 'assets/clinics_logo/any.png',
                clinicName: 'physical Clinic',
                fun: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => Clinic(
                              clinicTittle: 'physical',
                            ))),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  ClinicItem(
                    clinicLogo: 'assets/clinics_logo/bone.png',
                    clinicName: 'Bone Clinic',
                    fun: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => Clinic(
                                  clinicTittle: 'Bone',
                                ))),
                  ),
                  ClinicItem(
                    clinicLogo: 'assets/clinics_logo/urology.png',
                    clinicName: 'Urology Clinic',
                    fun: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => Clinic(
                                  clinicTittle: 'Urology',
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
                    clinicName: 'Surgery Clinic',
                    fun: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => Clinic(
                                  clinicTittle: 'Surgery',
                                ))),
                  ),
                  ClinicItem(
                    clinicLogo: 'assets/clinics_logo/Teeth.png',
                    clinicName: 'Teeth Clinic',
                    fun: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => Clinic(
                                  clinicTittle: 'Teeth',
                                ))),
                  ),
                ],
              ),
              verticalItem(
                clinicLogo: 'assets/clinics_logo/internal_medicine.png',
                clinicName: 'Internal Medicine',
                fun: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => Clinic(
                              clinicTittle: 'Internal Medicine',
                            ))),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  ClinicItem(
                    clinicLogo: 'assets/clinics_logo/heart.png',
                    clinicName: 'Heart Clinic',
                    fun: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => Clinic(
                                  clinicTittle: 'Heart',
                                ))),
                  ),
                  ClinicItem(
                    clinicLogo: 'assets/clinics_logo/any.png',
                    clinicName: 'Kids Clinic',
                    fun: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => Clinic(
                                  clinicTittle: 'Kids',
                                ))),
                  ),
                ],
              ),
              verticalItem(
                clinicLogo: 'assets/clinics_logo/any.png',
                clinicName: 'Dermatology Clinic',
                fun: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => Clinic(
                              clinicTittle: 'Dermatology',
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

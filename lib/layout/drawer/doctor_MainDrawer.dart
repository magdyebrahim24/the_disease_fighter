import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:the_disease_fighter/layout/doctor-screens/doctor_profile/doctor_profile.dart';
import 'package:the_disease_fighter/layout/doctor-screens/ml_model/chooseModel.dart';
import 'package:the_disease_fighter/layout/setting/about.dart';
import 'package:the_disease_fighter/layout/setting/settings.dart';
import 'package:the_disease_fighter/localizations/localization/language/languages.dart';
import 'package:the_disease_fighter/material/constants.dart';
import 'package:the_disease_fighter/material/widgets/patient-logo.dart';
import 'patient_MainDrawer.dart';

class DoctorMainDrawer extends StatefulWidget {
  @override
  _DoctorMainDrawerState createState() => _DoctorMainDrawerState();
}

class _DoctorMainDrawerState extends State<DoctorMainDrawer> {


  @override
  Widget build(BuildContext context) {
    return Drawer(
        child: Scaffold(
          backgroundColor: primaryColor.withOpacity(.5),
          body: SingleChildScrollView(
            child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => DoctorProfile()));
                    },
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width,
                      child: Padding(
                        padding: EdgeInsets.symmetric(vertical: 35),
                        child: PatientLogo(
                          imgHigh: 100.0,
                          imgWidth: 100.0,
                          showEmail: true,
                          nameColor: Colors.white,
                          nameSize: 16.0,
                        ),
                      ),
                    ),
                  ),                  Container(
                    width: MediaQuery.of(context).size.width,
                    padding: EdgeInsets.symmetric(vertical: 40, horizontal: 20),
                    decoration: BoxDecoration(
                        color: backGroundColor,
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(25),
                            topRight: Radius.circular(25))),
                    child: Text(
                      Languages.of(context)!.drawer['menu'],
                      style: TextStyle(
                        color: darkBlueColor,
                        fontSize: 17,
                      ),
                    ),
                  ),

                  DrawerTile(
                    leadingIconColor: primaryColor.withOpacity(.7),
                    icon: FontAwesomeIcons.user,
                    fun: () => Navigator.push(context,
                        MaterialPageRoute(builder: (context) => DoctorProfile())),
                    tittle: Languages.of(context)!.drawer['profile'],
                  ),
                  ListTile(
                    contentPadding: EdgeInsets.only(left: 40, right: 40),
                    onTap: () => Navigator.push(context,
                        MaterialPageRoute(builder: (context) => ChooseModel())),
                    tileColor: Colors.white,
                    leading: Image.asset(
                      "assets/icons/model.png",
                      width: 30,
                      height: 30,
                      fit: BoxFit.fill,
                    ),
                    title: Text(
                      Languages.of(context)!.drawer['usingAi'],
                      maxLines: 2,
                      style: TextStyle(color: darkBlueColor, fontSize: 16),
                    ),
                  ),
                  Divider(
                    height: 1,
                    thickness: 1,
                    color: backGroundColor,
                  ),
                  DrawerTile(
                    leadingIconColor: primaryColor.withOpacity(.7),
                    icon: Icons.settings_outlined,
                    fun: () => Navigator.push(context,
                        MaterialPageRoute(builder: (context) => Setting())),
                    tittle: Languages.of(context)!.drawer['setting'],
                  ),
                  DrawerTile(
                    leadingIconColor: primaryColor.withOpacity(.7),
                    icon: Icons.info_outline,
                    fun: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => About()));
                    },
                    tittle: Languages.of(context)!.drawer['about'],
                  ),
                  Container(
                    color: Colors.white,
                    height: MediaQuery.of(context).size.height > 560
                        ? MediaQuery.of(context).size.height - 560
                        : 20,
                    width: MediaQuery.of(context).size.width,
                  ),
                ]),
          ),
        ));
  }
}


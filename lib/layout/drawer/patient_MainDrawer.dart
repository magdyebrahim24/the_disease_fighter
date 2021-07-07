import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:the_disease_fighter/layout/patient_screens/favorite/favorite_doctors.dart';
import 'package:the_disease_fighter/layout/patient_screens/my_appointments/my_appointments.dart';
import 'package:the_disease_fighter/layout/patient_screens/patient_profile/patient_profile.dart';
import 'package:the_disease_fighter/layout/setting/about.dart';
import 'package:the_disease_fighter/layout/setting/settings.dart';
import 'package:the_disease_fighter/localizations/localization/language/languages.dart';
import 'package:the_disease_fighter/material/constants.dart';
import 'package:the_disease_fighter/material/widgets/patient-logo.dart';

// ignore: must_be_immutable
class PatientMainDrawer extends StatefulWidget {
  @override
  _PatientMainDrawerState createState() => _PatientMainDrawerState();
}

class _PatientMainDrawerState extends State<PatientMainDrawer> {
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
                          builder: (context) => PatientProfile()));
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
              ),
              Container(
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
                icon: FontAwesomeIcons.calendarCheck,
                fun: () => Navigator.push(context,
                    MaterialPageRoute(builder: (context) => MyAppointments())),
                tittle: Languages.of(context)!.drawer['appointments'],
              ),
              DrawerTile(
                leadingIconColor: primaryColor.withOpacity(.7),
                icon: FontAwesomeIcons.user,
                fun: () => Navigator.push(context,
                    MaterialPageRoute(builder: (context) => PatientProfile())),
                tittle: Languages.of(context)!.drawer['profile'],
              ),
              ListTile(
                contentPadding: EdgeInsets.only(left: 40, right: 40),
                tileColor: Colors.white,
                onTap: () => Navigator.push(context,
                    MaterialPageRoute(builder: (context) => FavoriteDoctors())),
                leading: Image.asset(
                  "assets/icons/doctorPrimary.png",
                  width: 20,
                  height: 25,
                  fit: BoxFit.fill,
                ),
                title: Text(
                  Languages.of(context)!.drawer['favoriteDoc'],
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
                height: MediaQuery.of(context).size.height > 600
                    ? MediaQuery.of(context).size.height - 600
                    : 20,
                width: MediaQuery.of(context).size.width,
              ),
            ]),
      ),
    ));
  }
}

class DrawerTile extends StatelessWidget {
  const DrawerTile({
    this.icon,
    this.tittle,
    this.fun,
    this.leadingIconColor,
  });

  final icon;
  final tittle;
  final fun;
  final leadingIconColor;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          contentPadding: EdgeInsets.only(
            left: 40,
            right: 40,
          ),
          onTap: fun,
          tileColor: Colors.white,
          leading: Icon(
            icon,
            color: leadingIconColor,
          ),
          title: Text(
            tittle,
            style: TextStyle(color: darkBlueColor, fontSize: 16),
          ),
        ),
        Divider(
          height: 1,
          color: backGroundColor,
          thickness: 1,
        ),
      ],
    );
  }
}

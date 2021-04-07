import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:the_disease_fighter/layout/sign/sign_in/sign_in.dart';
import 'package:the_disease_fighter/material/constants.dart';
import 'package:the_disease_fighter/material/widgets/patient-logo.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../main_drawer.dart';
import 'setting_screens/change_password.dart';

class Setting extends StatefulWidget {
  @override
  _SettingState createState() => _SettingState();
}

class _SettingState extends State<Setting> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: primaryColor,
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          leading: IconButton(
              icon: Icon(
                Icons.arrow_back,
                color: Colors.white,
              ),
              onPressed: () {
                Navigator.pop(context);
              }),
          backgroundColor: Colors.transparent,
          elevation: 0.0,
        ),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: EdgeInsets.only(top: 25),
                alignment: Alignment.bottomCenter,
                width: MediaQuery.of(context).size.width,
                height: 200,
                child: PatientLogo(
                  imgWidth: 92.0,
                  imgHigh: 92.0,
                  nameSize: 17.0,
                  nameColor: Colors.white,
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
                  "Settings",
                  style: TextStyle(
                    color: darkBlueColor,
                    fontSize: 16,
                  ),
                ),
              ),
              DrawerTile(
                icon: Icons.lock_open_outlined,
                fun: () => Navigator.push(context,
                    MaterialPageRoute(builder: (context) => ChangePassword())),
                tittle: "Password",
                leadingIconColor: primaryColor.withOpacity(.7),
              ),
              DrawerTile(
                icon: Icons.notifications_none_rounded,
                fun: () {},
                tittle: "Notification",
                leadingIconColor: primaryColor.withOpacity(.7),
              ),
              DrawerTile(
                icon: Icons.language,
                fun: () {},
                tittle: "Languge",
                leadingIconColor: primaryColor.withOpacity(.7),
              ),
              DrawerTile(
                leadingIconColor: primaryColor.withOpacity(.7),
                fun: () => Navigator.pushReplacement(
                    context, MaterialPageRoute(builder: (context) => SignIn())),
                icon: Icons.logout,
                tittle: 'Log Out',
              ),
              Container(
                alignment: Alignment.topLeft,
                width: MediaQuery.of(context).size.width,
                color: backGroundColor,
                padding: EdgeInsets.symmetric(vertical: 40, horizontal: 20),
                child: Text(
                  "Share App",
                  textAlign: TextAlign.end,
                  style: TextStyle(
                    color: darkBlueColor,
                    fontSize: 16,
                  ),
                ),
              ),
              DrawerTile(
                  leadingIconColor: darkBlueColor.withOpacity(.8),
                  icon: FontAwesomeIcons.facebookF,
                  tittle: 'Facebook',
                  fun: () => launch('https://www.facebook.com/')),
              DrawerTile(
                leadingIconColor: primaryColor.withOpacity(.8),
                icon: FontAwesomeIcons.twitter,
                tittle: 'Twitter',
                fun: () => launch('https://www.twitter.com/'),
              ),
              DrawerTile(
                  leadingIconColor: Colors.green,
                  icon: FontAwesomeIcons.whatsapp,
                  tittle: 'WhatsApp',
                  fun: () async => await launch(
                      "https://wa.me/01552154105?text=Share The Medical Solution App With Your Friends - link :https://twitter.com/migoo_1_3?s=09&fbclid=IwAR3k92gBqVe_OWHYwn2jsvsdV7hpO_lCB9dqJdS2SSM-7yhlaD_i8S7nsKM")),
            ],
          ),
        ));
  }
}

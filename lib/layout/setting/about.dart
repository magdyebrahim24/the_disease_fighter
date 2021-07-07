import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:the_disease_fighter/localizations/localization/language/languages.dart';
import 'package:the_disease_fighter/material/bottons/circleBtn.dart';
import 'package:the_disease_fighter/material/constants.dart';
import 'package:url_launcher/url_launcher.dart';
import 'dart:core';
import '../patient_MainDrawer.dart';
import 'terms_of_use.dart';

class About extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 1,
        centerTitle: true,
        title: Text(
          Languages.of(context)!.aboutScreen['about'],
          style: TextStyle(color: darkBlueColor),
        ),
        leading: CircleButton(
          icn: Icons.arrow_back,
          color: darkBlueColor,
          fun: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            ListTile(
              tileColor: Colors.white,
              subtitle: Text(
                "10.1.6",
                style: TextStyle(
                  color: subTextColor,
                  fontSize: 16,
                ),
              ),
              title: Text(
                Languages.of(context)!.aboutScreen['version'],
                style: TextStyle(
                  color: darkBlueColor,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              contentPadding:
                  EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            ),
            Divider(
              height: 1,
              thickness: 2,
              color: backGroundColor,
            ),
            ListTile(
              onTap: () => Navigator.push(context,
                  MaterialPageRoute(builder: (context) => TermsOfUse())),
              tileColor: Colors.white,
              title: Text(
                Languages.of(context)!.aboutScreen['termsOfUse'],
                style: TextStyle(
                  color: darkBlueColor,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              trailing: Icon(
                Icons.arrow_forward_ios_sharp,
                color: subTextColor,
                size: 20,
              ),
              contentPadding:
                  EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: EdgeInsets.symmetric(vertical: 35, horizontal: 20),
                  child: Text(
                    Languages.of(context)!.aboutScreen['contactUS'],
                    textAlign: TextAlign.end,
                    style: TextStyle(
                      color: darkBlueColor,
                      fontSize: 16,
                    ),
                  ),
                ),
              ],
            ),
            DrawerTile(
                leadingIconColor: darkBlueColor.withOpacity(.8),
                icon: FontAwesomeIcons.facebookF,
                tittle: Languages.of(context)!.aboutScreen['faceBook'],
                fun: () => launch('https://www.facebook.com/migoamasha224')),
            DrawerTile(
                leadingIconColor: primaryColor.withOpacity(.8),
                icon: FontAwesomeIcons.twitter,
                tittle: Languages.of(context)!.aboutScreen['twitter'],
                fun: () => launch(
                    'https://twitter.com/migoo_1_3?s=09&fbclid=IwAR3k92gBqVe_OWHYwn2jsvsdV7hpO_lCB9dqJdS2SSM-7yhlaD_i8S7nsKM')),
            DrawerTile(
              leadingIconColor: primaryColor,
              icon: FontAwesomeIcons.google,
              tittle: Languages.of(context)!.aboutScreen['gmail'],
              fun: () => launch(_emailLaunchUri.toString()),
            ),
            DrawerTile(
                leadingIconColor: Colors.green,
                icon: FontAwesomeIcons.whatsapp,
                tittle: Languages.of(context)!.aboutScreen['whatsApp'],
                fun: () async => await launch(
                    "https://wa.me/01552154105?text=write your problem")),
          ],
        ),
      ),
    );
  }

  final Uri _emailLaunchUri =
      Uri(scheme: 'mailto', path: 'migoamasha27@gmail.com', queryParameters: {
    'subject': 'Please Write Your Problem .',
  });
}

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:the_disease_fighter/layout/drawer/drawer_screens/doctor/ml_model/model-screen.dart';
import 'package:the_disease_fighter/layout/drawer/drawer_screens/doctor/doctor_profile/doctor_profile.dart';
import 'package:the_disease_fighter/material/constants.dart';
import 'drawer_screens/about.dart';
import 'drawer_screens/setting/settings.dart';
import 'patient_MainDrawer.dart';

class DoctorMainDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
        child: Stack(
      children: [
        Container(
          height: MediaQuery.of(context).size.height * .5,
          width: MediaQuery.of(context).size.width,
          color: primaryColor.withOpacity(.6),
        ),
        SingleChildScrollView(
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
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 35),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Column(
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                  boxShadow: [
                                    BoxShadow(
                                        color: subTextColor,
                                        offset: Offset(0.0, 1.0),
                                        blurRadius: 6.0,
                                        spreadRadius: 1.5),
                                  ],
                                  image: DecorationImage(
                                      image:
                                          AssetImage("assets/images/img_1.png"),
                                      fit: BoxFit.cover),
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                      color: Color(0xffFDFDFD), width: 2),
                                  color: backGroundColor),
                              margin: EdgeInsets.all(10),
                              height: 90,
                              width: 90,
                            ),
                            Text(
                              "ALia Ahmed Ali",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                                fontSize: 16,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  padding: EdgeInsets.symmetric(vertical: 40, horizontal: 15),
                  decoration: BoxDecoration(
                      color: backGroundColor,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(25),
                          topRight: Radius.circular(25))),
                  child: Text(
                    "Menu",
                    style: TextStyle(
                      color: darkBlueColor,
                      fontSize: 17,
                    ),
                  ),
                ),

                DrawerTile(
                    leadingIconColor: primaryColor.withOpacity(.7),
                    icon: FontAwesomeIcons.user,
                    fun: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => DoctorProfile())),
                    tittle: "Profile"),
                ListTile(
                  contentPadding: EdgeInsets.only(left: 40),
                  onTap: () => Navigator.push(context,
                      MaterialPageRoute(builder: (context) => ModelScreen())),
                  tileColor: Colors.white,
                  leading: Image.asset(
                    "assets/icons/model.png",
                    width: 30,
                    height: 30,
                    fit: BoxFit.fill,
                  ),
                  title: Text(
                    'Using AI Model',
                    style: TextStyle(color: darkBlueColor, fontSize: 16),
                  ),
                ),
                Divider(
                  height: 1,
                  color: backGroundColor,
                ),
                DrawerTile(
                    leadingIconColor: primaryColor.withOpacity(.7),
                    icon: Icons.settings_outlined,
                    fun: () => Navigator.push(context,
                        MaterialPageRoute(builder: (context) => Setting())),
                    tittle: "Setting"),
                DrawerTile(
                  leadingIconColor: primaryColor.withOpacity(.7),
                  icon: Icons.info_outline,
                  fun: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => About()));
                  },
                  tittle: "About",
                ),
                // FittedBox(child: Container(color: Colors.white,height: 10,),fit: BoxFit.fitHeight,
                // ),
              ]),
        ),
      ],
    ));
  }
}

// class DrawerTile extends StatelessWidget {
//   const DrawerTile({
//     this.icon,
//     this.tittle,
//     this.fun,
//     this.leadingIconColor,
//   });
//
//   final icon;
//   final tittle;
//   final fun;
//   final leadingIconColor;
//
//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//         ListTile(
//           contentPadding: EdgeInsets.only(left: 40),
//           onTap: fun(),
//           tileColor: Colors.white,
//           leading: Icon(
//             icon,
//             color: leadingIconColor,
//           ),
//           title: Text(
//             tittle,
//             style: TextStyle(color: darkBlueColor, fontSize: 16),
//           ),
//         ),
//         Divider(
//           height: 1,
//           color: backGroundColor,
//           thickness: 1,
//         ),
//       ],
//     );
//   }
// }

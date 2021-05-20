import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:the_disease_fighter/layout/drawer/drawer_screens/doctor/ml_model/model-screen.dart';
import 'package:the_disease_fighter/layout/drawer/drawer_screens/doctor/doctor_profile/doctor_profile.dart';
import 'package:the_disease_fighter/localizations/localization/language/languages.dart';
import 'package:the_disease_fighter/material/constants.dart';
import 'package:the_disease_fighter/services/logged_user/controllers/get_user_info_controller.dart';

import 'drawer_screens/about.dart';
import 'drawer_screens/setting/settings.dart';
import 'patient_MainDrawer.dart';

class DoctorMainDrawer extends StatefulWidget {
  @override
  _DoctorMainDrawerState createState() => _DoctorMainDrawerState();
}

class _DoctorMainDrawerState extends State<DoctorMainDrawer> {
  CurrentUserInfoController _userInfoController = CurrentUserInfoController();

  Future _getUserData() async {
    var data = await _userInfoController.loadUserData();
    return Future.value(data);
  }
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
                FutureBuilder<dynamic>(
                    future: _getUserData(),
                    builder: (BuildContext context,
                        AsyncSnapshot<dynamic> snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Container(
                            height: 222,
                            alignment: Alignment.center,
                            child: CircularProgressIndicator());
                      } else {
                        if (snapshot.error != null) {
                          return SizedBox(
                            height: 222,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                IconButton(
                                    icon: Icon(
                                      Icons.refresh,
                                      color: Colors.white,
                                      size: 40,
                                    ),
                                    onPressed: () {
                                      setState(() {
                                        _getUserData();
                                      });
                                    }),
                                SizedBox(
                                  height: 15,
                                ),
                                Text(
                                  'Failed To Load',
                                  style: TextStyle(
                                      color: subTextColor, fontSize: 16),
                                ),
                              ],
                            ),
                          );
                        } else {
                          return InkWell(
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
                                                image: NetworkImage(snapshot
                                                    .data.currentUser.avatar),
                                                fit: BoxFit.cover),
                                            shape: BoxShape.circle,
                                            border: Border.all(
                                                color: Color(0xffFDFDFD),
                                                width: 2),
                                            color: backGroundColor),
                                        margin: EdgeInsets.all(10),
                                        height: 90,
                                        width: 90,
                                      ),
                                      Text(
                                        snapshot.data.currentUser.name.toString(),
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white,
                                          fontSize: 16,
                                        ),
                                      ),
                                      SizedBox(
                                        height: 6,
                                      ),
                                      Text(
                                        snapshot.data.currentUser.email.toString(),
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(color: subTextColor),
                                      )
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          );
                        }
                      }
                    }),
                /*InkWell(
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
                ),*/
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
                  icon: FontAwesomeIcons.user,
                  fun: () => Navigator.push(context,
                      MaterialPageRoute(builder: (context) => DoctorProfile())),
                  tittle: Languages.of(context)!.drawer['profile'],
                ),
                ListTile(
                  contentPadding: EdgeInsets.only(left: 40, right: 40),
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
                    Languages.of(context)!.drawer['usingAi'],
                    maxLines: 2,
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

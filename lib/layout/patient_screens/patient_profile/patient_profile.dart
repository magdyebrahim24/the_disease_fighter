import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter/material.dart';
import 'package:the_disease_fighter/layout/patient_screens/patient_home/home.dart';
import 'package:the_disease_fighter/layout/user_profile_picture/show_profile_image.dart';
import 'package:the_disease_fighter/localizations/localization/language/languages.dart';
import 'package:the_disease_fighter/material/bottons/circleBtn.dart';
import 'package:the_disease_fighter/material/constants.dart';
import 'package:the_disease_fighter/material/widgets/no_internet_widget.dart';
import 'package:the_disease_fighter/services/logged_user/controllers/get_user_info_controller.dart';

import 'edit_patient_profile.dart';

// ignore: must_be_immutable
class PatientProfile extends StatefulWidget {
  @override
  _PatientProfileState createState() => _PatientProfileState();
}

class _PatientProfileState extends State<PatientProfile> {
  CurrentUserInfoController _userInfoController = CurrentUserInfoController();
  var info;

  Future _getUserData() async {
    var data = await _userInfoController.loadUserData();
    info = data;
    return data;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: FutureBuilder<dynamic>(
          future: _getUserData(),
          builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
            if (!snapshot.hasData && !snapshot.hasError) {
              return Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  AppBar(
                    elevation: 0.0,
                    leading: IconButton(
                      onPressed: () => Navigator.pop(context),
                      icon: Icon(
                        Icons.arrow_back,
                        color: primaryColor,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * .35,
                  ),
                  CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation(primaryColor),
                  ),
                ],
              );
            } else {
              if (snapshot.hasError) {
                return Column(
                  children: [
                    AppBar(
                      elevation: 0,
                      leading: CircleButton(
                        icn: Icons.arrow_back,
                        fun: () => Navigator.pop(context),
                        color: primaryColor,
                      ),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * .3,
                    ),
                    FailLoadWidget(
                      fun: () {
                        setState(() {
                          _getUserData();
                        });
                      },
                    ),
                  ],
                );
              } else {
                return SingleChildScrollView(
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        AppBar(
                          elevation: 0.0,
                          backgroundColor: primaryColor.withOpacity(.1),
                          leading: CircleButton(
                            color: primaryColor,
                            fun: () => Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Home())),
                            icn: Icons.arrow_back,
                          ),
                          actions: [
                            IconButton(
                              color: primaryColor,
                              icon: Icon(
                                FontAwesomeIcons.solidEdit,
                                size: 20,
                              ),
                              onPressed: () => Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => EditPatientProfile(
                                            data: info.currentUser,
                                          ))),
                            )
                          ],
                        ),
                        _profilePicCard(context,
                            imgUrl: snapshot.data.currentUser.avatar.toString(),
                            name: snapshot.data.currentUser.name.toString()),
                        Container(
                          margin: EdgeInsets.symmetric(
                              vertical: 10, horizontal: 12),
                          padding: EdgeInsets.only(
                              top: 15, left: 15, right: 15, bottom: 40),
                          width: MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                  color: subTextColor.withOpacity(.5),
                                  offset: Offset(1.0, 2.0),
                                  blurRadius: 4.0,
                                  spreadRadius: .4),
                            ],
                            borderRadius: BorderRadius.circular(10),
                            color: backGroundColor,
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                Languages.of(context)!
                                    .patientProfile['about'].toString(),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Text(
                                snapshot.data.currentUser.about ?? 'not provided',
                                style: TextStyle(
                                  fontSize: 13,
                                  color: subTextColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                        item(
                          label: Languages.of(context)!
                              .patientProfile['phoneLabel'],
                          initialValue:
                              snapshot.data.currentUser.phone.toString(),
                          hintText: Languages.of(context)!
                              .patientProfile['phoneHint'],
                          textInputType: TextInputType.phone,
                        ),
                        item(
                            label:
                                Languages.of(context)!.patientProfile['email'],
                            initialValue:
                                snapshot.data.currentUser.email.toString(),
                            hintText: Languages.of(context)!
                                .patientProfile['emailHint'],
                            textInputType: TextInputType.emailAddress),
                        item(
                            label: Languages.of(context)!
                                .patientProfile['addressLabel'],
                            initialValue:
                                snapshot.data.currentUser.location.toString(),
                            hintText: Languages.of(context)!
                                .patientProfile['addressHint'],
                            textInputType: TextInputType.streetAddress),
                        Row(
                          children: [
                            Expanded(
                              child: item(
                                  label: Languages.of(context)!
                                      .patientProfile['DateLabel'],
                                  initialValue:
                                      snapshot.data.currentUser.dob.toString(),
                                  hintText: Languages.of(context)!
                                      .patientProfile['helperText'],
                                  textInputType: TextInputType.streetAddress),
                            ),
                            Expanded(
                              child: item(
                                  label: Languages.of(context)!
                                      .patientProfile['genderLabel'],
                                  initialValue: snapshot.data.currentUser.gender
                                      .toString(),
                                  hintText: Languages.of(context)!
                                      .patientProfile['genderHint'],
                                  textInputType: TextInputType.streetAddress),
                            ),
                          ],
                        )
                      ]),
                );
              }
            }
          }),
    );
  }

  Widget item({
    required label,
    hintText,
    initialValue,
    textInputType,
  }) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10, horizontal: 12),
      padding: EdgeInsets.only(top: 15, left: 15, right: 15, bottom: 10),
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
              color: subTextColor.withOpacity(.5),
              offset: Offset(1.0, 2.0),
              blurRadius: 4.0,
              spreadRadius: .4),
        ],
        borderRadius: BorderRadius.circular(10),
        color: backGroundColor,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label),
          Container(
            margin: EdgeInsets.symmetric(vertical: 7),
            padding: EdgeInsets.symmetric(horizontal: 10),
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.white,
            ),
            child: Row(
              children: [
                Expanded(
                  child: TextFormField(
                    readOnly: true,
                    initialValue: initialValue,
                    decoration: InputDecoration(
                      hintText: hintText,
                      hintStyle: TextStyle(
                        color: subTextColor.withOpacity(.6),
                      ),
                      border: InputBorder.none,
                    ),
                    keyboardType: textInputType,
                    cursorColor: primaryColor,
                    style: TextStyle(color: darkBlueColor.withOpacity(.8)),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _profilePicCard(BuildContext context, {imgUrl, name}) {
    return Stack(
      children: [
        Container(
          width: MediaQuery.of(context).size.width,
          height: 85,
          decoration: BoxDecoration(
              color: primaryColor.withOpacity(.1),
              borderRadius: BorderRadius.only(
                bottomRight: Radius.circular(40),
                bottomLeft: Radius.circular(40),
              )),
        ),
        Padding(
          padding: EdgeInsets.only(top: 10.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Column(
                children: [
                  InkWell(
                    onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ProfilePicture(
                            userAvatar: imgUrl.toString(),
                            route: PatientProfile(),
                          ),
                        )),
                    highlightColor: Colors.transparent,
                    splashColor: Colors.transparent,
                    child: CachedNetworkImage(
                      imageUrl: imgUrl.toString(),
                      fit: BoxFit.cover,
                      imageBuilder: (context, imageProvider) => Container(
                        height: 145,
                        width: 145,
                        margin: EdgeInsets.only(bottom: 10),
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: imageProvider,
                            fit: BoxFit.cover,
                          ),
                          boxShadow: [
                            BoxShadow(
                                color: subTextColor,
                                offset: Offset(0.0, 1.0),
                                blurRadius: 6.0,
                                spreadRadius: 1),
                          ],
                          shape: BoxShape.circle,
                          border:
                              Border.all(color: Color(0xffFDFDFD), width: 2),
                          color: backGroundColor,
                        ),
                      ),
                      placeholder: (context, url) => CircularProgressIndicator(valueColor: AlwaysStoppedAnimation(darkBlueColor),),
                      errorWidget: (context, url, error) => SizedBox(child: Icon(Icons.error,size: 150,color: Colors.grey.withOpacity(.2),)),
                    ),
                  ),
                  Text(
                    name.toString(),
                    style: TextStyle(
                      color: darkBlueColor,
                      fontSize: 23,
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}

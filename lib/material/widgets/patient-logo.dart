import 'package:flutter/material.dart';
import 'package:the_disease_fighter/services/logged_user/controllers/get_user_info_controller.dart';

import '../constants.dart';

class PatientLogo extends StatefulWidget {
  PatientLogo({
    this.imgHigh = 240.0,
    this.imgWidth = 240.0,
    this.nameColor,
    this.nameSize = 18.0,
  });
  final imgHigh;
  final imgWidth;
  final nameColor;
  final nameSize;

  @override
  _PatientLogoState createState() => _PatientLogoState();
}

class _PatientLogoState extends State<PatientLogo> {
  CurrentUserInfoController _userInfoController = CurrentUserInfoController();
  Future _getUserData() async {
    var data = await _userInfoController.loadUserData();
    return Future.value(data);
  }
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        FutureBuilder<dynamic>(
            future: _getUserData(),
            builder: (BuildContext context,
                AsyncSnapshot<dynamic> snapshot) {
              if (!snapshot.hasData && !snapshot.hasError) {
                return Container(
                    height: 120,
                    alignment: Alignment.center,
                    child: CircularProgressIndicator());
              } else {
                if (snapshot.error != null) {
                  return SizedBox(
                    height: 150,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        IconButton(
                            icon: Icon(
                              Icons.refresh,
                              color: darkBlueColor,
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
                  return Column(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                  color: subTextColor,
                                  offset: Offset(1.0, 2.0),
                                  blurRadius: 6.0,
                                  spreadRadius: 1),
                            ],
                            image: DecorationImage(
                                image: NetworkImage(snapshot.data.currentUser.avatar),
                                fit: BoxFit.cover),
                            shape: BoxShape.circle,
                            border: Border.all(color: Color(0xffFDFDFD), width: 2),
                            color: backGroundColor),
                        margin: EdgeInsets.all(10),
                        height: widget.imgHigh,
                        width: widget.imgWidth,
                      ),
                      Text(
                        snapshot.data.currentUser.name,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis
                        ,style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: widget.nameColor,
                          fontSize: widget.nameSize,
                        ),
                      ),
                    ],
                  );
                }
              }
            }),

       // SizedBox(
        //  height: 7,
       // ),
       // Text(
         // "Egypt - Mansoura",
         // style: TextStyle(color: subTextColor),
       // )
      ],
    );
  }
}

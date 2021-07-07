import 'dart:convert';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../constants.dart';

class PatientLogo extends StatefulWidget {
  PatientLogo({
    this.imgHigh = 240.0,
    this.imgWidth = 240.0,
    this.nameColor,
    this.nameSize = 18.0, this.showEmail = false,
  });
  final imgHigh;
  final imgWidth;
  final nameColor;
  final nameSize;
  final showEmail;

  @override
  _PatientLogoState createState() => _PatientLogoState();
}

class _PatientLogoState extends State<PatientLogo> {

  String? userAvatar;
  Future _getUserData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    String? userData = prefs.getString('userData');
    String? getUserAvatar = prefs.getString('userAvatar');
    String? getUserName = prefs.getString('userName');
      userAvatar = getUserAvatar ;
    Map<String,dynamic> userDataMap = jsonDecode(userData!) as Map<String, dynamic>;
    return [userDataMap,getUserAvatar,getUserName];
  }
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        FutureBuilder<dynamic>(
            future: _getUserData(),
            builder: (BuildContext context,
                AsyncSnapshot<dynamic> snapshot) {
                  return Column(
                    children: [
                      CachedNetworkImage(
                        imageUrl: snapshot.data[1].toString(),
                        fit: BoxFit.cover,
                        imageBuilder: (context, imageProvider) => Container(
                          height: widget.imgWidth,
                          width: widget.imgWidth,
                          margin: EdgeInsets.all(10),
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
                        placeholder: (context, url) => Container(alignment: Alignment.center,width: widget.imgWidth + 10 ,height: widget.imgHigh + 10 ,child: CircularProgressIndicator(valueColor: AlwaysStoppedAnimation(darkBlueColor),)),
                        errorWidget: (context, url, error) => SizedBox(child: Container(margin: EdgeInsets.all(15),decoration: BoxDecoration(color:Colors.grey.withOpacity(.5),shape: BoxShape.circle ),),width: widget.imgWidth+10,height: widget.imgHigh+10),
                      ),
                      Text(
                        snapshot.data[2].toString(),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis
                        ,style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: widget.nameColor,
                          fontSize: widget.nameSize,
                        ),
                      ),
                      SizedBox(
                        height: 6,
                      ),
                     widget.showEmail ? Text(
                        snapshot.data[0]['email']
                            .toString(),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(color: subTextColor),
                      ) : SizedBox()
                    ],
                  );
              }
            ),
      ],
    );
  }
}

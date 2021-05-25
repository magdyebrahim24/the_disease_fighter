import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:the_disease_fighter/layout/drawer/drawer_screens/doctor/doctor_profile/edit_doctor_info/edit_doctor_info.dart';
import 'package:the_disease_fighter/layout/drawer/drawer_screens/doctor/doctor_profile/widgets/previous_appointments.dart';
import 'package:the_disease_fighter/layout/drawer/drawer_screens/patient/my_appointments/my_appointments.dart';
import 'package:the_disease_fighter/localizations/localization/language/languages.dart';
import 'package:the_disease_fighter/material/bottons/circleBtn.dart';
import 'package:the_disease_fighter/material/constants.dart';
import 'package:the_disease_fighter/services/logged_user/controllers/getDoctorData.dart';

import 'widgets/doc_information.dart';

class DoctorProfile extends StatefulWidget {
  @override
  const DoctorProfile();

  _DoctorProfileState createState() => _DoctorProfileState();
}

class _DoctorProfileState extends State<DoctorProfile> {
  CurrentDoctorController _doctorController = CurrentDoctorController();
  var info;

  Future _getUserData() async {
    var data = await _doctorController.loadDoctorData();
    info = data;
    return data;
  }

  Widget patientImage({imgUrl}) {
    return Column(
      children: [
        Container(
          decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                    color: subTextColor,
                    offset: Offset(1.0, 2.0),
                    blurRadius: 6.0,
                    spreadRadius: .5),
              ],
              image: DecorationImage(
                  image: NetworkImage(imgUrl.toString()), fit: BoxFit.cover),
              shape: BoxShape.circle,
              border: Border.all(color: Color(0xffFDFDFD), width: 2),
              color: backGroundColor),
          margin: EdgeInsets.only(top: 40),
          height: 120,
          width: 120,
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: DefaultTabController(
          length: 2,
          child: FutureBuilder<dynamic>(
              future: _getUserData(),
              builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Container(
                      height: 222,
                      alignment: Alignment.center,
                      child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
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
                        height: MediaQuery.of(context).size.height * .35,
                      ),
                      IconButton(
                          icon: Icon(
                            Icons.refresh,
                            color: primaryColor,
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
                        style: TextStyle(color: subTextColor, fontSize: 16),
                      ),
                    ],
                  );
                } else {
                  return NestedScrollView(
                    headerSliverBuilder:
                        (BuildContext context, bool innerBoxIsScrolled) {
                      return [
                        SliverAppBar(
                          elevation: 0.0,
                          leading: CircleButton(
                            icn: Icons.arrow_back,
                            fun: () => Navigator.pop(context),
                            color: primaryColor,
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
                                      builder: (ctx) => EditDoctorProfile(
                                            data: snapshot.data.currentUser,
                                          ))),
                            ),
                          ],
                          pinned: true,
                          snap: false,
                          floating: true,
                          expandedHeight: 210.0,
                          flexibleSpace: FlexibleSpaceBar(
                            title: Text(
                              snapshot.data.currentUser.name.toString(),
                              style: TextStyle(color: darkBlueColor),
                            ),
                            centerTitle: true,
                            background: patientImage(
                                imgUrl: snapshot.data.currentUser.avatar),
                          ),
                        ),
                        SliverPersistentHeader(
                          delegate: SliverAppBarDelegate(
                            TabBar(
                              indicatorPadding: EdgeInsets.all(10),
                              indicatorColor: primaryColor,
                              labelPadding: EdgeInsets.all(10),
                              unselectedLabelColor: subTextColor,
                              indicatorSize: TabBarIndicatorSize.tab,
                              labelColor: primaryColor,
                              indicator: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: Colors.white),
                              tabs: [
                                tapBarWidget(
                                    label: Languages.of(context)!
                                        .doctorProfile['ifoTap']),
                                tapBarWidget(
                                    label: Languages.of(context)!
                                        .doctorProfile['previousTap']),
                              ],
                            ),
                          ),
                          pinned: true,
                        ),
                      ];
                    },
                    body: TabBarView(
                      children: [
                        DocInformation(
                          data: snapshot.data.currentUser,
                        ),
                        PreviousAppointments(),
                      ],
                    ),
                  );
                }
              }),
        ));
  }

  Widget tapBarWidget({String? label}) {
    return Container(
      child: Text(label!),
      alignment: Alignment.center,
    );
  }
}

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:the_disease_fighter/layout/drawer/drawer_screens/doctor/doctor_profile/edit_doctor_info/edit_doctor_info.dart';
import 'package:the_disease_fighter/layout/drawer/drawer_screens/doctor/doctor_profile/widgets/previous_appointments.dart';
import 'package:the_disease_fighter/layout/drawer/drawer_screens/patient/my_appointments/my_appointments.dart';
import 'package:the_disease_fighter/material/bottons/circleBtn.dart';
import 'package:the_disease_fighter/material/constants.dart';

import 'widgets/doc_information.dart';

class DoctorProfile extends StatefulWidget {
  @override
  _DoctorProfileState createState() => _DoctorProfileState();
}

class _DoctorProfileState extends State<DoctorProfile> {
  Widget patientImage() {
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
                  image: AssetImage("assets/images/img_1.png"),
                  fit: BoxFit.cover),
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
          child: NestedScrollView(
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
                      onPressed: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (ctx) => EditDoctorProfile())),
                    ),
                  ],
                  pinned: true,
                  snap: false,
                  floating: true,
                  expandedHeight: 210.0,
                  flexibleSpace: FlexibleSpaceBar(
                    title: Text(
                      'Magdy Ebrahim',
                      style: TextStyle(color: darkBlueColor),
                    ),
                    centerTitle: true,
                    background: patientImage(),
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
                        tapBarWidget(label: 'Information'),
                        tapBarWidget(label: 'Previous'),
                      ],
                    ),
                  ),
                  pinned: true,
                ),
              ];
            },
            body: TabBarView(
              children: [
                DocInformation(),
                PreviousAppointments(),
              ],
            ),
          ),
        ));
  }

  Widget tapBarWidget({String label}) {
    return Container(
      child: Text(label),
      alignment: Alignment.center,
    );
  }
}

import 'package:flutter/material.dart';
import 'package:the_disease_fighter/layout/patient_screens/patient_home/home.dart';
import 'package:the_disease_fighter/material/bottons/circleBtn.dart';
import 'package:the_disease_fighter/material/constants.dart';
import 'appointments_screens/appointments.dart';
import 'appointments_screens/previous_appointments.dart';

class MyAppointments extends StatefulWidget {
  @override
  _MyAppointmentsState createState() => _MyAppointmentsState();
}

class _MyAppointmentsState extends State<MyAppointments> {
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
                    fun: () => Navigator.pushReplacement(
                        context, MaterialPageRoute(builder: (ctx) => Home())),
                    color: darkBlueColor,
                  ),
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
                  delegate: _SliverAppBarDelegate(
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
                        tapBarWidget(label: 'My Appointments'),
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
                AppointmentsBuilder(),
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

class _SliverAppBarDelegate extends SliverPersistentHeaderDelegate {
  _SliverAppBarDelegate(this._tabBar);

  final TabBar _tabBar;

  @override
  double get minExtent => _tabBar.preferredSize.height;

  @override
  double get maxExtent => _tabBar.preferredSize.height;

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 10),
      child: _tabBar,
      decoration: BoxDecoration(
          color: backGroundColor, borderRadius: BorderRadius.circular(10)),
    );
  }

  @override
  bool shouldRebuild(_SliverAppBarDelegate oldDelegate) {
    return false;
  }
}

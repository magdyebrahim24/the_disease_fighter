import 'package:flutter/material.dart';
import 'package:the_disease_fighter/layout/patient_screens/patient_home/home.dart';
import 'package:the_disease_fighter/localizations/localization/language/languages.dart';
import 'package:the_disease_fighter/material/bottons/circleBtn.dart';
import 'package:the_disease_fighter/material/constants.dart';
import 'appointments_screens/appointments.dart';
import 'appointments_screens/previous_appointments.dart';
import 'package:the_disease_fighter/services/sessions/controllers/my_appointment_controller.dart';
class MyAppointments extends StatefulWidget {
  @override
  _MyAppointmentsState createState() => _MyAppointmentsState();
}
class _MyAppointmentsState extends State<MyAppointments>{
  MyAppointmentsController _appointmentsController=MyAppointmentsController();

  Future _loadMyAppointments() async {
    var data = await _appointmentsController.getMyAppointments();
    return Future.value(data);
  }

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
                  expandedHeight: 200.0,
                  flexibleSpace: FlexibleSpaceBar(
                    title: Text(
                      ' Magdy Ebrahim',
                      maxLines: 1,
                      softWrap: true,
                      style: TextStyle(color: darkBlueColor, fontSize: 16),
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
                        tapBarWidget(
                            label: Languages.of(context)!
                                .patientAppointments['myAppointmentTap']),
                        tapBarWidget(
                            label: Languages.of(context)!
                                .patientAppointments['previousTap']),
                      ],
                    ),
                  ),
                  pinned: true,
                ),
              ];
            },
            body:FutureBuilder<dynamic>(
                future: _loadMyAppointments(),
                builder: (BuildContext context,
                    AsyncSnapshot<dynamic> snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Container(
                        height: 222,
                        alignment: Alignment.center,
                        child: CircularProgressIndicator());
                  } else {
                    if (snapshot.error==null) {
                      return SizedBox(
                        height: 222,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            IconButton(
                                icon: Icon(
                                  Icons.refresh,
                                  color: primaryColor,
                                  size: 40,
                                ),
                                onPressed: () {
                                  setState(() {
                                    _loadMyAppointments();
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
                      return  TabBarView(
                        children: [
                          AppointmentsBuilder(),
                          PreviousAppointments(),
                        ],
                      );
                    }
                  }
                }),

          ),
        ));
  }

  Widget tapBarWidget({String? label}) {
    return Container(
      child: Text(label!),
      alignment: Alignment.center,
    );
  }
}

class SliverAppBarDelegate extends SliverPersistentHeaderDelegate {
  SliverAppBarDelegate(this._tabBar);

  final TabBar _tabBar;

  @override
  double get minExtent => _tabBar.preferredSize.height + 7;

  @override
  double get maxExtent => _tabBar.preferredSize.height + 8;

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(
      margin: EdgeInsets.symmetric(
        horizontal: 15,
      ),
      child: _tabBar,
      decoration: BoxDecoration(
          color: backGroundColor, borderRadius: BorderRadius.circular(10)),
    );
  }

  @override
  bool shouldRebuild(SliverAppBarDelegate oldDelegate) {
    return false;
  }
}

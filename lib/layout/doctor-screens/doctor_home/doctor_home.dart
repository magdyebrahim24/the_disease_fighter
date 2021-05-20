import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:the_disease_fighter/layout/doctor-screens/doctor_home/widgets/all_appointments.dart';
import 'package:the_disease_fighter/layout/doctor-screens/doctor_home/widgets/today_appointments.dart';
import 'package:the_disease_fighter/layout/drawer/doctor_MainDrawer.dart';
import 'package:the_disease_fighter/layout/notification/notification.dart';
import 'package:the_disease_fighter/localizations/localization/language/languages.dart';
import 'package:the_disease_fighter/material/bottons/circleBtn.dart';
import 'package:the_disease_fighter/material/constants.dart';
import 'package:the_disease_fighter/services/doctorScreens/controllers/get_all_doctors_sessions_controller.dart';
class DoctorHome extends StatefulWidget {
  @override
  _DoctorHomeState createState() => _DoctorHomeState();
}

class _DoctorHomeState extends State<DoctorHome> with TickerProviderStateMixin {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  DoctorAppointmentsController _doctorAppointmentsController=DoctorAppointmentsController();




  Future _loadDoctorAppointments() async {
    var data = await _doctorAppointmentsController.getDoctorAppointments();
    return Future.value(data);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Colors.white,
      body: DefaultTabController(
        length: 2,
        child: NestedScrollView(
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return [
              SliverAppBar(
                elevation: 0.0,
                leading: ImgButton(
                  fun: () => _scaffoldKey.currentState!.openDrawer(),
                  img: 'assets/icons/menu.png',
                  imgWidth: 22.0,
                  imgHigh: 15.0,
                ),
                actions: [
                  ImgButton(
                    fun: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => Notifications())),
                    img: 'assets/icons/notification.png',
                    imgHigh: 35.0,
                    imgWidth: 35.0,
                  ),
                ],
                pinned: true,
                snap: true,
                floating: true,
                bottom: _CustomTabBar(
                  TabBar(

                    indicatorPadding:
                        EdgeInsets.symmetric(vertical: 8, horizontal: 15),
                    indicatorColor: primaryColor,
                    unselectedLabelColor: subTextColor,
                    indicatorSize: TabBarIndicatorSize.tab,
                    labelColor: primaryColor,
                    indicator: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.white),
                    tabs: [
                      tapBarWidget(
                          label: Languages.of(context)!.doctorHome['todayTap']),
                      tapBarWidget(
                          label: Languages.of(context)!.doctorHome['allTap']),
                    ],
                  ),
                ),
              ),
            ];
          },
          body: FutureBuilder<dynamic>(
              future: _loadDoctorAppointments(),
              builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                if (!snapshot.hasData && !snapshot.hasError) {
                  return Container(
                      height: 222,
                      alignment: Alignment.center,
                      child: CircularProgressIndicator());
                } else {
                  if (snapshot.hasError) {
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
                                  _loadDoctorAppointments();
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
                      ),
                    );
                  } else {
                    return TabBarView(
                      children: [
                        TodayAppointments( data:snapshot.data.currentAppointments != null
                    ? snapshot.data.currentAppointments
                        : []),
                        AllAppointments(data:snapshot.data.futureAppointments
                            != null
                          ? snapshot.data.futureAppointments
                          : []),

                      ],
                    );
                  }
                }
              }), /*TabBarView(
            children: [
              TodayAppointments(),
              AllAppointments(),
            ],
          ),*/
        ),
      ),
      drawer: DoctorMainDrawer(),
    );
  }

  Widget tapBarWidget({required String label}) {
    return Container(
      child: Text(label),
      alignment: Alignment.center,
    );
  }
}

class _CustomTabBar extends Container implements PreferredSizeWidget {
  _CustomTabBar(this._tabBar);

  final TabBar _tabBar;

  @override
  Size get preferredSize => _tabBar.preferredSize;

  @override
  Widget build(BuildContext context) => Container(
        height: _tabBar.preferredSize.height,
        margin: EdgeInsets.symmetric(horizontal: 15),
        child: _tabBar,
        decoration: BoxDecoration(
            color: backGroundColor, borderRadius: BorderRadius.circular(10)),
      );
}

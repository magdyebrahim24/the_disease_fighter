import 'dart:convert';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:the_disease_fighter/layout/patient_screens/patient_home/home.dart';
import 'package:the_disease_fighter/localizations/localization/language/languages.dart';
import 'package:the_disease_fighter/material/bottons/circleBtn.dart';
import 'package:the_disease_fighter/material/constants.dart';
import 'package:the_disease_fighter/material/widgets/no_internet_widget.dart';
import 'package:the_disease_fighter/services/sessions/controllers/my_appointment_controller.dart';
import 'appointments_screens/appointments.dart';
import 'appointments_screens/previous_appointments.dart';
class MyAppointments extends StatefulWidget {
  final showSnackBar;
  final snackBarMessage;

  MyAppointments({this.showSnackBar = false, this.snackBarMessage});

  @override
  _MyAppointmentsState createState() => _MyAppointmentsState();
}

class _MyAppointmentsState extends State<MyAppointments>{
  Map _userData = {};
  String? _name = '';
  MyAppointmentsController _appointmentsController = MyAppointmentsController();
  Future _getUserData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? userData = prefs.getString('userData');
    Map<String,dynamic> userDataMap = jsonDecode(userData!) as Map<String, dynamic>;
    String? getUserName = prefs.getString('userName');
    setState(() {
      _userData = userDataMap ;
      _name = getUserName ;
    });
    // return userDataMap;
  }
    Future _loadMyAppointments() async {
    var data = await _appointmentsController.getMyAppointments();
    return Future.value(data);
  }



  @override
  void initState() {
    widget.showSnackBar
        ? Future.delayed(Duration.zero, () async {
            snackBarr();
          })
        // ignore: unnecessary_statements
        : null;
    _getUserData();
    super.initState();
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
                        expandedHeight: 215.0,
                        flexibleSpace: FlexibleSpaceBar(
                          title: Text(
                            _name.toString(),
                            maxLines: 1,
                            softWrap: true,
                            style: TextStyle(color: darkBlueColor, fontSize: 16),
                          ),
                          centerTitle: true,
                          background: patientImage(imgUrl: _userData['avatar'].toString(),),
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
                  if (!snapshot.hasData && !snapshot.hasError) {
                    return Container(
                        height: 222,
                        alignment: Alignment.center,
                        child: CircularProgressIndicator());
                  } else {
                    if (snapshot.hasError) {
                      return FailLoadWidget(
                        fun: () {
                          setState(() {
                            _loadMyAppointments();
                          });
                        },
                      );
                    } else {
                      return  TabBarView(
                        children: [
                          AppointmentsBuilder(
                              data: snapshot.data.futureAppointments != null
                                  ? snapshot.data.futureAppointments
                                  : []),
                          PreviousAppointments(
                            data: snapshot.data.previousAppointments != null
                                ? snapshot.data.previousAppointments
                                : [],
                          ),
                        ],
                      );
                    }
                  }
                }),
          ),
        ));
  }
  Widget patientImage({imgUrl}) {
    return CachedNetworkImage(
      imageUrl: imgUrl,
      height: 120,width: 120,
      fit: BoxFit.cover,
      imageBuilder: (context, imageProvider) => Container(
        height: 120,
        width: 120,
        margin: EdgeInsets.all(55),
        decoration: BoxDecoration(
          image: DecorationImage(
            image: imageProvider,
            fit: BoxFit.scaleDown,
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
      placeholder: (context, url) => Container(alignment: Alignment.center,width: 120,height: 120,child: CircularProgressIndicator(valueColor: AlwaysStoppedAnimation(darkBlueColor),)),
      errorWidget: (context, url, error) => Icon(Icons.error,color: Colors.redAccent,size: 100,),
    );
  }

  Widget tapBarWidget({String? label}) {
    return Container(
      child: Text(label!),
      alignment: Alignment.center,
    );
  }

  snackBarr() {
    final snackBar = SnackBar(
      content: Text(
        widget.snackBarMessage.toString(),
        style: TextStyle(
            fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
      ),
      backgroundColor: primaryColor,
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
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
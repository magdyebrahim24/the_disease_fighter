import 'package:flutter/material.dart';
import 'package:the_disease_fighter/layout/patient_screens/patient_home/home.dart';
import 'package:the_disease_fighter/layout/patient_screens/search/search.dart';
import 'package:the_disease_fighter/layout/patient_screens/view_doctors/builder/all_builder.dart';
import 'package:the_disease_fighter/localizations/localization/language/languages.dart';
import 'package:the_disease_fighter/material/bottons/circleBtn.dart';
import 'package:the_disease_fighter/material/constants.dart';
import 'builder/specialist_builder.dart';

class ViewAllDoctors extends StatefulWidget {
  @override
  _ViewAllDoctorsState createState() => _ViewAllDoctorsState();
}

class _ViewAllDoctorsState extends State<ViewAllDoctors>
    with SingleTickerProviderStateMixin {
  TabController? _tabController;

  @override
  void initState() {
    _tabController = TabController(initialIndex: 0, length: 12, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NestedScrollView(
        floatHeaderSlivers: true,
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return <Widget>[
            SliverAppBar(
              leading: CircleButton(
                color: primaryColor,
                fun: () =>
                    Navigator.pushReplacement(
                    context, MaterialPageRoute(builder: (context) => Home())),
                icn: Icons.arrow_back,
              ),
              actions: [
                ImgButton(
                  fun: () => Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (context) => Search())),
                  img: 'assets/icons/search2.png',
                  imgWidth: 34.0,
                  imgHigh: 20.0,
                ),
              ],
              pinned: true,
              floating: true,
              snap: true,
              bottom: TabBar(
                  indicatorPadding: EdgeInsets.all(5),
                  controller: _tabController,
                  indicatorColor: primaryColor,
                  isScrollable: true,
                  labelPadding: EdgeInsets.symmetric(vertical: 0),
                  unselectedLabelColor: subTextColor,
                  indicatorSize: TabBarIndicatorSize.label,
                  labelColor: Color(0xff8A9EAD),
                  indicator: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Color(0xffE6F7FD)),
                  tabs: [
                    tapBarWidget(
                      label: Languages.of(context)!.allDoctors['allTap'].toString(),
                    ),
                    tapBarWidget(
                      label: Languages.of(context)!.allDoctors['brain'].toString(),
                    ),
                    tapBarWidget(
                      label: Languages.of(context)!.allDoctors['chest'].toString(),
                    ),
                    tapBarWidget(
                      label: Languages.of(context)!.allDoctors['physical'].toString(),
                    ),
                    tapBarWidget(
                      label: Languages.of(context)!.allDoctors['bone'].toString(),
                    ),
                    tapBarWidget(
                      label:
                          Languages.of(context)!.allDoctors['internalMedicine'].toString(),
                    ),
                    tapBarWidget(
                      label: Languages.of(context)!.allDoctors['surgery'].toString(),
                    ),
                    tapBarWidget(
                      label: Languages.of(context)!.allDoctors['teeth'].toString(),
                    ),
                    tapBarWidget(
                      label: Languages.of(context)!.allDoctors['urology'].toString(),
                    ),
                    tapBarWidget(
                      label: Languages.of(context)!.allDoctors['heart'].toString(),
                    ),
                    tapBarWidget(
                      label: Languages.of(context)!.allDoctors['kids'].toString(),
                    ),
                    tapBarWidget(
                      label: Languages.of(context)!.allDoctors['dermatology'].toString(),
                    ),
                  ]),
              forceElevated: innerBoxIsScrolled,
            ),
          ];
        },
        body: TabBarView(
          controller: _tabController,
          children: [
            ViewDocAllBuilder( ),
            ViewDocSpecialistBuilder(
              clinicId: 1,
            ),
            ViewDocSpecialistBuilder(
              clinicId: 11,
            ),
            ViewDocSpecialistBuilder(
              clinicId: 6,
            ),
            ViewDocSpecialistBuilder(
              clinicId: 5,
            ),
            ViewDocSpecialistBuilder(
              clinicId: 10,
            ),
            ViewDocSpecialistBuilder(
              clinicId: 8,
            ),
            ViewDocSpecialistBuilder(
              clinicId: 4,
            ),
            ViewDocSpecialistBuilder(
              clinicId: 7,
            ),
            ViewDocSpecialistBuilder(
              clinicId: 2,
            ),
            ViewDocSpecialistBuilder(
              clinicId: 9,
            ),
            ViewDocSpecialistBuilder(
              clinicId: 3,
            ),
          ],
        ),
      ),
    );
  }

  Widget tapBarWidget({required String label}) {
    return Container(
      child: Text(label),
      alignment: Alignment.center,
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
    );
  }

  @override
  void dispose() {
    _tabController!.dispose();
    super.dispose();
  }
}
import 'package:flutter/material.dart';
import 'package:the_disease_fighter/data/doctor_data.dart';
import 'package:the_disease_fighter/layout/patient_screens/patient_home/home.dart';
import 'package:the_disease_fighter/layout/patient_screens/search/search.dart';
import 'package:the_disease_fighter/material/bottons/circleBtn.dart';
import 'package:the_disease_fighter/material/constants.dart';
import 'view_doc_builder.dart';

class ViewAllDoctors extends StatefulWidget {
  @override
  _ViewAllDoctorsState createState() => _ViewAllDoctorsState();
}

class _ViewAllDoctorsState extends State<ViewAllDoctors>
    with SingleTickerProviderStateMixin {
  TabController _tabController;

  @override
  void initState() {
    _tabController = TabController(initialIndex: 0, length: 5, vsync: this);
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
                fun: () => Navigator.pushReplacement(
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
              // snap: true,
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
                      label: 'All',
                    ),
                    tapBarWidget(
                      label: 'Heart',
                    ),
                    tapBarWidget(
                      label: 'Teeth',
                    ),
                    tapBarWidget(
                      label: 'Brain',
                    ),
                    tapBarWidget(
                      label: 'Brain',
                    ),
                  ]),
              forceElevated: innerBoxIsScrolled,
            ),
          ];
        },
        body: TabBarView(
          controller: _tabController,
          children: [
            ViewDocBuilder(data: doctorsData),
            ViewDocBuilder(data: doctorsData5),
            ViewDocBuilder(data: doctorsData10),
            ViewDocBuilder(data: doctorsData15),
            ViewDocBuilder(data: doctorsData20),
          ],
        ),
      ),
    );
  }

  Widget tapBarWidget({String label}) {
    return Container(
      child: Text(label),
      alignment: Alignment.center,
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
    );
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }
}

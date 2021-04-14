import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:the_disease_fighter/layout/doctor-screens/metting/upComing_metting.dart';
import 'package:the_disease_fighter/layout/drawer/doctor_MainDrawer.dart';
import 'package:the_disease_fighter/layout/notification/notification.dart';
import 'package:the_disease_fighter/material/bottons/circleBtn.dart';
import 'package:the_disease_fighter/material/constants.dart';
import 'package:url_launcher/url_launcher.dart';

class DoctorHome extends StatefulWidget {
  @override
  _DoctorHomeState createState() => _DoctorHomeState();
}

class _DoctorHomeState extends State<DoctorHome> with TickerProviderStateMixin {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

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
                  fun: () => _scaffoldKey.currentState.openDrawer(),
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
                      tapBarWidget(label: 'Today'),
                      tapBarWidget(label: 'All'),
                    ],
                  ),
                ),
              ),
              SliverAppBar(
                toolbarHeight: 40,
                automaticallyImplyLeading: false,
                title: Text(
                  'All Appointments',
                  style: kHeadStyle,
                ),
                actions: [
                  ImgButton(
                    fun: () {},
                    img: 'assets/icons/filter.png',
                    imgWidth: 20.0,
                    imgHigh: 25.0,
                  ),
                ],
                pinned: true,
              ),
              // SliverPersistentHeader(delegate: _SliverTittleDelegate('All'),pinned: true,),
            ];
          },
          body: TabBarView(
            children: [
              MeetingCard(),
              ListView(
                children: [
                  for (var i = 0; i < 10; i++) MeetingCard(),
                ],
              )

              // Stack(
              //   children: [
              //     ListView.builder(itemBuilder: (ctx,index){
              //       return Container(
              //         height: 50,
              //         color: Colors.amber,
              //         child: Text('mmmmmmmmmmmm',style: TextStyle(color: Colors.white),),
              //       );
              //     }),
              //     Row(
              //       children: [
              //         Text(
              //           'All Appointments',
              //           style: kHeadStyle,
              //         ),
              //         ImgButton(
              //           fun: () {},
              //           img: 'assets/icons/filter.png',
              //           imgWidth: 20.0,
              //           imgHigh: 25.0,
              //         ),
              //       ],
              //     ),
              //   ],
              // ),
              // CustomScrollView(
              //   slivers: <Widget>[
              //     SliverAppBar(
              //       pinned: true,
              //       // floating: true,
              //       // snap: true,
              //       toolbarHeight: 40,
              //       title: Text(
              //         'All Appointments',
              //         style: kHeadStyle,
              //       ),
              //       automaticallyImplyLeading: false,
              //       actions: [
              //         ImgButton(
              //           fun: () {},
              //           img: 'assets/icons/filter.png',
              //           imgWidth: 20.0,
              //           imgHigh: 25.0,
              //         ),
              //       ],
              //     ),
              //     SliverList(
              //       // Use a delegate to build items as they're scrolled on screen.
              //       delegate: SliverChildBuilderDelegate(
              //         // The builder function returns a ListTile with a title that
              //         // displays the index of the current item.
              //         (context, index) => ListTile(title: Text('Item #$index')),
              //         // Builds 1000 ListTiles
              //         childCount: 1000,
              //       ),
              //     ),
              //   ],
              // ),
            ],
          ),
        ),
      ),
      drawer: DoctorMainDrawer(),
    );
  }

  Widget tapBarWidget({String label}) {
    return Container(
      child: Text(label),
      alignment: Alignment.center,
    );
  }
}

class MeetingCard extends StatelessWidget {
  const MeetingCard({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: EdgeInsets.symmetric(vertical: 12, horizontal: 15),
          margin: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                  color: subTextColor,
                  offset: Offset(1.0, 2.0),
                  blurRadius: 2.0,
                  spreadRadius: .2),
            ],
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(10)),
          ),
          width: MediaQuery.of(context).size.width,
          child: Row(
            children: [
              Container(
                  margin: EdgeInsets.only(right: 13),
                  height: 93,
                  width: 90,
                  decoration: BoxDecoration(
                    color: greyColor.withOpacity(.5),
                    borderRadius: BorderRadius.circular(10),
                    image: DecorationImage(
                      image: AssetImage('assets/doctors_img/doc2.jpg'),
                      fit: BoxFit.contain,
                    ),
                  )),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Text(
                            'Dr.Magdy Ebrahim',
                            maxLines: 2,
                            style: TextStyle(
                              color: darkBlueColor,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        MaterialButton(
                          onPressed: () => launch("tel://01552154105"),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                          child: Icon(
                            Icons.phone_rounded,
                            color: Colors.white,
                            size: 16,
                          ),
                          height: 30,
                          minWidth: 30,
                          padding: EdgeInsets.zero,
                          materialTapTargetSize:
                              MaterialTapTargetSize.shrinkWrap,
                          color: primaryColor,
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Row(
                      children: [
                        Icon(
                          Icons.access_time_outlined,
                          color: subTextColor,
                          size: 19,
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Text(
                          'Mon, Feb 19, 08.00am - 10.00am',
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontSize: 12,
                            color: subTextColor,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    MaterialButton(
                      onPressed: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => UpComingMeeting())),
                      child: Text(
                        'Show',
                        style: TextStyle(
                            fontSize: 12,
                            color: Colors.white,
                            fontWeight: FontWeight.bold),
                      ),
                      height: 33,
                      minWidth: MediaQuery.of(context).size.width * .8,
                      color: primaryColor,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                    )
                  ],
                ),
              ),
            ],
          ),
        )
      ],
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

// class _SliverTittleDelegate extends SliverPersistentHeaderDelegate {
//   _SliverTittleDelegate(this.text);
//
//   final text;
//
//   @override
//   double get minExtent => 60;
//
//   @override
//   double get maxExtent => 70;
//
//   @override
//   Widget build(
//       BuildContext context, double shrinkOffset, bool overlapsContent) {
//     return Padding(
//       padding: EdgeInsets.symmetric(horizontal: 0),
//       child: Row(
//         children: [
//           Expanded(child: Text('$text Appointments')),
//           ImgButton(
//             fun: () {},
//             img: 'assets/icons/filter.png',
//             imgWidth: 20.0,
//             imgHigh: 25.0,
//           ),
//         ],
//       ),
//     );
//   }
//
//   @override
//   bool shouldRebuild(_SliverTittleDelegate oldDelegate) {
//     return true;
//   }
// }

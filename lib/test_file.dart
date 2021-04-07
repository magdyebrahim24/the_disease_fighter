import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'data/doctor_data.dart';
import 'layout/doctor-screens/patient-card.dart';
import 'layout/patient_screens/patient_home/home_widgets/categories.dart';
import 'layout/patient_screens/view_doctors/view_all_doctors.dart';
import 'material/bottons/circleBtn.dart';
import 'material/constants.dart';

class Test extends StatefulWidget {
  @override
  _TestState createState() => _TestState();
}

class _TestState extends State<Test> {
  ScrollController _scrollController = new ScrollController();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  String searchTxt = '';

  // _getSearchText(String searchTxt) {
  //   setState(() {
  //     this.searchTxt = searchTxt;
  //   });
  // }

  bool showUpButton = false;

  @override
  void initState() {
    _scrollController.addListener(() {
      if (_scrollController.position.pixels > 600) {
        setState(() {
          showUpButton = true;
        });
      } else {
        setState(() {
          showUpButton = false;
        });
      }
    });
    getDoctorData();
    super.initState();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      key: _scaffoldKey,
      appBar: AppBar(
        elevation: 0,
        leading: CircleButton(
          color: darkBlueColor,
          icn: Icons.drag_handle_outlined,
          fun: () => _scaffoldKey.currentState.openDrawer(),
        ),
        actions: [
          // SearchBar(inputTextFunction: _getSearchText),
        ],
        title: Text('Home'),
        centerTitle: true,
      ),
      body: searchTxt == ''
          ? ListView(
              controller: _scrollController,
              children: [
                Categories(),
                listHead(),
                for (var item in doctorsData)
                  DoctorCard(
                    item: item,
                  )
              ],
            )
          : Container(
              color: Colors.amber,
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
            ),

      // body: ListView.builder(
      //         controller: _scrollController,
      //         itemCount: doctorsData.length,
      //         itemBuilder: (ctx, index){
      //           return index == 0 ? CategoriesBuilder()
      //               : index == 1 ? listHead():  Container(
      //             padding: EdgeInsets.symmetric(vertical: 15, horizontal: 15),
      //             margin: EdgeInsets.symmetric(vertical: 8,horizontal: 15),
      //             decoration: BoxDecoration(
      //               color: Color(0xffF4F4F4),
      //               borderRadius: BorderRadius.all(Radius.circular(10)),
      //               border: Border.all(color: Color(0xffBCE0FD)),
      //             ),
      //             child: InkWell(
      //               onTap: () => Navigator.pushReplacement(
      //                   context,
      //                   MaterialPageRoute(
      //                       builder: (context) => DoctorProfile(
      //                         data: doctorsData[index],
      //                       ))),
      //               child: Row(
      //                 children: [
      //                   Container(
      //                       margin: EdgeInsets.only(right: 13),
      //                       height: 55,
      //                       width: 55,
      //                       decoration: BoxDecoration(
      //                         color: Colors.grey,
      //                         shape: BoxShape.circle,
      //                         image: DecorationImage(
      //                           image: AssetImage('${doctorsData[index].doctorImg}'),
      //                           fit: BoxFit.cover,
      //                         ),
      //                       )),
      //                   Expanded(
      //                     child: Column(
      //                       crossAxisAlignment: CrossAxisAlignment.start,
      //                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
      //                       children: [
      //                         Text(
      //                           'Dr.${doctorsData[index].doctorName}',
      //                           style: TextStyle(
      //                             color: darkBlue,
      //                             fontSize: 15,
      //                             fontWeight: FontWeight.bold,
      //                           ),
      //                           maxLines: 1,
      //                           overflow: TextOverflow.ellipsis,
      //                         ),
      //                         SizedBox(
      //                           height: 4,
      //                         ),
      //                         Text(
      //                           '${doctorsData[index].pecialty}',
      //                           style: TextStyle(
      //                             color: Color(0xff8A9EAD),
      //                             fontSize: 14,
      //                             fontWeight: FontWeight.bold,
      //                           ),
      //                           maxLines: 1,
      //                           overflow: TextOverflow.ellipsis,
      //                         ),
      //                         // Text('${data[index].address}',style: TextStyle(color: Color(0xff8A9EAD),fontSize: 14,fontWeight: FontWeight.bold,),maxLines: 1,overflow: TextOverflow.ellipsis,),
      //                       ],
      //                     ),
      //                   ),
      //                   Column(
      //                     crossAxisAlignment: CrossAxisAlignment.center,
      //                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
      //                     children: [
      //                       Rate(
      //                         clr: Color(0xff9ADFF7),
      //                         rateValue: doctorsData[index].rate.toInt(),
      //                       ),
      //                       SizedBox(
      //                         height: 8,
      //                       ),
      //                       Text(
      //                         '(99+)Patients',
      //                         style:
      //                         TextStyle(color: Color(0xff8A9EAD), fontSize: 12),
      //                       ),
      //                     ],
      //                   ),
      //                 ],
      //               ),
      //             ),
      //           );
      //         },
      //       ),
      floatingActionButton: AnimatedOpacity(
        opacity: showUpButton ? 1 : 0.0,
        duration: Duration(milliseconds: 500),
        child: FloatingActionButton(
            child: FaIcon(
              FontAwesomeIcons.angleDoubleUp,
              size: 19,
            ),
            onPressed: () {
              _scrollController.animateTo(
                _scrollController.position.minScrollExtent,
                duration: Duration(seconds: 1),
                curve: Curves.fastOutSlowIn,
              );
            }),
      ),
      drawer: Drawer(),
    );
  }

  Widget listHead() {
    return Padding(
      padding: EdgeInsets.only(left: 15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'Top Doctors',
            style: kHeadStyle,
          ),
          MaterialButton(
            onPressed: () => Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (context) => ViewAllDoctors())),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
            child: Column(
              children: [
                Text(
                  'view all',
                  style: TextStyle(color: subTextColor, fontSize: 14),
                ),
                Container(
                  height: 1.2,
                  color: subTextColor,
                  width: 45,
                  margin: EdgeInsets.only(top: 4),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:the_disease_fighter/material/bottons/circleBtn.dart';
import 'model-screen.dart';

class DocAppointments extends StatefulWidget {
  @override
  _DocAppointmentsState createState() => _DocAppointmentsState();
}

class _DocAppointmentsState extends State<DocAppointments> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0.0,
        leading: ImgButton(
          fun: () => _scaffoldKey.currentState.openDrawer(),
          img: 'assets/icons/menu.png',
          imgWidth: 22.0,
          imgHigh: 15.0,
        ),
        actions: [
          // SearchBar(inputTextFunction: _getSearchText),
          ImgButton(
            fun: () => Navigator.push(context,
                MaterialPageRoute(builder: (context) => ModelScreen())),
            img: 'assets/icons/model.png',
            imgHigh: 35.0,
            imgWidth: 35.0,
          ),
        ],
        centerTitle: true,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Container(
          //   padding: EdgeInsets.symmetric(vertical: 15, horizontal: 15),
          //   margin: EdgeInsets.symmetric(vertical: 8, horizontal: 15),
          //   decoration: BoxDecoration(
          //     color: backGroundColor,
          //     borderRadius: BorderRadius.all(Radius.circular(10)),
          //     border: Border.all(color: Color(0xffBCE0FD)),
          //   ),
          //   child: InkWell(
          //     onTap: () => Navigator.push(
          //         context,
          //         MaterialPageRoute(
          //             builder: (context) => DoctorProfile(
          //               data: item,
          //             ))),
          //     child: Row(
          //       children: [
          //         Container(
          //             margin: EdgeInsets.only(right: 13),
          //             height: 55,
          //             width: 55,
          //             decoration: BoxDecoration(
          //               color: greyColor.withOpacity(.5),
          //               shape: BoxShape.circle,
          //               image: DecorationImage(
          //                 image: AssetImage('${item.doctorImg}'),
          //                 fit: BoxFit.cover,
          //               ),
          //             )),
          //         Expanded(
          //           child: Column(
          //             crossAxisAlignment: CrossAxisAlignment.start,
          //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //             children: [
          //               Text(
          //                 'Dr.${item.doctorName}',
          //                 style: TextStyle(
          //                   color: darkBlueColor,
          //                   fontSize: 15,
          //                   fontWeight: FontWeight.bold,
          //                 ),
          //                 maxLines: 1,
          //                 overflow: TextOverflow.ellipsis,
          //               ),
          //               SizedBox(
          //                 height: 5,
          //               ),
          //               Text(
          //                 '${item.pecialty}',
          //                 style: TextStyle(
          //                   color: subTextColor,
          //                   fontSize: 14,
          //                 ),
          //                 maxLines: 1,
          //                 overflow: TextOverflow.ellipsis,
          //               ),
          //             ],
          //           ),
          //         ),
          //         Column(
          //           crossAxisAlignment: CrossAxisAlignment.center,
          //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //           children: [
          //             Rate(
          //               clr: primaryColor,
          //               rateValue: item.rate.toInt(),
          //             ),
          //             SizedBox(
          //               height: 8,
          //             ),
          //             Text(
          //               '(99+)Patients',
          //               style: TextStyle(color: subTextColor, fontSize: 12),
          //             ),
          //           ],
          //         ),
          //       ],
          //     ),
          //   ),
          // ),
        ],
      ),
      drawer: Drawer(),
    );
  }
}

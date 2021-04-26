import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:the_disease_fighter/data/doctor_data.dart';
import 'package:the_disease_fighter/layout/drawer/drawer_screens/patient/my_appointments/my_appointments.dart';
import 'package:the_disease_fighter/layout/drawer/patient_MainDrawer.dart';
import 'package:the_disease_fighter/layout/notification/notification.dart';
import 'package:the_disease_fighter/layout/patient_screens/clinics/all_clinics.dart';
import 'package:the_disease_fighter/layout/patient_screens/view_doctors/view_all_doctors.dart';
import 'package:the_disease_fighter/localizations/localization/language/languages.dart';
import 'package:the_disease_fighter/material/bottons/circleBtn.dart';
import 'package:the_disease_fighter/material/constants.dart';
import 'home_widgets/categories.dart';
import 'home_widgets/doctor_card.dart';

class Home extends StatefulWidget {
  final showSnackBar;

  const Home({this.showSnackBar = false});

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  ScrollController _scrollController = new ScrollController();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

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
    widget.showSnackBar
        ? Future.delayed(Duration.zero, () async {
            snackBarr();
            // ignore: unnecessary_statements
          })
        // ignore: unnecessary_statements
        : null;

    super.initState();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  snackBarr() {
    final snackBar = SnackBar(
      content: Text(
        Languages.of(context)!.patientHome['snackBarLabel'],
        style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
      ),
      backgroundColor: primaryColor,
      action: SnackBarAction(
        label: Languages.of(context)!.patientHome['snackBarBTN'],
        textColor: Colors.white,
        onPressed: () => Navigator.push(
            context, MaterialPageRoute(builder: (context) => MyAppointments())),
      ),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      key: _scaffoldKey,
      appBar: AppBar(
        elevation: 0.0,
        leading: ImgButton(
          fun: () => WidgetsBinding.instance!.addPostFrameCallback((_) {
            _scaffoldKey.currentState!.openDrawer();
          }),
          // fun: (){ _scaffoldKey.currentState!.openDrawer();},
          img: 'assets/icons/menu.png',
          imgWidth: 22.0,
          imgHigh: 15.0,
        ),
        actions: [
          // SearchBar(inputTextFunction: _getSearchText),
          ImgButton(
            fun: () => WidgetsBinding.instance!.addPostFrameCallback((_) {
              Navigator.push(
                  context, MaterialPageRoute(builder: (_) => Notifications()));
            }),
            img: 'assets/icons/notification.png',
            imgHigh: 35.0,
            imgWidth: 35.0,
          ),
        ],
        centerTitle: true,
      ),
      body: ListView(
        controller: _scrollController,
        children: [
          SizedBox(
            height: 15,
          ),
          listHead(
              tittle: Languages.of(context)!.patientHome['clinics'],
              fun: () => Navigator.push(context,
                  MaterialPageRoute(builder: (context) => AllClinics()))),
          Categories(),
          Container(
            height: 5,
            margin: EdgeInsets.symmetric(vertical: 30, horizontal: 15),
            decoration: BoxDecoration(
                color: backGroundColor, borderRadius: BorderRadius.circular(2)),
          ),
          listHead(
              tittle: Languages.of(context)!.patientHome['topDoctors'],
              fun: () => Navigator.push(context,
                  MaterialPageRoute(builder: (context) => ViewAllDoctors()))),
          for (var item in doctorsData)
            DoctorCard(
              item: item,
            )
        ],
      ),
      floatingActionButton: AnimatedOpacity(
        opacity: showUpButton ? 1 : 0.0,
        duration: Duration(milliseconds: 500),
        child: MaterialButton(
            elevation: 0.5,
            hoverElevation: 5.0,
            materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
            minWidth: 50,
            height: 50,
            color: primaryColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(40.0),
            ),
            child: FaIcon(
              FontAwesomeIcons.angleDoubleUp,
              color: Colors.white,
              size: 17,
            ),
            onPressed: () {
              _scrollController.animateTo(
                _scrollController.position.minScrollExtent,
                duration: Duration(seconds: 1),
                curve: Curves.fastOutSlowIn,
              );
            }),
      ),
      drawer: PatientMainDrawer(),
    );
  }

  Widget listHead({tittle, fun}) {
    return Padding(
      padding: EdgeInsets.only(left: 15, top: 0, bottom: 5, right: 15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            tittle,
            style: kHeadStyle.copyWith(fontWeight: FontWeight.w600),
          ),
          MaterialButton(
            onPressed: fun,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
            child: Column(
              children: [
                Text(
                  Languages.of(context)!.patientHome['viewAllBTN'],
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

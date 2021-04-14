import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:the_disease_fighter/data/doctor_data.dart';
import 'package:the_disease_fighter/layout/patient_screens/clinics/doctor-card.dart';
import 'package:the_disease_fighter/layout/notification/notification.dart';
import 'package:the_disease_fighter/layout/patient_screens/search/search.dart';
import 'package:the_disease_fighter/material/bottons/circleBtn.dart';
import 'package:the_disease_fighter/material/constants.dart';

class Clinic extends StatefulWidget {
  Clinic({this.clinicTittle});

  final clinicTittle;

  @override
  _ClinicState createState() => _ClinicState();
}

class _ClinicState extends State<Clinic> {
  ScrollController _scrollController = new ScrollController();
  bool showUpButton = false;

  @override
  void initState() {
    _scrollController.addListener(() {
      if (_scrollController.position.pixels > 400) {
        setState(() {
          showUpButton = true;
        });
      } else {
        setState(() {
          showUpButton = false;
        });
      }
    });
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
      backgroundColor: Colors.white,
      body: CustomScrollView(
        controller: _scrollController,
        slivers: <Widget>[
          SliverAppBar(
            floating: true,
            pinned: true,
            snap: true,
            leading: CircleButton(
              fun: () => Navigator.pop(context),
              icn: Icons.arrow_back,
              color: primaryColor,
            ),
            actions: [
              ImgButton(
                fun: () => Navigator.push(context,
                    MaterialPageRoute(builder: (context) => Notifications())),
                img: 'assets/icons/notification.png',
                imgHigh: 35.0,
                imgWidth: 35.0,
              ),
            ],
            bottom: PreferredSize(
              preferredSize: Size(50.0, 50.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: EdgeInsets.only(
                      left: 15,
                    ),
                    child: Text(
                      '${widget.clinicTittle} Doctors',
                      style: kHeadStyle,
                    ),
                  ),
                  ImgButton(
                    fun: () => Navigator.push(context,
                        MaterialPageRoute(builder: (context) => Search())),
                    img: 'assets/icons/search1.png',
                    imgWidth: 35.0,
                    imgHigh: 20.0,
                  ),
                  // ImgButton(
                  //   fun: () {},
                  //   img: 'assets/icons/filter.png',
                  //   imgWidth: 25.0,
                  //   imgHigh: 25.0,
                  // ),
                ],
              ),
            ),
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) => DoctorCard(
                item: doctorsData[index],
              ),
              childCount: doctorsData.length,
            ),
          ),
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
    );
  }
}

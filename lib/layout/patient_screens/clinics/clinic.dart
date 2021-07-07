import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:the_disease_fighter/layout/patient_screens/patient_home/home_widgets/doctor_card.dart';
import 'package:the_disease_fighter/layout/patient_screens/search/search.dart';
import 'package:the_disease_fighter/material/bottons/circleBtn.dart';
import 'package:the_disease_fighter/material/constants.dart';
import 'package:the_disease_fighter/material/widgets/empty_list_widget.dart';
import 'package:the_disease_fighter/material/widgets/no_internet_widget.dart';
import 'package:the_disease_fighter/services/specialization/one_specialization_controller.dart';

class Clinic extends StatefulWidget {
  Clinic({this.clinicTittle, this.clinicId});
  final clinicTittle;
  final clinicId;
  @override
  _ClinicState createState() => _ClinicState();
}
class _ClinicState extends State<Clinic> {
  OneSpecializationController _oneSpecializationController=OneSpecializationController();
  ScrollController _scrollController = new ScrollController();
  bool showUpButton = false;


  Future _loadOneSpecialization() async {
    var data = await _oneSpecializationController.getOneSpecialization(clinicId: widget.clinicId);
    return Future.value(data);
  }

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
            title: Text(
              '${widget.clinicTittle}',
              style: kHeadStyle,
            ),
            actions: [
              ImgButton(
                fun: () => Navigator.push(context,
                    MaterialPageRoute(builder: (context) => Search())),
                img: 'assets/icons/search1.png',
                imgWidth: 20.0,
                imgHigh: 20.0,
              ),
            ],
            leading: CircleButton(
              fun: () => Navigator.pop(context),
              icn: Icons.arrow_back,
              color: darkBlueColor,
            ),
            // bottom: PreferredSize(
            //   preferredSize: Size(50.0, 50.0),
            //   child: Padding(
            //     padding: EdgeInsets.symmetric(horizontal: 15),
            //     child: Row(
            //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //       children: [
            //         Text(
            //           '${widget.clinicTittle}',
            //           style: kHeadStyle,
            //         ),
            //         ImgButton(
            //           fun: () => Navigator.push(context,
            //               MaterialPageRoute(builder: (context) => Search())),
            //           img: 'assets/icons/search1.png',
            //           imgWidth: 20.0,
            //           imgHigh: 20.0,
            //         ),
            //       ],
            //     ),
            //   ),
            // ),
          ),
          FutureBuilder<dynamic>(
              future:_loadOneSpecialization(),
              builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                if (!snapshot.hasData && !snapshot.hasError) {
                  return SliverToBoxAdapter(
                      child: Container(height: MediaQuery.of(context).size.height - 100,child: Center(child: CircularProgressIndicator(valueColor: AlwaysStoppedAnimation(darkBlueColor),))));
                } else {
                  if (snapshot.hasError) {
                    return SliverToBoxAdapter(
                      child: Padding(
                        padding: EdgeInsets.only(
                            top: MediaQuery.of(context).size.height * .3),
                        child: FailLoadWidget(
                          fun: () {
                            setState(() {
                              _loadOneSpecialization();
                            });
                          },
                        )
                      ),
                    );
                  } else {
                    return  snapshot.data.success==true
                        ?  SliverList(
                      delegate: SliverChildBuilderDelegate(
                            (context, index) => DoctorCard(
                          item: snapshot.data.doctors[index],
                        ),
                        childCount: snapshot.data.doctors.length,
                      ),
                    ) :  SliverToBoxAdapter(child:  Padding(
                      padding: EdgeInsets.only(top: MediaQuery.of(context).size.height * .4),
                      child: EmptyListWidget(icon: Icons.perm_contact_cal_sharp,label: 'No Doctors Found',iconSize: 100.0,),
                    )
                    );
                  }
                }
              }),
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

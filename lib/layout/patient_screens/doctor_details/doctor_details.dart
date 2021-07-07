import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:the_disease_fighter/layout/patient_screens/doctor_details/doc_reviews.dart';
import 'package:the_disease_fighter/layout/patient_screens/favorite/favorite_doctors.dart';
import 'package:the_disease_fighter/layout/patient_screens/the_appointment/book_appointment.dart';
import 'package:the_disease_fighter/localizations/localization/language/languages.dart';
import 'package:the_disease_fighter/material/bottons/circleBtn.dart';
import 'package:the_disease_fighter/material/bottons/roundedBtn.dart';
import 'package:the_disease_fighter/material/constants.dart';
import 'package:the_disease_fighter/material/widgets/materialBanner.dart';
import 'package:the_disease_fighter/material/widgets/no_internet_widget.dart';
import 'package:the_disease_fighter/material/widgets/rate_bar.dart';
import 'package:the_disease_fighter/services/doctors/controllers/get_one_doctor_controller.dart';
import 'package:the_disease_fighter/services/favorite_doctors/controllers/add_toFavorite.dart';
import 'package:the_disease_fighter/services/favorite_doctors/controllers/delete_fromFavorite.dart';
import 'package:url_launcher/url_launcher.dart';

// ignore: must_be_immutable
class DoctorDetails extends StatefulWidget {
  final data;

  DoctorDetails({@required this.data});

  @override
  _DoctorDetailsState createState() => _DoctorDetailsState();
}

class _DoctorDetailsState extends State<DoctorDetails> {
  bool _isFavorite = false;
  bool _addRemoveFavLoader = false;
  String? _errorMessage;
  bool _showBanner = false;
  AddToFavoriteController _addToFavoriteController = AddToFavoriteController();
  DeleteFromFavoriteController _deleteFromFavoriteController =
      DeleteFromFavoriteController();

  Future _addRemoveFavoriteFun() async {
    setState(() {
      _addRemoveFavLoader = true;
      _showBanner = false;
    });
    if (_isFavorite) {
      final _addResponse = await _deleteFromFavoriteController
          .deleteFromFavorite(docId: widget.data.id);
      if (_addResponse['success'] == true) {
        setState(() {
          _isFavorite = false;
        });
        snackBarr(
            text: Languages.of(context)!.doctorDetails['snackBarRemove'],
            fun: () {});
      } else {
        setState(() {
          _errorMessage = _addResponse['message'];
          _showBanner = true;
        });
      }
    } else {
      final _addResponse = await _addToFavoriteController.addToFavorite(
          isFavorite: !_isFavorite, docId: widget.data.id);
      if (_addResponse['success'] == true) {
        setState(() {
          _isFavorite = true;
        });
        snackBarr(
          label: Languages.of(context)!.doctorDetails['snackBarAddBTN'],
          text: Languages.of(context)!.doctorDetails['snackBarAddLabel'],
          fun: () => Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (context) => FavoriteDoctors())),
        );
      } else {
        setState(() {
          _errorMessage = _addResponse['message'];
          _showBanner = true;
        });
      }
    }
    setState(() {
      _addRemoveFavLoader = false;
    });
  }

  snackBarr({text, fun, label = ''}) {
    final snackBar = SnackBar(
      duration: Duration(seconds: 1),
      content: Text(
        text,
        style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
      ),
      backgroundColor: primaryColor,
      action:
          SnackBarAction(label: label, textColor: Colors.white, onPressed: fun),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  GetOneDoctorController _getOneDoctorController = GetOneDoctorController();
  Future _loadOneDoctor() async {
    var data =
        await _getOneDoctorController.oneDoctorData(docId: widget.data.id);
    bool temp = data!.doctor!.isInFavoriteList!;
    _isFavorite = temp;

    return data;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          AppBar(
            leading: IconButton(
              onPressed: () => Navigator.of(context).pop(),
              icon: Icon(
                Icons.arrow_back,
                color: darkBlueColor,
              ),
            ),
          ),
          FutureBuilder<dynamic>(
              future: _loadOneDoctor(),
              builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                if (!snapshot.hasData && !snapshot.hasError) {
                  return Center(child: CircularProgressIndicator());
                } else {
                  if (snapshot.hasError) {
                    return FailLoadWidget(
                      fun: () {
                        setState(() {
                          _loadOneDoctor();
                        });
                      },
                    );
                  } else {
                    return Scaffold(
                      backgroundColor: Colors.white,
                      extendBodyBehindAppBar: true,
                      body: CustomScrollView(
                        slivers: <Widget>[
                          SliverAppBar(
                            elevation: 0.0,
                            leading: CircleButton(
                              color: darkBlueColor,
                              icn: Icons.arrow_back,
                              fun: () => Navigator.pop(context),
                            ),
                            actions: [
                              !_addRemoveFavLoader
                                  ? IconButton(
                                      icon: Icon(
                                        _isFavorite
                                            ? Icons.favorite
                                            : Icons.favorite_border,
                                        color: _isFavorite
                                            ? Colors.red
                                            : darkBlueColor.withOpacity(.7),
                                      ),
                                      onPressed: _addRemoveFavoriteFun,
                                    )
                                  : Padding(
                                      padding: const EdgeInsets.all(15.0),
                                      child: SizedBox(
                                          height: 25,
                                          width: 25,
                                          child: CircularProgressIndicator
                                              .adaptive(
                                                  valueColor:
                                                      AlwaysStoppedAnimation<
                                                              Color>(
                                                          darkBlueColor))),
                                    ),
                            ],
                            pinned: true,
                            floating: true,
                            expandedHeight: 400.0,
                            flexibleSpace: FlexibleSpaceBar(
                              title: Text(
                                  '${snapshot.data.doctor.name.toString()}',
                                  style: kHeadStyle),
                              background: docImage(),
                            ),
                          ),
                          SliverList(
                            delegate: SliverChildListDelegate.fixed(
                              [
                                Container(
                                  padding: EdgeInsets.symmetric(
                                      vertical: 30, horizontal: 20),
                                  margin: EdgeInsets.fromLTRB(15, 20, 15, 10),
                                  decoration: BoxDecoration(
                                    color: backGroundColor,
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10)),
                                    // border: Border.all(color: lightGreyColor),
                                  ),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding:
                                            EdgeInsets.fromLTRB(0, 0, 10, 0),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              Languages.of(context)!
                                                  .doctorDetails['about'],
                                              style: kHeadStyle.copyWith(
                                                  fontSize: 17,
                                                  fontWeight: FontWeight.w700),
                                            ),
                                            Rate(
                                              rateValue: widget
                                                  .data.reviews.rates
                                                  .toInt(),
                                              clr: primaryColor,
                                            ),
                                          ],
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.symmetric(
                                            vertical: 10, horizontal: 15),
                                        child: Text(
                                          snapshot.data.doctor.about ??
                                              'No about',
                                          style: kSubStyle,
                                          maxLines: 3,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(
                                            top: 7, bottom: 15),
                                        child: Row(
                                          children: [
                                            Icon(
                                              Icons.location_on,
                                              color: darkBlueColor,
                                            ),
                                            SizedBox(
                                              width: 13,
                                            ),
                                            Text(
                                                snapshot.data.doctor
                                                        .clinicLocation ??
                                                    'Un Known',
                                                style: kSubStyle),
                                          ],
                                        ),
                                      ),
                                      Row(
                                        children: [
                                          Icon(
                                            FontAwesomeIcons.userMd,
                                            color: darkBlueColor,
                                            size: 20,
                                          ),
                                          SizedBox(
                                            width: 15,
                                          ),
                                          Text(
                                              '${snapshot.data.doctor.specialization.name ?? 'Un Known'} Doctor',
                                              style: kSubStyle.copyWith(
                                                  fontSize: 15)),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  padding: EdgeInsets.symmetric(
                                      vertical: 30, horizontal: 15),
                                  margin: EdgeInsets.fromLTRB(10, 0, 10, 10),
                                  decoration: BoxDecoration(
                                    color: backGroundColor,
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10)),
                                  ),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding:
                                            EdgeInsets.fromLTRB(0, 0, 0, 10),
                                        child: Text(
                                          Languages.of(context)!.doctorDetails[
                                              'clinicAppointments'],
                                          style: kHeadStyle.copyWith(
                                              fontSize: 17,
                                              fontWeight: FontWeight.w700),
                                        ),
                                      ),
                                      for (var item in snapshot
                                          .data.doctor.availableDates)
                                        appointmentCard(context,
                                            clinicDatesData: item),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: 10,
                                  ),
                                  child: ListTile(
                                    onTap: () => Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => DoctorReviews(
                                                  docId: widget.data.id,
                                                ))),
                                    tileColor: backGroundColor,
                                    title: Text(
                                      Languages.of(context)!
                                          .doctorDetails['patientReviews'],
                                      style: TextStyle(
                                        color: darkBlueColor,
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    trailing: Icon(
                                      Icons.arrow_forward_ios_sharp,
                                      color: subTextColor,
                                      size: 20,
                                    ),
                                    contentPadding: EdgeInsets.symmetric(
                                        horizontal: 20, vertical: 10),
                                  ),
                                ),
                                SizedBox(
                                  height: double.infinity <
                                          MediaQuery.of(context).size.height
                                      ? MediaQuery.of(context).size.height -
                                          double.infinity +
                                          10
                                      : 0,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      bottomNavigationBar: BottomAppBar(
                        color: Colors.transparent,
                        child: Padding(
                          padding: EdgeInsets.only(
                              top: 5, bottom: 10, right: 5, left: 5),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              MaterialButton(
                                elevation: 0.5,
                                hoverElevation: 5.0,
                                materialTapTargetSize:
                                    MaterialTapTargetSize.shrinkWrap,
                                minWidth: 60,
                                height: 60,
                                color: backGroundColor,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(40.0),
                                ),
                                onPressed: () => launch(widget.data.phone !=
                                        null
                                    ? "tel://${widget.data.phone.toString()}"
                                    : "01552154105"),
                                child: Icon(
                                  Icons.phone,
                                  color: primaryColor,
                                ),
                              ),
                              RoundedButton(
                                fun: () => Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => BookAppointment(
                                              docId: widget.data.id,
                                              docName:
                                                  widget.data.name.toString(),
                                              docImage:
                                                  widget.data.avatar.toString(),
                                            ))),
                                minWdthRatio: .63,
                                text: Languages.of(context)!
                                    .doctorDetails['bookBtn'],
                                borderRadious: 50,
                              ),
                            ],
                          ),
                        ),
                        elevation: 0.0,
                      ),
                    );
                  }
                }
              }),
          _showBanner
              ? SizedBox(
                  height: 130,
                  child: ErrorMaterialBanner(
                    errorMessage: _errorMessage,
                    fun: () {
                      setState(() {
                        _showBanner = false;
                      });
                    },
                  ),
                )
              : SizedBox()
        ],
      ),
    );
  }

  Container appointmentCard(BuildContext context, {clinicDatesData}) {
    return Container(
      width: MediaQuery.of(context).size.width,
      padding: EdgeInsets.symmetric(vertical: 17, horizontal: 15),
      margin: EdgeInsets.symmetric(vertical: 5),
      child: Row(
        children: [
          Icon(Icons.access_time, color: darkBlueColor),
          SizedBox(
            width: 10,
          ),
          Text(
            '${clinicDatesData.day}, ${clinicDatesData.startTime} - ${clinicDatesData.endTime}',
            maxLines: 2,
            style: TextStyle(color: darkBlueColor),
          ),
        ],
      ),
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(15)),
    );
  }

  Widget docImage() => Container(
      width: MediaQuery.of(context).size.width,
      margin: EdgeInsets.only(bottom: 55),
      decoration: BoxDecoration(
        color: backGroundColor,
        image: DecorationImage(
          image: NetworkImage(widget.data.avatar),
        ),
        borderRadius: BorderRadius.only(
            bottomRight: Radius.circular(35), bottomLeft: Radius.circular(35)),
      ));
}

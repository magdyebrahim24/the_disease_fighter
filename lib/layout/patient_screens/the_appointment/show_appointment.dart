import 'package:flutter/material.dart';
import 'package:the_disease_fighter/layout/patient_screens/my_appointments/my_appointments.dart';
import 'package:the_disease_fighter/localizations/localization/language/languages.dart';
import 'package:the_disease_fighter/material/bottons/roundedBtn.dart';
import 'package:the_disease_fighter/material/constants.dart';
import 'package:the_disease_fighter/material/widgets/materialBanner.dart';
import 'package:the_disease_fighter/services/sessions/controllers/deleteSession.dart';
import 'edit_apppointment.dart';

// ignore: must_be_immutable
class ShowAppointment extends StatefulWidget {
  final data;

  ShowAppointment({this.data});

  @override
  _ShowAppointmentState createState() => _ShowAppointmentState();
}

class _ShowAppointmentState extends State<ShowAppointment> {
  bool _isLoading = false;
  bool _showBanner = false;
  String? _errorMessage;

  DeleteSessionController _deleteSessionController = DeleteSessionController();

  Future _deleteSession() async {
    setState(() {
      _isLoading = true;
    });
    final data =
        await _deleteSessionController.deleteSession(index: widget.data.id);
    if (await data['success']) {
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (context) => MyAppointments(
                    showSnackBar: true,
                    snackBarMessage: "Appointment deleted successfully",
                  )));
    } else {
      setState(() {
        _errorMessage = data['message'].toString();
        _isLoading = false;
        _showBanner = true;
      });
    }
    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // extendBodyBehindAppBar: true,

      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.transparent,
        leading: MaterialButton(
          onPressed: () => Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (context) => MyAppointments())),
          child: Icon(
            Icons.arrow_back,
            color: darkBlueColor,
          ),
          // color: primaryColor.withOpacity(.2),
          elevation: 0.0,
          materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(45.0),
          ),
        ),
      ),
      body: !_isLoading
          ? SingleChildScrollView(
              child: Stack(
                children: [
                  Column(
                    children: [
                      // Container(
                      //     alignment: Alignment.center,
                      //     margin: EdgeInsets.only(bottom: 25),
                      //     padding: EdgeInsets.only(top: 25),
                      //     width: MediaQuery.of(context).size.width,
                      //     height: 240,
                      //     decoration: BoxDecoration(
                      //         color: primaryColor.withOpacity(.8),
                      //         borderRadius: BorderRadius.only(
                      //           bottomRight: Radius.circular(40),
                      //           bottomLeft: Radius.circular(40),
                      //         )),
                      //     child: Column(
                      //       children: [
                      //         Container(
                      //           decoration: BoxDecoration(
                      //               boxShadow: [
                      //                 BoxShadow(
                      //                     color: subTextColor,
                      //                     offset: Offset(1.0, 2.0),
                      //                     blurRadius: 6.0,
                      //                     spreadRadius: 1),
                      //               ],
                      //               image: DecorationImage(
                      //                   image: NetworkImage(widget
                      //                       .data.doctorAvatar
                      //                       .toString()),
                      //                   fit: BoxFit.cover),
                      //               shape: BoxShape.circle,
                      //               border: Border.all(
                      //                   color: Color(0xffFDFDFD), width: 2),
                      //               color: backGroundColor),
                      //           margin: EdgeInsets.all(10),
                      //           height: 120,
                      //           width: 120,
                      //         ),
                      //         Text(
                      //           widget.data.doctorName,
                      //           maxLines: 1,
                      //           overflow: TextOverflow.ellipsis,
                      //           style: TextStyle(
                      //             fontWeight: FontWeight.bold,
                      //             color: darkBlueColor,
                      //             fontSize: 20,
                      //           ),
                      //         ),
                      //         SizedBox(
                      //           height: 7,
                      //         ),
                      //         Text(
                      //           '${widget.data.docSpecialization.toString()} Specialist',
                      //           maxLines: 1,
                      //           overflow: TextOverflow.ellipsis,
                      //           style: TextStyle(
                      //             fontWeight: FontWeight.bold,
                      //             color: Colors.white,
                      //             fontSize: 16,
                      //           ),
                      //         ),
                      //       ],
                      //     )),

                      Padding(
                        padding: EdgeInsets.only(top: 15,bottom: 30),
                        child: _appointCard(),
                      ),


                      // _item(context,
                      //     labelText: Languages.of(context)!
                      //         .bookAppointment['appointmentDateLabel'],
                      //     data:
                      //         '${widget.data.day.toString()} - ${widget.data.date.toString()}'),
                      // _item(context,
                      //     labelText: Languages.of(context)!
                      //         .bookAppointment['appointmentTimeLabel'],
                      //     data:
                      //         '${widget.data.time.toString()} ${widget.data.amPm.toString()}'),
                      _item(context,
                          labelText: Languages.of(context)!
                              .bookAppointment['nameLabel'],
                          data: widget.data.name.toString()),
                      _item(context,
                          labelText: Languages.of(context)!
                              .bookAppointment['genderLabel'],
                          data: widget.data.gender.toString()),
                      _item(context,
                          labelText: Languages.of(context)!
                              .bookAppointment['phoneLabel'],
                          data: widget.data.phone.toString()),
                      _item(context,
                          labelText: Languages.of(context)!
                              .bookAppointment['appointmentNote'],
                          data: widget.data.comment.toString()),
                      SizedBox(
                        height: 15,
                      )
                    ],
                  ),
                  _showBanner
                      ? ErrorMaterialBanner(
                          errorMessage: _errorMessage,
                          fun: () => setState(() {
                                _showBanner = false;
                              }))
                      : SizedBox()
                ],
              ),
            )
          : Center(child: CircularProgressIndicator()),
      bottomNavigationBar: BottomAppBar(
        color: Colors.transparent,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 7),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              MaterialButton(
                minWidth: MediaQuery.of(context).size.width * .3,
                height: 50,
                color: Colors.redAccent,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(50),
                ),
                onPressed: _showDialog,
                child: Text(
                  Languages.of(context)!.bookAppointment['deleteBTN'],
                  style: TextStyle(fontSize: 16, color: Colors.white),
                ),
              ),
              SizedBox(
                width: 10,
              ),
              RoundedButton(
                minWdthRatio: .5,
                fun: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => EditAppointment(
                              data: widget.data,
                            ))),
                text: Languages.of(context)!.bookAppointment['editBTN'],
                borderRadious: 50,
              )
            ],
          ),
        ),
        elevation: 0.0,
      ),
    );
  }

  Widget _item(BuildContext context, {labelText, data}) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8, horizontal: 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            labelText,
            style: TextStyle(fontSize: 15, color: subTextColor),
          ),
          Container(
              margin: EdgeInsets.symmetric(
                vertical: 7,
              ),
              width: MediaQuery.of(context).size.width,
              padding: EdgeInsets.symmetric(horizontal: 14, vertical: 15),
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                      color: subTextColor.withOpacity(.5),
                      offset: Offset(1.0, 2.0),
                      blurRadius: 4.0,
                      spreadRadius: .4),
                ],
                color: backGroundColor,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Text(
                data,
                style: TextStyle(color: darkBlueColor, fontSize: 16),
              )),
        ],
      ),
    );
  }

  Future<void> _showDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            'Are You Sure You Want To Delete Appointment',
            style: TextStyle(color: darkBlueColor, fontSize: 17),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text(
                'Delete',
                style: TextStyle(color: Colors.red),
              ),
              onPressed: () {
                Navigator.of(context).pop();
                _deleteSession();
              },
            ),
          ],
        );
      },
    );
  }
  Widget _appointCard() {
    return Container(
      padding: EdgeInsets.all(15),
      margin: EdgeInsets.all(10),
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
              color: subTextColor.withOpacity(.5),
              offset: Offset(1.0, 2.0),
              blurRadius: 4.0,
              spreadRadius: .4),
        ],
          color: backGroundColor, borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Container(
                width: 60,
                height: 60,
                decoration: BoxDecoration(
                    color: Colors.grey.withOpacity(.5),
                    borderRadius: BorderRadius.circular(10),
                    image: DecorationImage(
                        image:
                        NetworkImage(widget.data.doctorAvatar.toString()),
                        fit: BoxFit.cover)),
              ),
              SizedBox(
                width: 15,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.data.doctorName.toString(),
                    style: TextStyle(
                        fontSize: 17,
                        color: darkBlueColor,
                        fontWeight: FontWeight.w500),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                    '${widget.data.docSpecialization.toString()} Specialist',
                    style: TextStyle(
                      color: subTextColor,
                    ),
                  )
                ],
              )
            ],
          ),
          SizedBox(
            height: 15,
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 30),
            padding: EdgeInsets.all(13),
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Color(0xffBCBBBB),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.access_time,
                  color: Colors.white,
                  // size: 15,
                ),
                SizedBox(
                  width: 5,
                ),
                Expanded(
                  child: Text(
                    '${widget.data.day.toString()}, ${widget.data.date.toString()} , ${widget.data.time.toString()} ${widget.data.amPm.toString()}',
                    style: TextStyle(color: Colors.white),
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }

}

import 'package:flutter/material.dart';
import 'package:the_disease_fighter/layout/doctor-screens/doctor_home/doctor_home.dart';
import 'package:the_disease_fighter/material/bottons/circleBtn.dart';
import 'package:the_disease_fighter/material/bottons/roundedBtn.dart';
import 'package:the_disease_fighter/material/constants.dart';
import 'package:the_disease_fighter/material/widgets/time-date-field.dart';
import 'package:the_disease_fighter/services/doctorScreens/controllers/createDoctorDatesController.dart';
import 'package:the_disease_fighter/services/doctorScreens/controllers/deleteDoctorDate.dart';
import 'package:the_disease_fighter/services/logged_user/controllers/getDoctorData.dart';

class UpdateDoctorDates extends StatefulWidget {
  final showSkip;

  UpdateDoctorDates({required this.showSkip});

  @override
  _UpdateDoctorDatesState createState() => _UpdateDoctorDatesState();
}

class _UpdateDoctorDatesState extends State<UpdateDoctorDates> {
  String? day;
  String? fromTime;
  String? toTime;
  bool _addDocDateLoading = false;
  int? _deleteDocDateLoading;
  String _clinicError = '';
  DeleteDoctorDateController _doctorDateController =
      DeleteDoctorDateController();
  CreateDoctorDateController _createDoctorDateController =
      CreateDoctorDateController();
  CurrentDoctorController _currentDoctorController = CurrentDoctorController();

  Future _showTimePicker() async {
    var time = await showTimePicker(
        context: context,
        initialEntryMode: TimePickerEntryMode.input,
        helpText: 'Enter Time Clinic Open In',
        initialTime: TimeOfDay.fromDateTime(DateTime.now()),
        builder: (BuildContext context, Widget? child) {
          return MediaQuery(
            data: MediaQuery.of(context).copyWith(
              alwaysUse24HourFormat: false,
            ),
            child: child!,
          );
        });
    return time!.format(context).toString();
  }

  Future _deleteDate({dateId}) async {
    final response =
        await _doctorDateController.deleteDate(dateId: dateId.toString());
    setState(() {
      _loadDoctorDates();
      _deleteDocDateLoading = null;
    });
  }

  Future _loadDoctorDates() async {
    var data = await _currentDoctorController.loadDoctorData();
    return Future.value(data);
  }

  Future _addDoctorDate() async {
    if (fromTime == null || toTime == null || day == null) {
      setState(() {
        _clinicError = 'day OR from time OR to time can\'t be empty';
      });
    } else {
      setState(() {
        _addDocDateLoading = true;
        _clinicError = '';
      });
      final response = await _createDoctorDateController.createDate(
          day: day, startTime: fromTime, endTime: toTime);
      if (await response['success']) {
      } else {
        setState(() {
          _clinicError = response['message'].toString();
        });
      }
      setState(() {
        _addDocDateLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0.0,
        title: Text(
          'Update Dates',
          style: TextStyle(color: darkBlueColor),
        ),
        centerTitle: true,
        leading: !widget.showSkip
            ? IconButton(
                icon: Icon(Icons.arrow_back),
                onPressed: () => Navigator.pop(context),
              )
            : SizedBox(),
        actions: [
          widget.showSkip
              ? TextButton(
                  onPressed: () => Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (context) => DoctorHome())),
                  child: Text(
                    'Save',
                    style: TextStyle(color: subTextColor, fontSize: 16),
                  ),
                  style: ButtonStyle(),
                )
              : SizedBox()
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 20, horizontal: 15),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: MediaQuery.of(context).size.width,
                margin: EdgeInsets.symmetric(
                  vertical: 15,
                ),
                padding: EdgeInsets.symmetric(horizontal: 14, vertical: 15),
                decoration: BoxDecoration(
                  color: backGroundColor,
                  border: Border.all(
                      width: 1, color: Color(0xff707070).withOpacity(.15)),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Add Clinic Date :',
                      style: TextStyle(
                          color: darkBlueColor,
                          fontSize: 19,
                          fontWeight: FontWeight.bold),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 5, bottom: 15),
                      child: Divider(
                        thickness: 4,
                      ),
                    ),
                    !_addDocDateLoading
                        ? Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                                Text(
                                  'Day Clinic Open In :',
                                  style: TextStyle(
                                      fontSize: 15, color: darkBlueColor),
                                ),
                                Container(
                                    margin: EdgeInsets.symmetric(
                                      vertical: 8,
                                    ),
                                    padding: EdgeInsets.all(15),
                                    decoration: BoxDecoration(
                                        border: Border.all(
                                            width: 1,
                                            color: Color(0xff707070)
                                                .withOpacity(.15)),
                                        borderRadius: BorderRadius.circular(10),
                                        color: Colors.white),
                                    height: 52,
                                    width: MediaQuery.of(context).size.width,
                                    child: DropdownButtonHideUnderline(
                                      child: DropdownButton<String>(
                                        onChanged: (value) {
                                          setState(() {
                                            day = value;
                                          });
                                        },
                                        value: day,
                                        elevation: 1,
                                        hint: Text(
                                          'Select Day Clinic Open In',
                                          style: TextStyle(color: subTextColor),
                                        ),
                                        icon: Icon(Icons.arrow_drop_down,
                                            color:
                                                darkBlueColor.withOpacity(.7)),
                                        isDense: false,
                                        items: [
                                          'Saturday',
                                          'Sunday',
                                          'Monday',
                                          'Tuesday',
                                          'Wednesday',
                                          'Thursday',
                                          'Friday',
                                        ].map<DropdownMenuItem<String>>(
                                            (String value) {
                                          return DropdownMenuItem<String>(
                                            value: value,
                                            child: Text(
                                              value,
                                              style: TextStyle(
                                                  fontSize: 15,
                                                  color: darkBlueColor),
                                            ),
                                          );
                                        }).toList(),
                                      ),
                                    )),
                                SizedBox(
                                  height: 5,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Expanded(
                                      child: BasicTimeField(
                                        label: 'From :',
                                        selectedTime: fromTime,
                                        fun: () async {
                                          final time = await _showTimePicker();
                                          setState(() {
                                            fromTime = time;
                                          });
                                        },
                                      ),
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Expanded(
                                        child: BasicTimeField(
                                      selectedTime: toTime,
                                      fun: () async {
                                        final time = await _showTimePicker();
                                        setState(() {
                                          toTime = time;
                                        });
                                      },
                                      label: 'To :',
                                    )),
                                  ],
                                ),
                                Padding(
                                  padding: EdgeInsets.symmetric(vertical: 7),
                                  child: Text(
                                    '$_clinicError',
                                    maxLines: 2,
                                    style: TextStyle(
                                        color: Colors.red.withOpacity(.8),
                                        fontSize: 13),
                                  ),
                                ),
                                Center(
                                  child: RoundedButton(
                                    fun: _addDoctorDate,
                                    text: 'Add Date',
                                    borderRadious: 10,
                                    minWdthRatio: .5,
                                  ),
                                ),
                              ])
                        : Center(
                            child: Container(
                                margin: EdgeInsets.symmetric(vertical: 115),
                                width: 30,
                                height: 30,
                                child: CircularProgressIndicator(
                                  valueColor: AlwaysStoppedAnimation<Color>(
                                      darkBlueColor),
                                ))),
                  ],
                ),
              ),
              Container(
                  width: MediaQuery.of(context).size.width,
                  margin: EdgeInsets.symmetric(
                    vertical: 15,
                  ),
                  padding: EdgeInsets.symmetric(horizontal: 14, vertical: 20),
                  decoration: BoxDecoration(
                    color: backGroundColor,
                    border: Border.all(
                        width: 1, color: Color(0xff707070).withOpacity(.15)),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Row(
                        children: [
                          Text(
                            'Your Clinic Dates :',
                            style: TextStyle(
                                color: darkBlueColor,
                                fontSize: 19,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 5, bottom: 10),
                        child: Divider(
                          thickness: 3,
                        ),
                      ),
                      FutureBuilder<dynamic>(
                          future: _loadDoctorDates(),
                          builder: (BuildContext context,
                              AsyncSnapshot<dynamic> snapshot) {
                            if (!snapshot.hasData && !snapshot.hasError) {
                              return Center(
                                  child: Container(
                                child: CircularProgressIndicator(
                                  valueColor:
                                      AlwaysStoppedAnimation(darkBlueColor),
                                ),
                                width: 30,
                                height: 30,
                                margin: EdgeInsets.all(30),
                              ));
                            } else {
                              if (snapshot.hasError) {
                                return Padding(
                                  padding: EdgeInsets.all(10),
                                  child: Column(
                                    children: [
                                      IconButton(
                                          icon: Icon(
                                            Icons.refresh,
                                            color: primaryColor,
                                            size: 33,
                                          ),
                                          onPressed: () {
                                            setState(() {
                                              _loadDoctorDates();
                                            });
                                          }),
                                      SizedBox(
                                        height: 5,
                                      ),
                                      Text(
                                        'Failed To Load',
                                        style: TextStyle(
                                          color: subTextColor,
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              } else {
                                return snapshot.data.currentUser.availableDates
                                                .length !=
                                            0 &&
                                        snapshot.data.currentUser.availableDates
                                                .length !=
                                            null
                                    ? ListView.builder(
                                        physics: NeverScrollableScrollPhysics(),
                                        padding: EdgeInsets.all(0),
                                        shrinkWrap: true,
                                        itemCount: snapshot.data.currentUser
                                            .availableDates.length,
                                        itemBuilder: (ctx, index) {
                                          return Container(
                                            height: 60,
                                            width: MediaQuery.of(context)
                                                .size
                                                .width,
                                            padding: EdgeInsets.fromLTRB(
                                                15, 10, 5, 10),
                                            margin: EdgeInsets.symmetric(
                                                vertical: 5),
                                            child: Row(
                                              children: [
                                                Icon(Icons.access_time,
                                                    color: darkBlueColor),
                                                SizedBox(
                                                  width: 10,
                                                ),
                                                Expanded(
                                                  child: Text(
                                                    '${snapshot.data.currentUser.availableDates[index].day}, ${snapshot.data.currentUser.availableDates[index].startTime} - ${snapshot.data.currentUser.availableDates[index].endTime},',
                                                    maxLines: 3,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    style: TextStyle(
                                                        color: darkBlueColor),
                                                  ),
                                                ),
                                                _deleteDocDateLoading != index
                                                    ? CircleButton(
                                                        color: subTextColor,
                                                        // fun: (){},
                                                        fun: () {
                                                          setState(() {
                                                            _deleteDocDateLoading =
                                                                index;
                                                          });
                                                          _deleteDate(
                                                              dateId: snapshot
                                                                  .data
                                                                  .currentUser
                                                                  .availableDates[
                                                                      index]
                                                                  .id);
                                                        },
                                                        icn: Icons
                                                            .delete_outline,
                                                      )
                                                    : Container(
                                                        margin:
                                                            EdgeInsets.all(10),
                                                        width: 20,
                                                        height: 20,
                                                        child:
                                                            CircularProgressIndicator
                                                                .adaptive(
                                                          valueColor:
                                                              AlwaysStoppedAnimation<
                                                                      Color>(
                                                                  subTextColor),
                                                        ),
                                                      ),
                                              ],
                                            ),
                                            decoration: BoxDecoration(
                                                color: Colors.white,
                                                borderRadius:
                                                    BorderRadius.circular(15)),
                                          );
                                        })
                                    : Text(
                                        'No Dates yet , add dates below',
                                        style: TextStyle(color: subTextColor),
                                      );
                              }
                            }
                          }),
                    ],
                  )),
            ],
          ),
        ),
      ),
    );
  }
}

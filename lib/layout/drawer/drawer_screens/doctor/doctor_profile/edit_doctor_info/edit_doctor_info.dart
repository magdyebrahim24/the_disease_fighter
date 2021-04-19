import 'dart:io';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:the_disease_fighter/material/bottons/roundedBtn.dart';
import 'package:the_disease_fighter/material/constants.dart';
import 'package:the_disease_fighter/material/widgets/time-date-field.dart';
import '../doctor_profile.dart';

// ignore: must_be_immutable
class EditDoctorProfile extends StatefulWidget {
  @override
  _EditDoctorProfileState createState() => _EditDoctorProfileState();
}

class _EditDoctorProfileState extends State<EditDoctorProfile> {
  String phone = '';
  String email = '';
  String address = '';
  String? day;
  DateTime? fromTime;
  DateTime? toTime;
  Map clinicDates = {
    1: {'day': 'sunday', 'from': '05:30 PM', 'to': '05:30 PM'}
  };
  int x = 2;

  _getDay(String? val) {
    setState(() {
      day = val;
    });
  }

  _getTimeFrom(val) {
    setState(() {
      fromTime = val;
    });
  }

  _getTimeTo(val) {
    setState(() {
      toTime = val;
    });
  }

  _getPhone(String email) {
    setState(() {
      this.phone = email;
    });
  }

  _getEmail(String email) {
    setState(() {
      this.email = email;
    });
  }

  _getAddress(String email) {
    setState(() {
      this.address = email;
    });
  }

  File? _pickerImage;
  final ImagePicker _picker = ImagePicker();

  void _pickImage(ImageSource src) async {
    final pickedImageFile = await _picker.getImage(source: src);
    if (pickedImageFile != null) {
      setState(() {
        _pickerImage = File(pickedImageFile.path);
      });
    } else {
      print('No Image Selected');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              _profilePicCard(context),
              item(
                  label: 'Phone Number',
                  initialValue: '01552154105',
                  hintText: 'write your phone',
                  fun: _getPhone,
                  textInputType: TextInputType.phone),
              item(
                  label: 'Email',
                  initialValue: 'magdyebrahim224@yahoo.com',
                  hintText: 'write your email',
                  fun: _getEmail,
                  textInputType: TextInputType.emailAddress),
              item(
                  label: 'Clinic Address',
                  initialValue: 'Mansoura - Meet Mazah',
                  hintText: 'write your address',
                  fun: _getAddress,
                  textInputType: TextInputType.streetAddress),
              Container(
                margin: EdgeInsets.symmetric(
                  vertical: 7,
                  horizontal: 12,
                ),
                padding: EdgeInsets.symmetric(horizontal: 14, vertical: 15),
                decoration: BoxDecoration(
                  color: backGroundColor,
                  border: Border.all(
                      width: 1, color: Color(0xff707070).withOpacity(.15)),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    for (var i = 1; i <= x - 1; i++)
                      x != 1
                          ? Container(
                              width: MediaQuery.of(context).size.width,
                              padding: EdgeInsets.symmetric(
                                  vertical: 17, horizontal: 15),
                              margin: EdgeInsets.symmetric(vertical: 5),
                              child: Row(
                                children: [
                                  Icon(Icons.access_time, color: darkBlueColor),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Text(
                                    '${clinicDates[i]['day']}, ${clinicDates[i]['from']} - ${clinicDates[i]['to']},',
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(color: darkBlueColor),
                                  ),
                                ],
                              ),
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(15)),
                            )
                          : SizedBox(),
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 5),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Day Clinic Open In :',
                            style:
                                TextStyle(fontSize: 15, color: darkBlueColor),
                          ),
                          Container(
                              margin: EdgeInsets.symmetric(
                                vertical: 7,
                              ),
                              padding: EdgeInsets.all(15),
                              decoration: BoxDecoration(
                                  border: Border.all(
                                      width: 1,
                                      color:
                                          Color(0xff707070).withOpacity(.15)),
                                  borderRadius: BorderRadius.circular(10),
                                  color: Colors.white),
                              height: 52,
                              width: MediaQuery.of(context).size.width,
                              child: DropdownButtonHideUnderline(
                                child: DropdownButton<String>(
                                  onChanged: _getDay,
                                  value: day,
                                  elevation: 1,
                                  hint: Text(
                                    'Select Day Clinic Open In',
                                    style: TextStyle(color: subTextColor),
                                  ),
                                  icon: Icon(Icons.arrow_drop_down,
                                      color: darkBlueColor.withOpacity(.7)),
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
                                            fontSize: 15, color: darkBlueColor),
                                      ),
                                    );
                                  }).toList(),
                                ),
                              )),
                        ],
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                            width: MediaQuery.of(context).size.width * .35,
                            child: BasicTimeField(
                              backgroundColor: Colors.white,
                              labelColor: darkBlueColor,
                              label: 'From :',
                              fun: _getTimeFrom,
                              helperText: 'Enter Time Clinic Opens In',
                            )),
                        SizedBox(
                          width: 10,
                        ),
                        SizedBox(
                            width: MediaQuery.of(context).size.width * .35,
                            child: BasicTimeField(
                              backgroundColor: Colors.white,
                              labelColor: darkBlueColor,
                              label: 'To :',
                              fun: _getTimeTo,
                              helperText: 'Enter Time Clinic Close In',
                            )),
                      ],
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 15),
                      child: RoundedButton(
                        fun: () {
                          var from = fromTime.toString().split(' ');
                          var to = toTime.toString().split(' ');
                          var fromTimee = from[1];
                          var toTimee = to[1];
                          var clinicDate = {
                            'day': day,
                            'from': fromTimee,
                            'to': toTimee
                          };
                          clinicDates.addAll({x: clinicDate});
                          setState(() {
                            x++;
                          });
                        },
                        text: 'Add',
                        borderRadious: 10,
                        minWdthRatio: .8,
                      ),
                    ),
                  ],
                ),
              ),
            ]),
      ),
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
                shape: RoundedRectangleBorder(
                  side: BorderSide(color: subTextColor),
                  borderRadius: BorderRadius.circular(50),
                ),
                onPressed: () => Navigator.pop(context),
                child: Text(
                  'Cancel',
                  style: TextStyle(fontSize: 16, color: subTextColor),
                ),
              ),
              SizedBox(
                width: 10,
              ),
              RoundedButton(
                minWdthRatio: .5,
                fun: () => Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (ctx) => DoctorProfile())),
                text: 'Save',
                borderRadious: 50,
              ),
            ],
          ),
        ),
        elevation: 0.0,
      ),
    );
  }

  Widget item({required label, hintText, fun, initialValue, textInputType}) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10, horizontal: 12),
      padding: EdgeInsets.only(top: 15, left: 15, right: 15, bottom: 10),
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: backGroundColor,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label),
          Container(
            margin: EdgeInsets.symmetric(vertical: 7),
            padding: EdgeInsets.symmetric(horizontal: 10),
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.white,
            ),
            child: Row(
              children: [
                Expanded(
                  child: TextFormField(
                      initialValue: initialValue,
                      decoration: InputDecoration(
                        hintText: hintText,
                        hintStyle: TextStyle(
                          color: subTextColor.withOpacity(.6),
                        ),
                        border: InputBorder.none,
                      ),
                      keyboardType: textInputType,
                      cursorColor: primaryColor,
                      style: TextStyle(color: darkBlueColor.withOpacity(.8)),
                      onChanged: fun),
                ),
                Icon(
                  Icons.edit_outlined,
                  size: 17,
                  color: darkBlueColor,
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _profilePicCard(BuildContext context) {
    return Stack(
      children: [
        Container(
          width: MediaQuery.of(context).size.width,
          height: 130,
          decoration: BoxDecoration(
              color: primaryColor.withOpacity(.1),
              borderRadius: BorderRadius.only(
                bottomRight: Radius.circular(40),
                bottomLeft: Radius.circular(40),
              )),
        ),
        Padding(
          padding: EdgeInsets.only(top: 60.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Column(
                children: [
                  InkWell(
                    onTap: () => _showModalBottomSheet(),
                    child: Stack(
                      fit: StackFit.loose,
                      children: [
                        Container(
                          margin: EdgeInsets.only(bottom: 10),
                          decoration: BoxDecoration(
                              boxShadow: [
                                BoxShadow(
                                    color: subTextColor,
                                    offset: Offset(0.0, 1.0),
                                    blurRadius: 6.0,
                                    spreadRadius: 1),
                              ],
                              image: DecorationImage(
                                  image:
                                      (_pickerImage == null
                                              ? AssetImage(
                                                  "assets/images/img_1.png")
                                              : FileImage(_pickerImage!))
                                          as ImageProvider<Object>,
                                  fit: BoxFit.cover),
                              shape: BoxShape.circle,
                              border: Border.all(
                                  color: Color(0xffFDFDFD), width: 2),
                              color: backGroundColor),
                          height: 145,
                          width: 145,
                        ),
                        Positioned(
                          bottom: 25,
                          right: 4,
                          child: Container(
                            alignment: Alignment.center,
                            width: 30,
                            height: 30,
                            decoration: BoxDecoration(
                                shape: BoxShape.circle, color: backGroundColor),
                            child: Icon(
                              Icons.add_a_photo_rounded,
                              size: 13,
                              color: darkBlueColor,
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  Text(
                    "ALia Ahmed Ali",
                    style: TextStyle(
                      color: darkBlueColor,
                      fontSize: 23,
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  _showModalBottomSheet() {
    return showModalBottomSheet(
        context: context,
        backgroundColor: Colors.transparent,
        builder: (builder) {
          return Container(
            height: 250,
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(25.0),
                    topRight: Radius.circular(25.0))),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  BottomSheetItem(
                    label: 'Take New Profile Picture',
                    icon: Icons.camera_alt_rounded,
                    fun: () => _pickImage(ImageSource.camera),
                  ),
                  BottomSheetItem(
                    label: 'Select Picture From Gallery',
                    icon: Icons.photo_library_outlined,
                    fun: () => _pickImage(ImageSource.gallery),
                  ),
                  BottomSheetItem(
                    label: 'Delete Profile Picture',
                    icon: FontAwesomeIcons.solidTrashAlt,
                    fun: () {},
                  ),
                ],
              ),
            ),
          );
        });
  }
}

class BottomSheetItem extends StatelessWidget {
  final label;
  final icon;
  final fun;

  const BottomSheetItem({
    this.label,
    this.icon,
    this.fun,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.only(left: 40, bottom: 10),
      onTap: fun,
      leading: Container(
        width: 45,
        height: 45,
        decoration: BoxDecoration(
            color: backGroundColor, borderRadius: BorderRadius.circular(10)),
        child: Icon(
          icon,
          color: darkBlueColor,
        ),
      ),
      title: Text(
        label,
        style: TextStyle(
            color: darkBlueColor, fontSize: 16, fontWeight: FontWeight.w700),
      ),
    );
  }
}
import 'dart:io';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:the_disease_fighter/localizations/localization/language/languages.dart';
import 'package:the_disease_fighter/material/bottons/circleBtn.dart';
import 'package:the_disease_fighter/material/bottons/roundedBtn.dart';
import 'package:the_disease_fighter/material/constants.dart';

// ignore: must_be_immutable
class PatientProfile extends StatefulWidget {
  @override
  _PatientProfileState createState() => _PatientProfileState();
}

class _PatientProfileState extends State<PatientProfile> {
  String phone = '';
  String email = '';
  String address = '';
  bool readOnly = true;

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
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: primaryColor.withOpacity(.1),
        leading: readOnly
            ? CircleButton(
                color: primaryColor,
                fun: () => Navigator.pop(context),
                icn: Icons.arrow_back,
              )
            : SizedBox(),
        actions: [
          readOnly
              ? IconButton(
                  color: primaryColor,
                  icon: Icon(
                    FontAwesomeIcons.solidEdit,
                    size: 20,
                  ),
                  onPressed: () {
                    setState(() {
                      if (readOnly = true) {
                        setState(() {
                          readOnly = false;
                        });
                      }
                    });
                  },
                )
              : SizedBox(),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              _profilePicCard(context),
              item(
                label: Languages.of(context)!.patientProfile['phoneLabel'],
                initialValue: '01552154105',
                hintText: Languages.of(context)!.patientProfile['phoneHint'],
                fun: _getPhone,
                textInputType: TextInputType.phone,
                readOnly: readOnly,
              ),
              item(
                  label: Languages.of(context)!.patientProfile['email'],
                  initialValue: 'magdyebrahim224@yahoo.com',
                  hintText: Languages.of(context)!.patientProfile['emailHint'],
                  fun: _getEmail,
                  readOnly: readOnly,
                  textInputType: TextInputType.emailAddress),
              item(
                  label: Languages.of(context)!.patientProfile['addressLabel'],
                  initialValue: 'Mansoura - Meet Mazah',
                  hintText:
                      Languages.of(context)!.patientProfile['addressHint'],
                  fun: _getAddress,
                  readOnly: readOnly,
                  textInputType: TextInputType.streetAddress),
              readOnly
                  ? Row(
                      children: [
                        Expanded(
                          child: item(
                              label: Languages.of(context)!
                                  .patientProfile['DateLabel'],
                              initialValue: '1/3/1999',
                              readOnly: true,
                              hintText: Languages.of(context)!
                                  .patientProfile['helperText'],
                              fun: _getAddress,
                              textInputType: TextInputType.streetAddress),
                        ),
                        Expanded(
                          child: item(
                              label: Languages.of(context)!
                                  .patientProfile['genderLabel'],
                              initialValue: 'Male',
                              readOnly: true,
                              hintText: Languages.of(context)!
                                  .patientProfile['genderHint'],
                              fun: _getAddress,
                              textInputType: TextInputType.streetAddress),
                        ),
                      ],
                    )
                  : SizedBox(
                      height: 10,
                    ),
            ]),
      ),
      bottomNavigationBar: !readOnly
          ? BottomAppBar(
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
                      onPressed: () {
                        setState(() {
                          readOnly = true;
                        });
                      },
                      child: Text(
                        Languages.of(context)!.patientProfile['cancelBtn'],
                        style: TextStyle(fontSize: 16, color: subTextColor),
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    RoundedButton(
                      minWdthRatio: .5,
                      fun: () {
                        setState(() {
                          readOnly = true;
                        });
                      },
                      text: Languages.of(context)!.patientProfile['saveBtn'],
                      borderRadious: 50,
                    ),
                  ],
                ),
              ),
              elevation: 0.0,
            )
          : SizedBox(),
    );
  }

  Widget item(
      {required label,
      hintText,
      fun,
      initialValue,
      textInputType,
      required readOnly}) {
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
                      readOnly: readOnly,
                      style: TextStyle(color: darkBlueColor.withOpacity(.8)),
                      onChanged: fun),
                ),
                !readOnly
                    ? Icon(
                        Icons.edit_outlined,
                        size: 17,
                        color: darkBlueColor,
                      )
                    : SizedBox()
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
          height: 85,
          decoration: BoxDecoration(
              color: primaryColor.withOpacity(.1),
              borderRadius: BorderRadius.only(
                bottomRight: Radius.circular(40),
                bottomLeft: Radius.circular(40),
              )),
        ),
        Padding(
          padding: EdgeInsets.only(top: 10.0),
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
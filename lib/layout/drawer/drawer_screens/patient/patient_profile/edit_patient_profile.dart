import 'dart:io';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:the_disease_fighter/layout/drawer/drawer_screens/doctor/doctor_profile/edit_doctor_info/edit_doctor_info.dart';
import 'package:the_disease_fighter/layout/drawer/drawer_screens/patient/patient_profile/patient_profile.dart';
import 'package:the_disease_fighter/localizations/localization/language/languages.dart';
import 'package:the_disease_fighter/material/bottons/circleBtn.dart';
import 'package:the_disease_fighter/material/bottons/roundedBtn.dart';
import 'package:the_disease_fighter/material/constants.dart';
import 'package:the_disease_fighter/material/inductors/loader_dialog.dart';
import 'package:the_disease_fighter/services/logged_user/get_user_info_controller.dart';
import 'package:the_disease_fighter/services/logged_user/update_avatar.dart';
import 'package:the_disease_fighter/services/logged_user/update_patient_profile.dart';

// ignore: must_be_immutable
class EditPatientProfile extends StatefulWidget {
  final data;
  const EditPatientProfile({this.data});
  @override
  _EditPatientProfileState createState() => _EditPatientProfileState();
}

class _EditPatientProfileState extends State<EditPatientProfile> {
  CurrentUserInfoController _userInfoController = CurrentUserInfoController();
  UpdatePatientProfileController _updatePatientProfileController =
      UpdatePatientProfileController();
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String? phone;
  String? address;
  String? name;
  File? _pickerImage;
  String? errorMessage;
  UpdateAvatarController _updateAvatar = UpdateAvatarController();

  Future _updatePatientProfile() async {
    _formKey.currentState!.validate();
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      LoaderDialog().onLoading(context);
      final data = await _updatePatientProfileController.updatePatientProfile(
        location: address,
        phone: phone,
        name: name,
        dob: widget.data.dob.toString(),
        gender: widget.data.gender.toString(),
      );
      if (await data['success']) {
        Navigator.of(context).pop();
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => PatientProfile()));
      } else {
        setState(() {
          errorMessage = data['message'].toString();
        });

        // Navigator.of(context).pop();

      }
    }
  }

  Future _updateAvatarFun() async {
    if (_pickerImage != null) {
      final data = await _updateAvatar.updateAvatar(
        file: _pickerImage,
      );
    }
  }

  _getPhone(String value) {
    setState(() {
      this.phone = value;
    });
  }

  _getAddress(String value) {
    setState(() {
      this.address = value;
    });
  }

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
  void initState() {
    super.initState();
    phone = widget.data.phone.toString();
    address = widget.data.location.toString();
    name = widget.data.name.toString();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
            elevation: 0.0,
            backgroundColor: primaryColor.withOpacity(.1),
            leading: CircleButton(
              color: primaryColor,
              fun: () => Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) => PatientProfile())),
              icn: Icons.arrow_back,
            )),
        body: SingleChildScrollView(
            child: Form(
          key: _formKey,
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                _profilePicCard(
                  context,
                  imgUrl: widget.data.avatar.toString(),
                ),
                SizedBox(
                  height: 20,
                ),
                item(
                  validateFun: (value) {
                    if (value.toString().isEmpty) {
                      return 'Name Required';
                    }
                  },
                  label: "Name",
                  initialValue: widget.data.name.toString(),
                  hintText: "Enter your Name",
                  fun: (value) {
                    setState(() {
                      name = value;
                    });
                  },
                  textInputType: TextInputType.name,
                  readOnly: false,
                ),
                item(
                  validateFun: (value) {
                    if (value.toString().isEmpty) {
                      return 'Phone Required';
                    }
                  },
                  label: Languages.of(context)!.patientProfile['phoneLabel'],
                  initialValue: widget.data.phone.toString(),
                  hintText: Languages.of(context)!.patientProfile['phoneHint'],
                  fun: _getPhone,
                  textInputType: TextInputType.phone,
                  readOnly: false,
                ),
                item(
                    validateFun: (value) {
                      if (value.toString().isEmpty) {
                        return 'Address Required';
                      }
                    },
                    label:
                        Languages.of(context)!.patientProfile['addressLabel'],
                    initialValue: widget.data.location.toString(),
                    hintText:
                        Languages.of(context)!.patientProfile['addressHint'],
                    fun: _getAddress,
                    readOnly: false,
                    textInputType: TextInputType.streetAddress),
              ]),
        )),
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
                  onPressed: () {
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => PatientProfile()));
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
                    if (_pickerImage != null) {
                      _updateAvatarFun();
                    }
                    _updatePatientProfile();
                    // Navigator.pop(context);
                  },
                  text: Languages.of(context)!.patientProfile['saveBtn'],
                  borderRadious: 50,
                ),
              ],
            ),
          ),
          elevation: 0.0,
        ));
  }

  Widget item(
      {required label,
      validateFun,
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
                    onChanged: fun,
                    validator: validateFun,
                  ),
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

  Widget _profilePicCard(BuildContext context, {imgUrl}) {
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
              InkWell(
                onTap: () {
                  _showModalBottomSheet();
                },
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
                                  // ignore: unnecessary_null_comparison
                                  (_pickerImage == null
                                          ? NetworkImage(imgUrl.toString())
                                          : FileImage(_pickerImage!))
                                      as ImageProvider<Object>,
                              fit: BoxFit.cover),
                          shape: BoxShape.circle,
                          border:
                              Border.all(color: Color(0xffFDFDFD), width: 2),
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
                      fun: () {
                        _pickImage(ImageSource.camera);
                        Navigator.pop(context);
                      }),
                  BottomSheetItem(
                      label: 'Select Picture From Gallery',
                      icon: Icons.photo_library_outlined,
                      fun: () {
                        _pickImage(ImageSource.gallery);
                        Navigator.pop(context);
                      }),
                  BottomSheetItem(
                    label: 'Delete Profile Picture',
                    icon: FontAwesomeIcons.solidTrashAlt,
                    fun: () {
                      Navigator.pop(context);
                    },
                  ),
                ],
              ),
            ),
          );
        });
  }
}

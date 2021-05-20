import 'dart:io';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:the_disease_fighter/localizations/localization/language/languages.dart';
import 'package:the_disease_fighter/material/bottons/roundedBtn.dart';
import 'package:the_disease_fighter/material/constants.dart';
import 'package:the_disease_fighter/material/inductors/loader_dialog.dart';
import 'package:the_disease_fighter/material/widgets/bottom_sheet_item.dart';
import 'package:the_disease_fighter/material/widgets/materialBanner.dart';
import 'package:the_disease_fighter/material/widgets/time-date-field.dart';
import 'package:the_disease_fighter/services/logged_user/controllers/getDoctorData.dart';
import 'package:the_disease_fighter/services/logged_user/controllers/updateDoctorInfo.dart';
import 'package:the_disease_fighter/services/logged_user/controllers/update_avatar.dart';
import '../doctor_profile.dart';

// ignore: must_be_immutable
class EditDoctorProfile extends StatefulWidget {
  final data;

  const EditDoctorProfile({Key? key, this.data}) : super(key: key);
  @override
  _EditDoctorProfileState createState() => _EditDoctorProfileState();
}

class _EditDoctorProfileState extends State<EditDoctorProfile> {
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  CurrentDoctorController _doctorController = CurrentDoctorController();
  UpdateAvatarController _updateAvatar = UpdateAvatarController();
  UpdateDoctorInfoController _updateDoctorInfoController =
      UpdateDoctorInfoController();
  String? phone;
  String? email;
  String? clinicLocation;
  String? day;
  String? name;
  File? _pickerImage;
  String? errorMessage;
  DateTime? fromTime;
  DateTime? toTime;
  String? about;
  String? _bannerMessage;
  bool _showBanner = false;

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

  _getPhone(String phone) {
    setState(() {
      this.phone = phone;
    });
  }

  _getName(String name) {
    setState(() {
      this.name = name;
    });
  }

  _getAbout(String about) {
    setState(() {
      this.about = about;
    });
  }

  _getAddress(String clinicLocation) {
    setState(() {
      this.clinicLocation = clinicLocation;
    });
  }

  Future _updateAvatarFun() async {
    if (_pickerImage != null) {
      final data = await _updateAvatar.updateAvatar(
        file: _pickerImage,
      );
    }
  }

  Future _updatePatientProfile() async {
    _showBanner = false;
    _formKey.currentState!.validate();
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      LoaderDialog().onLoading(context);
      final data = await _updateDoctorInfoController.updateDoctorInfo(
          name: name.toString(),
          about: about.toString(),
          clinicLocation: clinicLocation.toString(),
          phone: phone.toString(),
          email: email.toString(),
          gender: widget.data.gender.toString(),
          dob: widget.data.dob.toString(),
          //about: widget.data.about.toString(),
          specId: widget.data.specId.toString());


      if (await data['success']) {
        Navigator.of(context).pop();
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => DoctorProfile()));
      } else {
        setState(() {
            _bannerMessage = data['message'].toString();
            _showBanner = true;
          errorMessage = data['message'].toString();
        });

         Navigator.of(context).pop();

      }
    }
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
    clinicLocation = widget.data.clinicLocation.toString();
    name = widget.data.name.toString();
    about=widget.data.about.toString();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Scaffold(
          backgroundColor: Colors.white,
          body: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    _profilePicCard(
                      context,
                      widget.data.avatar.toString(),
                      widget.data.name.toString(),
                    ),
                    item(
                        validateFun: (value) {
                          if (value.toString().isEmpty) {
                            return 'About Required';
                          }
                        },
                        fun: _getAbout,
                        label: Languages.of(context)!.doctorProfile['editProfile']
                        ['phoneLabel'],
                        initialValue: widget.data.about.toString(),
                        hintText: Languages.of(context)!
                            .doctorProfile['editProfile']['phoneHint'],
                        textInputType: TextInputType.phone),
                    /*item(
                      validateFun: (value) {
                        if (value.toString().isEmpty) {
                          return 'About Required';
                        }
                      },
                      label: "About",
                      initialValue: widget.data.about.toString(),
                      hintText: "add a new information about you",
                      fun:  _getAbout,
                      textInputType: TextInputType.name,
                    ),*/
                    /*Container(
                      margin: EdgeInsets.symmetric(vertical: 10, horizontal: 12),
                      padding: EdgeInsets.only(top: 15, left: 15, right: 15, bottom: 40),
                      //padding: EdgeInsets.symmetric(horizontal: 20, vertical: 30),
                      //height: 110,
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: backGroundColor,
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "About",
                            //style: TextStyle(
                             //   color: darkBlueColor,
                              //  fontSize: 12,
                              //  fontWeight: FontWeight.bold),
                          ),
                          SizedBox(height: 10,),
                          Text(
                            widget.data.about.toString(),
                            style: TextStyle(
                              fontSize: 13,
                              color: subTextColor,
                            ),
                          ),

                        ],
                      ),
                    ),*/
                    item(
                        validateFun: (value) {
                          if (value.toString().isEmpty) {
                            return 'Phone Required';
                          }
                        },
                        fun: _getPhone,
                        label: Languages.of(context)!.doctorProfile['editProfile']
                            ['phoneLabel'],
                        initialValue: widget.data.phone.toString(),
                        hintText: Languages.of(context)!
                            .doctorProfile['editProfile']['phoneHint'],
                        textInputType: TextInputType.phone),
                    item(
                        validateFun: (value) {
                          if (value.toString().isEmpty) {
                            return 'Name Required';
                          }
                        },
                        label: "name",
                        //Languages.of(context)!.doctorProfile['editProfile']
                           // ['name'],
                        initialValue: widget.data.name.toString(),
                        hintText: Languages.of(context)!
                            .doctorProfile['editProfile']['nameHint'],
                        fun: _getName,
                        textInputType: TextInputType.emailAddress),
                    item(
                        validateFun: (value) {
                          if (value.toString().isEmpty) {
                            return 'Clinic Location is Required';
                          }
                        },
                        label: Languages.of(context)!.doctorProfile['editProfile']
                            ['clinicAddressLabel'],
                        initialValue: widget.data.clinicLocation.toString(),
                        hintText: Languages.of(context)!
                            .doctorProfile['editProfile']['clinicAddressHint'],
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
                                        Icon(Icons.access_time,
                                            color: darkBlueColor),
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
                                                  fontSize: 15,
                                                  color: darkBlueColor),
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
                    onPressed: () => Navigator.pushReplacement(context,
                        MaterialPageRoute(builder: (context) => DoctorProfile())),
                    child: Text(
                      Languages.of(context)!.doctorProfile['editProfile']
                          ['cancelBtn'],
                      style: TextStyle(fontSize: 16, color: subTextColor),
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  RoundedButton(
                    minWdthRatio: .5,
                    fun: () {
                      //Navigator.pushReplacement(context,
                      //MaterialPageRoute(builder: (ctx) => DoctorProfile())),
                      if (_pickerImage != null) {
                        _updateAvatarFun();
                      }
                      _updatePatientProfile();
                    },
                    text: Languages.of(context)!.doctorProfile['editProfile']
                        ['saveBtn'],
                    borderRadious: 50,
                  ),
                ],
              ),
            ),
            elevation: 0.0,
          ),

        ),
        _showBanner?SizedBox(
          height: 150,
          child: ErrorMaterialBanner(fun:() {
            setState(() {
              _showBanner=false;
            });

          },errorMessage: _bannerMessage,),
        ):SizedBox()
      ],
    );

  }


  Widget item({
    required label,
    hintText,
    fun,
    initialValue,
    textInputType,
    validateFun,
  }) {
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
          Text(label.toString()),
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
                    onChanged: fun,
                    validator: validateFun,
                  ),
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

  Widget _profilePicCard(BuildContext context, imgUrl, name) {
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
                    onTap: (){ _showModalBottomSheet();},
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
                    name.toString(),
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

/*class BottomSheetItem extends StatelessWidget {
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
}*/
